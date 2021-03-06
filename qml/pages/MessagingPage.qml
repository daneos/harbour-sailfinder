/*
*   This file is part of Sailfinder.
*
*   Sailfinder is free software: you can redistribute it and/or modify
*   it under the terms of the GNU General Public License as published by
*   the Free Software Foundation, either version 3 of the License, or
*   (at your option) any later version.
*
*   Sailfinder is distributed in the hope that it will be useful,
*   but WITHOUT ANY WARRANTY; without even the implied warranty of
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*   GNU General Public License for more details.
*
*   You should have received a copy of the GNU General Public License
*   along with Sailfinder.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.2
import Sailfish.Silica 1.0
import "../components"
import "../js/util.js" as Util

Page {
    id: page

    property string name
    property date birthDate
    property int gender
    property string avatar
    property string matchId
    property string userId
    property int distance
    property var match

    Component.onCompleted: api.getMessages(matchId)

    Connections {
        target: api
        onMessagesChanged: {
            console.debug("Messages received")
            console.debug(api.messages)
            messagesListView.model = api.messages
            noMessagesPlaceholder.enabled = (messagesListView.count == 0)
            busyStatus.running = false
        }

        onNewMessage: {
            if(count > 0) { // Messages from other people needs updating, not our own
                api.getMessages(matchId)
            }
            noMessagesPlaceholder.enabled = messagesListView.count == 0
            busyStatus.running = false
        }
    }

    Timer {
        // This is a workaround for the broken signal of Qt.inputMethod
        id: scrollDelay
        interval: 500 // A wild guess for the duration of the Sailfish OS keyboard
        running: false
        repeat: false
        onTriggered: messagesListView.scrollToBottom()
    }

    MessagingHeader {
        id: messagingHeader
        name: page.name
        birthDate: page.birthDate
        gender: page.gender
        avatar: page.avatar
        distance: page.distance
        onClicked: pageStack.push(Qt.resolvedUrl("MatchProfilePage.qml"), {match: match})
    }

    SilicaListView {
        id: messagesListView
        width: parent.width
        anchors {
            top: messagingHeader.bottom // Conflicts with header property
            topMargin: Theme.paddingMedium
            bottom: bar.top
            bottomMargin: Theme.paddingMedium
            left: parent.left
            leftMargin: Theme.horizontalPageMargin/2
            right: parent.right
            rightMargin: Theme.horizontalPageMargin/2
        }
        clip: true
        spacing: Theme.paddingMedium
        delegate: MessagingDelegate {
            width: ListView.view.width*0.75
        }
        onCountChanged: messagesListView.currentIndex = messagesListView.count - 1

        VerticalScrollDecorator {}
    }

    MessagingBar {
        id: bar
        anchors { bottom: parent.bottom; left: parent.left; right: parent.right }
        //% "Say hi to %0!"
        placeHolderText: qsTrId("sailfinder-messaging-placeholder").arg(name)
        onSendText: {
            busyStatus.running = Qt.application.active
            console.debug("NOT EMPTY=" + match)
            api.sendMessage(matchId, text, userId, Math.random().toString())
            console.debug("EMPTY=" + match)
        }
        onSendGIF: {
            busyStatus.running = Qt.application.active
            api.sendGIF(matchId, url, id, userId, Math.random().toString())
        }
        onKeyboardVisible: {
            console.debug("Keyboard opened? " + state)
            scrollDelay.restart() // Make sure we see the latest messages when the keyboard shows/hides
        }
    }

    ViewPlaceholder {
        id: noMessagesPlaceholder
        anchors.centerIn: parent
        //% "No messages yet :-("
        text: qsTrId("sailfinder-no-messages-text")
        //% "Be the first one to start the conversation!"
        hintText: qsTrId("sailfinder-no-messages-hint")
    }

    BusyIndicator {
        id: busyStatus
        anchors.centerIn: parent
        size: BusyIndicatorSize.Large
        running: Qt.application.active
    }
}

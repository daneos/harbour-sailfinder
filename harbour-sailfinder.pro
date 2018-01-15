#
#   This file is part of Sailfinder.
#
#   Sailfinder is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   Sailfinder is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with Sailfinder.  If not, see <http://www.gnu.org/licenses/>.
#

# The name of your application
TARGET = harbour-sailfinder

CONFIG += sailfishapp

# Disable warnings
CONFIG += warn_off

QT += core \
    network \
    positioning \
    sql

# OS module notification support
PKGCONFIG += nemonotifications-qt5
QT += dbus

# Disable debug and warning messages while releasing for security reasons
CONFIG(release, debug|release):DEFINES += QT_NO_DEBUG_OUTPUT \
QT_NO_WARNING_OUTPUT

RESOURCES += qml/resources/resources.qrc

SOURCES += src/harbour-sailfinder.cpp \
    src/api.cpp \
    src/models/person.cpp \
    src/models/photo.cpp \
    src/models/job.cpp \
    src/models/school.cpp \
    src/logger.cpp \
    src/os.cpp \
    src/models/enum.cpp \
    src/models/match.cpp \
    src/models/recommendation.cpp \
    src/models/user.cpp \
    src/models/message.cpp

DISTFILES += qml/harbour-sailfinder.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/harbour-sailfinder.changes.in \
    rpm/harbour-sailfinder.changes.run.in \
    rpm/harbour-sailfinder.spec \
    rpm/harbour-sailfinder.yaml \
    translations/*.ts \
    harbour-sailfinder.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# APP_VERSION retrieved from .spec file
DEFINES += APP_VERSION=\"\\\"$${VERSION}\\\"\"

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n \
sailfishapp_i18n_idbased

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-sailfinder-de.ts

HEADERS += \
    src/api.h \
    src/models/person.h \
    src/models/photo.h \
    src/models/job.h \
    src/models/school.h \
    src/logger.h \
    src/os.h \
    src/models/enum.h \
    src/models/match.h \
    src/models/recommendation.h \
    src/models/user.h \
    src/models/message.h

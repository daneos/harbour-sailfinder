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

#ifndef JOBLISTMODEL_H
#define JOBLISTMODEL_H

#include <QtCore/QAbstractListModel>
#include <QtCore/QList>

#include "job.h"

class JobListModel : public QAbstractListModel
{
    Q_OBJECT

    public:
        enum Roles {
            IdRole = Qt::UserRole + 1,
            NameRole = Qt::UserRole + 2,
            TitleRole = Qt::UserRole + 3
        };

        explicit JobListModel(QList<Job *> jobList);
        explicit JobListModel();
        ~JobListModel();

        virtual int rowCount(const QModelIndex&) const;
        virtual QVariant data(const QModelIndex &index, int role) const;
        QList<Job *> jobList() const;
        void setJobList(const QList<Job *> &jobList);

protected:
        QHash<int, QByteArray> roleNames() const;

signals:
        void jobListChanged();

private:
        QList<Job *> m_jobList = QList<Job *>();
};

#endif // JOBLISTMODEL_H

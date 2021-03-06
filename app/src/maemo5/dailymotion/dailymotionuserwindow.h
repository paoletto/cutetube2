/*
 * Copyright (C) 2016 Stuart Howarth <showarth@marxoft.co.uk>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef DAILYMOTIONUSERWINDOW_H
#define DAILYMOTIONUSERWINDOW_H

#include "stackedwindow.h"
#include "dailymotionuser.h"

class Banner;
class ListView;
class TextBrowser;
class QScrollArea;
class QLabel;
class QPushButton;
class QHBoxLayout;
class QModelIndex;
class QStringListModel;

class DailymotionUserWindow : public StackedWindow
{
    Q_OBJECT
    
public:
    explicit DailymotionUserWindow(const QString &id, StackedWindow *parent = 0);
    explicit DailymotionUserWindow(const DailymotionUser *user, StackedWindow *parent = 0);
    
private:
    void loadBaseUi();
    void loadUserUi();
    
    void showFavourites();
    void showPlaylists();
    void showSubscriptions();
    void showUploads();
    
private Q_SLOTS:
    void setUserSubscription();

    void showResource(const QUrl &url);    
    void showWindow(const QModelIndex &index);
    
    void onUserStatusChanged(QDailymotion::ResourcesRequest::Status status);
    void onUserUpdateStatusChanged(QDailymotion::ResourcesRequest::Status status);
    void onUserSubscribedChanged();

private:
    DailymotionUser *m_user;
    QStringListModel *m_model;
    
    Banner *m_banner;
    ListView *m_view;
    QScrollArea *m_scrollArea;
    QLabel *m_titleLabel;
    QLabel *m_statsLabel;
    TextBrowser *m_descriptionLabel;
    QPushButton *m_subscribeButton;
    QHBoxLayout *m_layout;
};

#endif // DAILYMOTIONUSERWINDOW_H

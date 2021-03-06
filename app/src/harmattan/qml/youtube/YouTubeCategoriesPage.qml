/*
 * Copyright (C) 2016 Stuart Howarth <showarth@marxoft.co.uk>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms and conditions of the GNU General Public License,
 * version 3, as published by the Free Software Foundation.
 *
 * This program is distributed in the hope it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
 */

import QtQuick 1.1
import com.nokia.meego 1.0
import cuteTube 2.0
import QYouTube 1.0 as QYouTube
import ".."
import "file:///usr/lib/qt4/imports/com/nokia/meego/UIConstants.js" as UI

MyPage {
    id: root

    property alias model: categoryModel

    title: qsTr("Categories")
    showProgressIndicator: categoryModel.status == QYouTube.ResourcesRequest.Loading
    tools: ToolBarLayout {

        BackToolIcon {}

        MyToolIcon {
            platformIconId: "toolbar-refresh"
            enabled: categoryModel.status != QYouTube.ResourcesRequest.Loading
            onClicked: categoryModel.reload()
        }
    }

    ListView {
        id: view

        anchors.fill: parent
        cacheBuffer: 400
        highlightFollowsCurrentItem: false
        model: YouTubeCategoryModel {
            id: categoryModel

            onStatusChanged: if (status == QYouTube.ResourcesRequest.Failed) infoBanner.showMessage(errorString);
        }
        delegate: LabelDelegate {
            text: name
            onClicked: appWindow.pageStack.push(Qt.resolvedUrl("YouTubeVideosPage.qml"), {title: name})
            .model.list("/videos", ["snippet", "contentDetails", "statistics"], {chart: "mostPopular"},
                        {videoCategoryId: value, regionCode: Settings.locale.split("_")[1], maxResults: MAX_RESULTS})
        }
    }

    ScrollDecorator {
        flickableItem: view
    }

    Label {
        anchors {
            fill: parent
            margins: UI.PADDING_DOUBLE
        }
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        font.pixelSize: 60
        color: UI.COLOR_INVERTED_SECONDARY_FOREGROUND
        text: qsTr("No categories found")
        visible: (categoryModel.status >= QYouTube.ResourcesRequest.Ready) && (categoryModel.count == 0)
    }
}

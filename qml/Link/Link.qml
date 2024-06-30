// qml/Link/Link.qml
import QtQuick 2.15

Rectangle {
    width: 100
    height: 20
    color: "blue"
    border.color: "black"

    property alias linkLength: width

    Text {
        text: "Link"
        anchors.centerIn: parent
        color: "white"
    }

    MouseArea {
        anchors.fill: parent
        drag.target: parent
    }
}
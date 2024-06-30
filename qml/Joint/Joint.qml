// qml/Joint/Joint.qml
import QtQuick 2.15

Ellipse {
    width: 20
    height: 20
    color: "red"
    border.color: "black"

    Text {
        text: "Joint"
        anchors.centerIn: parent
        color: "white"
        font.pointSize: 8
    }

    MouseArea {
        anchors.fill: parent
        drag.target: parent
    }
}
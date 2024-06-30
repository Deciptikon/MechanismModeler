// qml/Motor/Motor.qml
import QtQuick 2.15

Ellipse {
    width: 30
    height: 30
    color: "green"
    border.color: "black"

    Text {
        text: "Motor"
        anchors.centerIn: parent
        color: "white"
        font.pointSize: 10
    }

    MouseArea {
        anchors.fill: parent
        drag.target: parent
    }
}
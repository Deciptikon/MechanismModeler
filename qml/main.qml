// qml/main.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: "Mechanism Modeler"

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ListView {
                id: elementList
                width: 200
                model: ["Link", "Joint", "Motor"]
                delegate: Item {
                    width: elementList.width
                    height: 40
                    Text {
                        text: modelData
                        anchors.centerIn: parent
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            designer.addElement(modelData)
                        }
                    }
                }
            }

            Rectangle {
                id: designArea
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "#e0e0e0"

                // Container for elements
                Item {
                    id: mechanismContainer
                    anchors.fill: parent
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Button {
                text: "Simulate"
                onClicked: designer.simulate()
            }
            Button {
                text: "Design"
                onClicked: designer.design()
            }
        }
    }
}
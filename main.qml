import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Shapes 1.15

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: "Mechanism Designer"

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

                Canvas {
                    id: canvas
                    anchors.fill: parent
                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, canvas.width, canvas.height)
                        for (var i = 0; i < designer.elements.length; i++) {
                            var element = designer.elements[i]
                            ctx.save()
                            ctx.translate(element.x, element.y)
                            ctx.rotate(element.rotation)
                            ctx.fillStyle = element.color
                            if (element.type === "Link") {
                                ctx.fillRect(-50, -5, 100, 10)
                            } else if (element.type === "Joint") {
                                ctx.beginPath()
                                ctx.arc(0, 0, 10, 0, Math.PI * 2)
                                ctx.fill()
                            } else if (element.type === "Motor") {
                                ctx.beginPath()
                                ctx.arc(0, 0, 15, 0, Math.PI * 2)
                                ctx.fill()
                            }
                            ctx.restore()
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        var pos = Qt.point(mouse.x, mouse.y)
                        designer.selectElement(pos)
                    }
                }
            }

            ColumnLayout {
                width: 200
                Rectangle {
                    width: parent.width
                    height: 200
                    color: "#ffffff"
                    Text {
                        id: elementDetails
                        text: "Select an element to see details"
                        anchors.centerIn: parent
                    }
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
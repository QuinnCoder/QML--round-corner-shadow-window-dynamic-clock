import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5

Page {
    header: Label {
        text: qsTr("Your Stats")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    property int num1: 10
    property int num2: 20
    property int result: 0

    Item{

            Column {
                spacing: 20
                x:10
                y:10
                TextField {
                    id: num1Field
                    text: num1.toString()
                    onTextChanged: num1 = parseInt(text)
                }

                TextField {
                    id: num2Field
                    text: num2.toString()
                    onTextChanged: num2 = parseInt(text)
                }

                Button {
                    objectName: "addBtn"
                   
                    text: "Add"
                    onClicked: result = calculator.add(num1, num2)
                }

                Label {
                    text: result.toString()
                }
            }
        }
}
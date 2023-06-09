import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5

import QtGraphicalEffects 1.0
import QtPositioning 5.5
import QtLocation 5.6


ApplicationWindow   {
    id:root
    visible: true
    width:740
    height: 680
    minimumWidth: width
    maximumWidth: width
    minimumHeight:height
    maximumHeight:height
    flags: Qt.FramelessWindowHint | Qt.Window | Qt.WindowMinMaxButtonsHint
    modality:Qt.ApplicationModal
    color: "#00000000"
 
 
    property int num1: 10
    property int num2: 20
    property int result: 0

    property int value: 0

    NumberAnimation {
        id: na
        target: root
        property: "value"
        from: 0
        to: 100
        duration: 3000
        loops: 2
        running: true
    }

    Rectangle{
        id:inrec
        anchors.fill: parent
        // 当窗口全屏时，设置边距为 0，则不显示阴影，窗口化时设置边距为 10 就可以看到阴影了
        anchors.margins: root.visibility === Window.Maximized ? 0 : 10
        radius:10
        opacity:1
        layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Rectangle {
                    width: inrec.width
                    height: inrec.height
                    radius: inrec.radius
                }
            }
        MouseArea { 
                x:0
                y:0
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton
                property point clickPos: "0,0"
                onPressed: { 
                        clickPos  = Qt.point(mouse.x,mouse.y)
                }
                onPositionChanged: {
                        var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
                        root.setX(root.x+delta.x)
                        root.setY(root.y+delta.y)
                }
               
        }

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

        MyClock{	//实例化另一个文件，文件名称第一个要大写
            id:clock
            //anchors.fill: parent
        }
   

         MyButton{
            id:minimize
            x:inrec.width - 160
            y:10
            width:36
            height:24
            normalUrl : "qrc:/images/minimize_normal.png"     //常规状态下的图片路径
            hoveredUrl : "qrc:/images/minimize_hover.png"    //悬浮
            pressedUrl: "qrc:/images/minimize_hover.png"     //按下
            disabledUrl : "qrc:/images/minimize_hover.png"   //禁用
           onClicked: {
               root.showMinimized()
           }
        }

       MyButton{
            id:close2
            x:inrec.width - 120
            y:10
            width:36
            height:24
           onClicked: {
               Qt.quit()
           }
        }

        Button{
            id:close
            x:inrec.width - 60
            y:10
            width:50
            height:30
            text: "退出"
            onClicked: {
               Qt.quit()
            }
        }

        WaveProgressBar
        {
            id:wave_progessbar
            x:10
            y:inrec.height - 170
            value: root.value
        }

        CircleProgressBar
        {
            id:circle_progessbar
            x:inrec.width - 170
            y:inrec.height - 170
            value: root.value
        }
    }
  
    DropShadow {
        anchors.fill: inrec
        horizontalOffset: 1
        verticalOffset: 1
        radius: 8
        samples: 16
        source: inrec
        color: "#33333F"
        Behavior on radius { PropertyAnimation { duration: 100 } }
    }
}


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
    flags: Qt.FramelessWindowHint | Qt.Window
    modality:Qt.ApplicationModal
    color: "#00000000"
 

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


import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import QtPositioning 5.5
import QtLocation 5.6

Item {
    id: root
    visible: true
    width: 720
    height: 640

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

        /* 滑动屏幕元素 */
        SwipeView {
            id: swipeView
            anchors.fill: parent
            /* 在 SwipeView 里的每个子页面都按照出现顺序进行实例化 */
            Current {}      // Current
            UserStats {}    // UserStats
            TotalStats {}   // TotalStats
            Windmill    {} //鼠标单击风车叶片，风车就会转动
        }

        /* 分页指示符 */
        PageIndicator {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            currentIndex: swipeView.currentIndex  // 当前索引，绑定到 SwipeView 元素
            count: swipeView.count                // 当前页面数量，绑定到 SwipeView 元素
        }
    }
  
}
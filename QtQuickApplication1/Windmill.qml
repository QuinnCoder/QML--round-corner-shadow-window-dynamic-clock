import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5

import QtGraphicalEffects 1.0

//鼠标单击风车叶片，风车就会转动

Image {
    id: root
    source: "images/background.png"
    property int blurRadius: 0

    Image {
        id: pole
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        source: "images/pole.png"
    }

    Image {
        id: wheel
        anchors.centerIn: parent
        source: "images/pinwheel.png"
        Behavior on rotation {
            NumberAnimation {
                duration: 250
            }
        }
        layer.effect: FastBlur {
            id: blur
            radius: root.blurRadius
            Behavior on radius {
                NumberAnimation {
                    duration: 250
                }
            }
        }
        layer.enabled: true
    }

    MouseArea {
        anchors.fill: parent
        onPressed: {
            wheel.rotation += 90
            root.blurRadius = 16
        }
        onReleased: {
            root.blurRadius = 0
        }
    }
}
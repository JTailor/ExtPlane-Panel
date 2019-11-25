import QtQuick 2.0
import QtQuick.Controls 2.2
import org.vranki.extplane 1.0
import QtQuick.Layouts 1.3

import "../.." as Panel
import ".." as PanelItems

PanelItems.PanelItem {
    clip: false

    Panel.UnitConverter {
        id: altitudeConverter
        inUnit: uDistanceFeet
        outUnit: settings.isMs ? uDistanceMeters : uDistanceFeet
    }
    Panel.UnitConverter {
        id: pressureConverter
        inUnit: uPressureInHG
        outUnit: settings.isMs ? uPressurehPa : uPressureInHG
    }

    DataRef {
        id: altitudeRef
        name: "sim/flightmodel/misc/h_ind"
        accuracy: 3
        scaleFactor: altitudeConverter.scaleFactor
    }

    DataRef {
        id: altimeterSettingRef
        name: "sim/cockpit/misc/barometer_setting"
        scaleFactor: pressureConverter.scaleFactor
    }
    CircularGaugeBars {
        barValue: 100
        valueMax: 10000
        valueMultiplier: 1000
        barsAngleMin: 90
        barsAngle: 359
        showLastValue: false
    }
    CircularGaugeBars {
        longBars: true
        barValue: 500
        valueMax: 10000
        valueMultiplier: 1000
        barsAngleMin: 90
        barsAngle: 359
        showLastValue: false
    }
    CircularGaugeBars {
        id: valueBars

        thickBars: true
        showValue: true
        barValue: 1000
        valueMax: 10000
        valueMultiplier: 1000
        barsAngleMin: 90
        barsAngle: 359
        showLastValue: false

        Text {
            text: altitudeConverter.outUnitName + " x " + valueBars.valueMultiplier
            color: "white"
            font.pixelSize: parent.height * 0.04
            font.family: b612.name
            y: parent.height * 0.70
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            text: parseFloat(altimeterSettingRef.value).toPrecision(6) + " " + pressureConverter.outUnitName
            color: "white"
            font.pixelSize: parent.height * 0.04
            font.family: b612.name
            x: parent.width * 0.60
            anchors.verticalCenter: parent.verticalCenter
            Rectangle {
                color: "#292929"
                anchors.fill: parent
                z: -1
            }
        }
        Needle {
            needleType: 2
            rotation: valueBars.value2Angle(altitudeRef.value)
        }
        Needle {
            needleType: 1
            rotation: valueBars.value2Angle(altitudeRef.value * 10)
            movementDuration: 250
        }
    }
    propertiesDialog.propertyItems: [
        Text { text: "In meters instead of feet" },
        CheckBox { checked: settings.isMs ; onCheckedChanged: settings.isMs = checked }
    ]


    PanelItems.PanelItemSettings {
        id: settings
        property bool isMs: false
    }
}

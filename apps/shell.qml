import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick

ShellRoot {
   id: root

   //Colors
   property color colBase: "#141216"
   property color colText: "#e49d9d"

   // Font
   property string fontFamily: "Terminess Nerd Font"
   property int fontSize: 16

   // Bars
	Scope {
	 id: topBar
	 property string time

	 Variants {
	   model: Quickshell.screens

	   PanelWindow {
	     required property var modelData
	     screen: modelData

	     anchors {
		top: true
		left: true
		right: true
	     }

	     color: root.colBase
	     implicitHeight: 35

	     Text {
		anchors.centerIn: parent
		text: topBar.time
		color: root.colText
		font.family: root.fontFamily
		font.pixelSize: root.fontSize
	     }
	   }
	 }

	 Process {
	   id: dateProc
	   command: ["date"]
	   running: true

	   stdout: StdioCollector {
	     onStreamFinished: topBar.time = this.text
	   }
	 }

	 Timer {
	   interval: 1000
	   running: true
	   repeat: true
	   onTriggered: dateProc.running = true
	 }
  	}
}

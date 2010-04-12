package com.graywhale.logo {
	import flash.display.*
	import flash.events.*
	import flash.geom.*
  import flash.utils.Timer

  import de.popforge.events.*
	import org.osflash.thunderbolt.Logger
	import caurina.transitions.Tweener
  import caurina.transitions.properties.DisplayShortcuts
  import caurina.transitions.properties.ColorShortcuts
  import caurina.transitions.properties.FilterShortcuts
  ColorShortcuts.init()
  DisplayShortcuts.init()
  FilterShortcuts.init()

	import com.graywhale.*
	import com.graywhale.logo.*

	public class Logo extends MovieClip {

		var _curve:Curve
		var _label:Label
		var _capital:Capital

		public function Logo() {
      addEventListener(Event.ADDED_TO_STAGE, init)
		}
		
    private function init(e:Event) {
			addDots()
			addCurve()

			// This comes after dots and curve are initialized, so the  centering will look right.
			scaleX = scaleY = 5
			x = stage.stageWidth/2 - width/2
			y = stage.stageHeight/2 - height/2

			// Set up delay for ending the zoomage
			var endZoomDelay = FV.get.logo_curve_appear_time + FV.get.logo_curve_appear_delay + FV.get.logo_zoomed_hangout_time
     	var t = new Timer(endZoomDelay*1000, 1)
     	t.addEventListener(TimerEvent.TIMER_COMPLETE, endZoom)
     	t.start()

			// Set up delay for appearance of logo text
     	var t2 = new Timer((endZoomDelay)*1000, 1)
     	t2.addEventListener(TimerEvent.TIMER_COMPLETE, addLabelAndCapital)
     	t2.start()
    }


		private function endZoom(e:TimerEvent=null) {
			Tweener.addTween(this, {_scale:1, x:FV.get.logo_x, y:FV.get.logo_y, time:FV.get.logo_end_zoom_time, transition:"easeInOutCubic"})
		}
		
		private function addLabelAndCapital(e:TimerEvent=null) {
			addLabel()
			addCapital()
			Graywhale(parent).logoReady()
		}

		private function addCurve() {
			_curve = new Curve()
			addChild(_curve)
			
			_curve.x = 4

			_curve.alpha = 0
			Tweener.addTween(_curve, {
				alpha: 1, 
				time: FV.get.logo_curve_appear_time, 
				delay: FV.get.logo_curve_appear_delay, 
				transition: "easeInCubic"
			})
		}
		
		private function addDots() {
			addChild(new LogoDot(0, FV.get.dot_color_2, 04, 10))
			addChild(new LogoDot(1, FV.get.dot_color_1, 30, 14))
			addChild(new LogoDot(2, FV.get.dot_color_1, 13, 19))
			addChild(new LogoDot(3, FV.get.dot_color_2, 25, 21))
			addChild(new LogoDot(4, FV.get.dot_color_3, 23, 11))
		}
		
		private function addLabel() {
			_label = new Label()
			addChild(_label)
			_label.x = 52
			
			_label.alpha = 0
			Tweener.addTween(_label, {
				alpha: 1, 
				time: FV.get.logo_label_appear_time, 
				delay: FV.get.logo_label_appear_delay,
				transition: "easeInCubic"
			})

		}
		
		private function addCapital() {
			_capital = new Capital()
			addChild(_capital)
			_capital.x = 225
			_capital.y = 32

			_capital.alpha = 0			
			Tweener.addTween(_capital, {
				alpha: 1, 
				time: FV.get.logo_capital_appear_time, 
				delay: FV.get.logo_capital_appear_delay,
				transition: "easeInCubic"
			})
		}

		public function adaptToScale() {
			// x = 0
			// y = stage.stageHeight - height + 2
		}

	}
}
package com.graywhale {
	import flash.display.*
	import flash.events.*
	
  import caurina.transitions.Tweener
  import caurina.transitions.properties.FilterShortcuts
	FilterShortcuts.init()

	import com.graywhale.*

	public class Watermark extends MovieClip {

		public var _width_to_height_ratio:Number

		public function Watermark() {
      addEventListener(Event.ADDED_TO_STAGE, init)
		}

    function init(e:Event) {
		
			_width_to_height_ratio = width/height
			
      alpha = 0
      Tweener.addTween(this, {
				alpha:FV.get.watermark_alpha, 
				time:FV.get.watermark_appear_time, 
				delay:FV.get.watermark_appear_delay, 
				transition:"easeInCubic"
			})
			
			adaptToScale()
    }

		public function adaptToScale() {
			scaleX = 29
			scaleY = 29
			x = FV.get.watermark_x
			y = FV.get.watermark_y
		}
        
	}
}
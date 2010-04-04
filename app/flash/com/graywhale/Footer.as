package com.graywhale {
	import flash.display.*
	import flash.events.*

  import de.popforge.events.*
	import caurina.transitions.Tweener
	import org.osflash.thunderbolt.Logger

	public class Footer extends MovieClip {

		var _stripe_1
		var _stripe_2

		public function Footer() {
      addEventListener(Event.ADDED_TO_STAGE, init)
		}
		
    private function init(e:Event) {					
			drawStripes()
			addDots()
			appear()
			adaptToScale()
    }

		private function drawStripes() {
			var s1 = _stripe_1 = new Shape();
			s1.graphics.beginFill(FV.get.footer_stripe_1_color)
			var y = FV.get.footer_dot_y_range+FV.get.footer_stripe_2_height
			s1.graphics.drawRect(0, y, stage.stageWidth, FV.get.footer_stripe_1_height)
			s1.graphics.endFill()
			addChild(s1)
			
			var s2 = _stripe_2 = new Shape();
			s2.graphics.beginFill(FV.get.footer_stripe_2_color)
			y = FV.get.footer_dot_y_range
			s2.graphics.drawRect(0, y, stage.stageWidth, FV.get.footer_stripe_2_height)
			s2.graphics.endFill()
			addChild(s2)
		}
		
		private function addDots() {
			for(var i=0; i<FV.get.footer_dot_count; i++) {
				addChild(new FooterDot(i))
			}
		}

		private function appear() {
      alpha = 0
      Tweener.addTween(this, {alpha:1, time:1, transition:"easeInCubic"})
		}

		public function adaptToScale() {
			x = 0
			y = stage.stageHeight - height
			_stripe_1.width = _stripe_2.width = stage.stageWidth
		}

	}
}
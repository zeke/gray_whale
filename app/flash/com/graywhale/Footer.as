package com.graywhale {
	import flash.display.*
	import flash.events.*
	import flash.geom.*

  import de.popforge.events.*
	import caurina.transitions.Tweener
	import org.osflash.thunderbolt.Logger

	public class Footer extends MovieClip {

		var _stripe_1:Sprite
		var _stripe_2:Sprite
		var _stripe_3:Sprite

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
			
			// _stripe_1 is a gradient..
			var fType:String = GradientType.LINEAR
			var colors:Array = [FV.get.footer_stripe_1_color, FV.get.footer_stripe_1_color]
			var alphas:Array = [0, 1]
			var ratios:Array = [0, 255]
			var matr:Matrix = new Matrix()
			matr.createGradientBox(stage.stageWidth, FV.get.footer_stripe_1_height, Math.PI/2, 0, 0)
			var sprMethod:String = SpreadMethod.PAD
			
			var s1 = _stripe_1 = new Sprite()
			s1.graphics.beginGradientFill(fType, colors, alphas, ratios, matr, sprMethod)
			s1.graphics.drawRect(0, 0, stage.stageWidth, FV.get.footer_stripe_1_height)
			s1.graphics.endFill()
			addChild(s1)
			
			var s2 = _stripe_2 = new Sprite()
			s2.graphics.beginFill(FV.get.footer_stripe_2_color)
			s2.graphics.drawRect(0, 0, stage.stageWidth, FV.get.footer_stripe_2_height)
			s2.graphics.endFill()
			addChild(s2)
			
			var s3 = _stripe_3 = new Sprite()
			s3.graphics.beginFill(FV.get.footer_stripe_3_color)
			s3.graphics.drawRect(0, 0, stage.stageWidth, FV.get.footer_stripe_3_height)
			s3.graphics.endFill()
			addChild(s3)
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
			_stripe_1.width = _stripe_2.width = _stripe_3.width = stage.stageWidth
			_stripe_1.y = FV.get.footer_dot_y_range - _stripe_1.height
			_stripe_2.y = _stripe_1.y + _stripe_1.height
			_stripe_3.y = _stripe_2.y + _stripe_2.height
			
			x = 0
			y = stage.stageHeight - height + 2
		}

	}
}
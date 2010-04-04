package com.graywhale {
	import flash.display.*
	import flash.events.*

  import de.popforge.events.*
	import caurina.transitions.Tweener
	import org.osflash.thunderbolt.Logger

	public class FooterDot extends MovieClip {

		var _id
		var _x_speed:Number

		public function FooterDot(id) {
			_id = id
			// Choose a random x speed within the allowed range
			_x_speed = FV.get.footer_dot_speed_min + (Math.random() * (FV.get.footer_dot_speed_max - FV.get.footer_dot_speed_min))
      addEventListener(Event.ADDED_TO_STAGE, init)
		}
		
    private function init(e:Event) {
			draw()
			position()
			appear()
      addEventListener(Event.ENTER_FRAME, onEnterFrame)
    }
		
		private function draw() {
			var color = FV.get['dot_color_' + Math.floor(Math.random()*3+1)]
			graphics.beginFill(color)
			graphics.drawCircle(0, 0, FV.get.footer_dot_radius)
			graphics.endFill()
		}
		
		private function position() {
			x = Math.random() * stage.stageWidth
			y = Math.random() * FV.get.footer_dot_y_range
		}

		private function appear() {
      alpha = 0
      Tweener.addTween(this, {alpha:1, time:1, transition:"easeInCubic"})
			seekRandomY()
		}
		
		private function seekRandomY(e:Event=null) {
			var t = FV.get.footer_dot_y_transition_time_min + (Math.random() * (FV.get.footer_dot_y_transition_time_max - FV.get.footer_dot_y_transition_time_min))
			Tweener.addTween(this, {y:Math.random()*(FV.get.footer_dot_y_range-(FV.get.footer_dot_radius*2)-3), time:t, transition:"easeInOutCubic", onComplete:seekRandomY})
		}
		
    private function onEnterFrame(e:Event=null) {
			x += _x_speed
			if (x>stage.stageWidth) { x = -(FV.get.footer_dot_radius*2)}
    }

	}
}
package com.graywhale.logo {
	import flash.display.*
	import flash.events.*

  import de.popforge.events.*
	import caurina.transitions.Tweener
	import org.osflash.thunderbolt.Logger
	
	import com.graywhale.*
	import com.graywhale.logo.*

	public class LogoDot extends MovieClip {

		var _id:Number
		var _color:Number
		var _x_init:Number
		var _y_init:Number

		public function LogoDot(id, color, x_init, y_init) {
			_id = id
			_color = color
			_x_init = x_init
			_y_init = y_init
      addEventListener(Event.ADDED_TO_STAGE, init)
		}
		
    private function init(e:Event) {
			draw()
			position()
			appear()
    }
		
		private function draw() {
			graphics.beginFill(_color)
			graphics.drawCircle(0, 0, FV.get.logo_dot_radius)
			graphics.endFill()
		}
		
		private function position() {
			x = _x_init
			y = _y_init
		}

		private function appear() {
      alpha = 0
      Tweener.addTween(this, {alpha:1, time:FV.get.logo_dot_appear_time, delay:_id*FV.get.logo_dot_appear_delay_interval, transition:"easeInCubic"})
		}

	}
}
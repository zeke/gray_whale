package com.graywhale.logo {
	import flash.display.*
	import flash.events.*
	import flash.geom.*

  import de.popforge.events.*
	import caurina.transitions.Tweener
	import org.osflash.thunderbolt.Logger
	
	import com.graywhale.*
	import com.graywhale.logo.*

	public class Curve extends MovieClip {

		public function Curve() {
      addEventListener(Event.ADDED_TO_STAGE, init)
		}
		
    private function init(e:Event) {	
			x = FV.get.logo_curve_x + FV.get.logo_curve_initial_x_offset	
			Tweener.addTween(this, {
				x: FV.get.logo_curve_x,
				time: FV.get.logo_curve_appear_time, 
				delay: FV.get.logo_curve_appear_delay, 
				transition: "easeOutCubic"
			})

			alpha = 0
			Tweener.addTween(this, {
				alpha: 1, 
				time: FV.get.logo_curve_appear_time, 
				delay: FV.get.logo_curve_appear_delay, 
				transition: "easeInCubic"
			})
    }

	}
}
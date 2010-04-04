package com.graywhale {
	import flash.display.*
	import flash.events.*
	
  import caurina.transitions.Tweener
  import caurina.transitions.properties.FilterShortcuts
  import caurina.transitions.properties.ColorShortcuts
  ColorShortcuts.init()

	import com.graywhale.*

	public class Spinner extends MovieClip {

    
		public function Spinner() {
      name = "spinner"
      addEventListener(Event.ADDED_TO_STAGE, init)
		}

    function init(e:Event) {
      position()

      alpha = 0
      Tweener.addTween(this, {alpha:1, time:1, transition:"easeInCubic"})

      Tweener.addTween(this, {_color:FV.get.throbber_color})
      addEventListener(Event.ENTER_FRAME, spin)
    }
    
    function spin(e:Event) {
      rotation += 25
    }
    
    function fadeOut() {
			if (visible) Tweener.addTween(this, {alpha:0, time:2, transition:"easeOutCubic", onComplete:hide})	
    }
    
    function hide() {
      visible = false
    }
    
    function position() {
      var padding = 20
      
      switch (FV.get.align_horizontal) {
      case "left":
        x = padding
        break;
      case "right":
        x = stage.stageWidth - width - padding
      break;
      default: // center
        x = stage.stageWidth/2 - width/2
        break;
      }
      
      switch (FV.get.align_vertical) {
      case "top":
        y = padding
        break;
      case "bottom":
        y = stage.stageHeight - height - padding
      break;
      default: // middle
        y = stage.stageHeight/2 - height/2
        break;
      }            
    }
    
	}
}
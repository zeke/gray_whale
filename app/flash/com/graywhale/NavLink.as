package com.graywhale {
	import flash.display.*
	import flash.events.*
	import flash.geom.*
  import flash.text.*

  import de.popforge.events.*
	import caurina.transitions.Tweener
	import org.osflash.thunderbolt.Logger

	public class NavLink extends MovieClip {

		public var _bg:Shape
    public var _id:Number
		public var _json:Object
		public var _title
		public var _active:Boolean = false
		public var _in_splash_position:Boolean = true
		public var _ready:Boolean = false
		
		public function NavLink(id, json) {
			name = "page_" + id
			_id = id
			_json = json
			buttonMode = true
      mouseChildren = false
			SimpleMouseEventHandler.register(this)
      addEventListener(SimpleMouseEvent.ROLL_OVER, rollOverHandler)
      addEventListener(SimpleMouseEvent.DRAG_OVER, rollOverHandler)
			addEventListener(SimpleMouseEvent.ROLL_OUT, rollOutHandler)
      addEventListener(SimpleMouseEvent.DRAG_OUT, rollOutHandler)
      addEventListener(SimpleMouseEvent.RELEASE, releaseHandler)
      addEventListener(SimpleMouseEvent.RELEASE_OUTSIDE, releaseHandler)   
      addEventListener(Event.ADDED_TO_STAGE, init)
		}
		
    private function init(e:Event) {					
			addBackground()
			addTitle()
			adaptToScale()
			appear()
    }

    private function addBackground() {
      _bg = new Shape()
      _bg.graphics.beginFill(0x000000)
      _bg.graphics.drawRect(0, 0, 20, 20) // width and height will get updated
      _bg.graphics.endFill()
      addChild(_bg)
			_bg.alpha = 0
    }

    private function addTitle() {
			var format:TextFormat = new TextFormat()
		  format.font = new HelveticaNeueRoman().fontName
			format.color = FV.get.nav_link_color
			format.size = FV.get.nav_link_text_size
			format.letterSpacing = 0
			format.bold = false

		  var l = _title = new TextField()
      l.autoSize = TextFieldAutoSize.LEFT
		  l.selectable = false
			l.multiline = false
			l.wordWrap = false
      l.embedFonts = true
			l.defaultTextFormat = format
			l.htmlText = _json['title']
			addChild(l)
    }

		private function rollOverHandler(event:SimpleMouseEvent):void {
			if (_ready) emphasize()
		}

		private function rollOutHandler(event:SimpleMouseEvent):void {			
			if (_ready && !_active) deEmphasize()
		}

		private function releaseHandler(event:SimpleMouseEvent):void {
			if (_ready) Graywhale(this.parent).showPage(_id)
		}

		public function activate() {
			_active = true
			emphasize()
			seekPostSplashPosition()
		}

		public function deactivate() {
			if (_active) {
				_active = false
				deEmphasize()
			}
			seekPostSplashPosition()
		}
		
		// Links start out left justified, and further to the right of the canvas.
		// Once any link is clicked, all links right justify, and move to the left side of the canvas.
		public function seekPostSplashPosition() {
			if (_in_splash_position) {
				Tweener.addTween(this, {
					x: FV.get.nav_right_edge-width, 
					delay: FV.get.nav_link_slide_delay_interval*_id, 
					time: FV.get.nav_post_splash_slide_time, 
					transition: "easeOutCubic"
				})
				_in_splash_position = false
			}
		}
		
		public function emphasize() {
      Tweener.addTween(this, {alpha:FV.get.nav_link_alpha_active, time:0, transition:"linear"})
		}
		
		public function deEmphasize() {
      Tweener.addTween(this, {alpha:FV.get.nav_link_alpha_inactive, time:.75, transition:"linear"})
		}

		public function adaptToScale() {
			_bg.width = _title.textWidth
			_bg.height = _title.textHeight
			if (_in_splash_position) {
				x = FV.get.nav_splash_left_edge
			} else {
				x = FV.get.nav_right_edge - width
			}
			
			y = FV.get.nav_margin_top + (_id * (height+FV.get.nav_link_margin_bottom))
		}
		
		private function appear() {
			alpha = 0
      Tweener.addTween(this, {
				alpha: FV.get.nav_link_alpha_inactive, 
				time: FV.get.nav_link_appear_time,
				transition: "easeInCubic",
				delay: (_id * FV.get.nav_link_appear_delay_interval) + FV.get.nav_link_appear_delay,
				onComplete: ready				
			})			
		}
		
		// Prevent NavLink from being rolled over before it's even appeared.
		private function ready() {
			_ready = true
		}

	}
}
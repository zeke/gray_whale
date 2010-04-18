package com.graywhale {
	import flash.display.*
	import flash.events.*
	import flash.geom.*
  import flash.text.*

  import de.popforge.events.*
	import org.osflash.thunderbolt.Logger
	import caurina.transitions.Tweener
  import caurina.transitions.properties.FilterShortcuts
  FilterShortcuts.init()

	public class Page extends MovieClip {

    public var _id:Number
		public var _json:Object
		public var _title
		public var _tagline
		public var _body
		public var _active:Boolean = false
		
		public function Page(id, json) {
			name = "page_" + id
			_id = id
			_json = json
      addEventListener(Event.ADDED_TO_STAGE, init)
		}
		
    private function init(e:Event) {					
			addTitle()
			addTagline()
			addBody()
			adaptToScale()
			hide()
    }

    private function addTitle() {
			var format:TextFormat = new TextFormat()
			format.font = new HelveticaNeueExtended().fontName
			format.color = FV.get.page_title_color_2
			format.size = FV.get.page_title_text_size
			format.letterSpacing = 0
			format.bold = false
			
			// var p:Object = new Object()
			// p.color = FV.get.page_title_color_1
			// p.size = FV.get.page_title_text_size
			// p.letterSpacing = 0
			// p.bold = false

			var dog:Object = new Object()
			dog.color = "#00AEEF"

			// var style:StyleSheet = new StyleSheet()
			// style.setStyle("p", p)
			// style.setStyle("dog", dog)

		  var l = _title = new TextField()
      l.autoSize = TextFieldAutoSize.LEFT
		  l.selectable = true
			l.multiline = false
			l.wordWrap = false
      l.embedFonts = true
      l.width = FV.get.page_width
			l.condenseWhite = true
			l.defaultTextFormat = format
			// l.styleSheet = style
	
			var parts = _json['title'].split(" ")
			var blue_text = "<font color='#00AEEF'>" + parts.shift() + "</font> " // snag first element off array
			var grey_text = parts.join(" ")

			l.htmlText = blue_text + grey_text
			addChild(l)
    }

    private function addTagline() {
			var format:TextFormat = new TextFormat()
		  format.font = new HelveticaNeueThinExtended().fontName
			format.color = FV.get.page_tagline_color
			format.size = FV.get.page_tagline_text_size
			format.letterSpacing = 0
			format.bold = false
			format.leading = 6

		  var l = _tagline = new TextField()
      l.autoSize = TextFieldAutoSize.LEFT
		  l.selectable = true
			l.multiline = true
			l.wordWrap = true
      l.embedFonts = true
      l.width = FV.get.page_width
			l.defaultTextFormat = format
			l.htmlText = _json['tagline']
			addChild(l)
    }

    private function addBody() {
			var format:TextFormat = new TextFormat()
		  format.font = new HelveticaNeueRoman().fontName
			format.color = FV.get.page_body_color
			format.size = FV.get.page_body_text_size
			format.letterSpacing = 0
			format.bold = false
      format.leading = 5

		  var l = _body = new TextField()
      l.autoSize = TextFieldAutoSize.LEFT
		  l.selectable = false
			l.multiline = true
			l.wordWrap = true
      l.embedFonts = true
      l.width = FV.get.page_width
			l.defaultTextFormat = format
			l.htmlText = _json['html_body']
			addChild(l)
    }

		public function adaptToScale() {
			x = FV.get.page_x
			y = FV.get.page_y

			// Account for spacing when no tagline is present
			if (_json['tagline'] == "") {
				_tagline.visible = false
				_body.y = _title.y + _title.height + FV.get.page_title_padding_bottom
			} else {
				_tagline.y = _title.y + _title.height + FV.get.page_title_padding_bottom
				_body.y = _tagline.y + _tagline.height + FV.get.page_tagline_padding_bottom	
			}
			
		}
		    
    function hide() {
			alpha = 0
      visible = false
			adaptToScale()
			Tweener.addTween(this, {_Blur_blurX:FV.get.page_blur_x, _Blur_blurY:FV.get.page_blur_y})
    }

		public function activate(delay_page_appearance) {
			if (delay_page_appearance==undefined) delay_page_appearance=false
			visible = true
			_active = true
			var d = delay_page_appearance ? FV.get.page_appear_delay : 0

			// Fade in
      Tweener.addTween(this, {
				alpha: 1,
				time: FV.get.page_appear_time,
				delay: d,
				transition:"linear"
			})
			
			// un-blur and slide in from the left
			x = FV.get.page_x - FV.get.page_x_shift
			Tweener.addTween(this, {
				x: FV.get.page_x,
				_Blur_blurX: 0,
				_Blur_blurY: 0,
				time: FV.get.page_appear_time,
				delay: d,
				transition: "easeOutCubic"
			})

		}

		public function deactivate() {
			if (_active) {
				_active = false
				
				// Fade out
      	Tweener.addTween(this, {
					alpha:0, 
					time:FV.get.page_disappear_time, 
					transition:"easeInCubic"
				})
				
				// Blur
				Tweener.addTween(this, {
					_Blur_blurX: FV.get.page_blur_x,
					_Blur_blurY: FV.get.page_blur_y,
					time: FV.get.page_disappear_time,
					transition:"easeOutCubic"
				})

				// Slide to the right
				Tweener.addTween(this, {
					x: FV.get.page_x + FV.get.page_x_shift, 
					time: FV.get.page_disappear_time,
					transition: "easeInCubic",
					onComplete: hide
				})

			}
		}

	}
}
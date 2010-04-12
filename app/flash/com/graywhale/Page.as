package com.graywhale {
	import flash.display.*
	import flash.events.*
	import flash.geom.*
  import flash.text.*

  import de.popforge.events.*
	import caurina.transitions.Tweener
	import org.osflash.thunderbolt.Logger

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
			format.color = FV.get.page_title_color
			format.size = FV.get.page_title_text_size
			format.letterSpacing = 0
			format.bold = false

		  var l = _title = new TextField()
      l.autoSize = TextFieldAutoSize.LEFT
		  l.selectable = true
			l.multiline = false
			l.wordWrap = false
      l.embedFonts = true
      l.width = FV.get.page_width
			l.defaultTextFormat = format
			l.htmlText = _json['title']
			addChild(l)
    }

    private function addTagline() {
			var format:TextFormat = new TextFormat()
		  format.font = new HelveticaNeueThinExtended().fontName
			format.color = FV.get.page_tagline_color
			format.size = FV.get.page_tagline_text_size
			format.letterSpacing = 0
			format.bold = false

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
			x = FV.get.page_margin_left
			y = FV.get.page_margin_top
			_tagline.y = _title.y + _title.height + FV.get.page_title_padding_bottom
			_body.y = _tagline.y + _tagline.height + FV.get.page_tagline_padding_bottom
		}
		    
    function hide() {
			alpha = 0
      visible = false
			adaptToScale()
    }

		public function activate(delay_page_appearance) {
			if (delay_page_appearance==undefined) delay_page_appearance=false
			visible = true
			_active = true
			var d = delay_page_appearance ? FV.get.page_appear_delay : 0
      Tweener.addTween(this, {alpha:1, time:FV.get.page_appear_time, delay:d, transition:"linear"})
		}

		public function deactivate() {
			if (_active) {
				_active = false
      	Tweener.addTween(this, {
					alpha:0, 
					time:FV.get.page_disappear_time, 
					transition:"linear"
				})
				
      	Tweener.addTween(this, {
					x: this.x+300, 
					time:FV.get.page_disappear_time+.2,
					transition:"easeInCubic",
					onComplete:hide
				})

			}
		}

	}
}
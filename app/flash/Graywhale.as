package {
	import flash.display.*
	import flash.events.*
	import flash.net.*

  import de.popforge.events.*
	import caurina.transitions.Tweener
	import org.osflash.thunderbolt.Logger
	import org.casalib.util.ObjectUtil
	import org.casalib.util.ArrayUtil
	import com.serialization.json.JSON
	
  import com.graywhale.*
  import com.graywhale.logo.*

	public class Graywhale extends MovieClip {

		public var _logo:Logo
		public var _footer:Footer
		public var _spinner:Spinner
		public var _pages_json:Object
		public var _pages:Array = new Array()
		public var _nav_links:Array = new Array()
		public var _logo_is_ready:Boolean = false
		public var _feed_is_ready:Boolean = false

		public function Graywhale() {
      FV.process(this)
      configureStage()
			showLogo()
      showSpinner()
      loadFeed()
		}
		
		public function showPage(id) {

			// Iterate over NavLinks
			for each (var nav_link in _nav_links) {
				if (nav_link._id == id) {
					nav_link.activate()
				} else {
					nav_link.deactivate()
				}
			}
			
			// Delay appearance of page if another page needs to fade out first
			var delay_page_appearance = false
			for each (var page in _pages) {
				if (page._active) {
					delay_page_appearance = true
					break
				}
			}
			
			// Iterate over Pages
			for each (page in _pages) {
				if (page._id == id) {
					page.activate(delay_page_appearance)
				} else {
					page.deactivate()
				}
			}
			
		}

	  private function showLogo() {
			_logo = new Logo()
      addChild(_logo)
	  }
	
	  private function showSpinner() {
			_spinner = new Spinner()
      addChild(_spinner)
	  }
	
	  private function showFooter() {
			_footer = new Footer()
      addChild(_footer)
	  }
	
		private function configureStage() {
      stage.align = StageAlign.TOP_LEFT
      stage.scaleMode = StageScaleMode.NO_SCALE
			stage.quality = StageQuality.HIGH
      stage.addEventListener(Event.RESIZE, resizeHandler)
		}
	
    // Tell child clips to adjust to resized stage
		function resizeHandler(event:Event) {
			_footer.adaptToScale()
			for each (var page in _pages) { page.adaptToScale() }
			for each (var nav_link in _nav_links) { nav_link.adaptToScale() }
		}
	
		private function loadFeed() {
			var loader:URLLoader = new URLLoader()
			loader.addEventListener(Event.COMPLETE, feedReady)
			loader.load(new URLRequest(FV.get.pages_json_url))
		}

		// Logo and feed have to both be ready before pages can be generated		
		private function feedReady(event:Event) {
			_spinner.fadeOut()
			_pages_json = JSON.deserialize(event.target.data as String)
			_feed_is_ready = true
			if (_logo_is_ready) generatePagesAndNavAndFooter()
		}

		// Logo and feed have to both be ready before pages can be generated
		public function logoReady() {
			_logo_is_ready = true
			if (_feed_is_ready) generatePagesAndNavAndFooter()
		}
						
		private function generatePagesAndNavAndFooter() {
			var keys = ObjectUtil.getKeys(_pages_json)
			var page_id = 0
			for (var i=0; i<keys.length; i++){
				var key = keys[i]
				var page_json = _pages_json[key]['page']

				var nav_link:NavLink = new NavLink(page_id, page_json)
				this.addChild(nav_link)
				_nav_links.push(nav_link)

				var page:Page = new Page(page_id, page_json)
				this.addChild(page)
				_pages.push(page)				
				
				page_id++
			}
			
			showFooter()
		}
		
	}
}
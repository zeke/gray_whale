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
		
		public var _footer:Footer
		public var _spinner:Spinner
		public var _pages_json:Object
		public var _pages:Array = new Array()
		public var _nav_links:Array = new Array()

		public function Graywhale() {
      FV.process(this)
      configureStage()
			showFooter()
      showSpinner()
      loadFeed()
		}

		private function configureStage() {
      stage.align = StageAlign.TOP_LEFT
      stage.scaleMode = StageScaleMode.NO_SCALE
			stage.quality = StageQuality.HIGH
      stage.addEventListener(Event.RESIZE, resizeHandler)
		}
		
	  private function showSpinner() {
			_spinner = new Spinner()
      addChild(_spinner)
	  }
	
	  private function showFooter() {
			_footer = new Footer()
      addChild(_footer)
	  }
	
    // Tell child clips to adjust to resized stage
		function resizeHandler(event:Event) {
			_footer.adaptToScale();
		}
	
		private function loadFeed() {
			var loader:URLLoader = new URLLoader()
			loader.addEventListener(Event.COMPLETE, generatePagesAndNav)
			loader.load(new URLRequest(FV.get.pages_json_url))
		}
						
		private function generatePagesAndNav(event:Event):void {
			_spinner.fadeOut()
			_pages_json = JSON.deserialize(event.target.data as String)	
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
		}
		
	}
}
package {
	import flash.display.*
	import flash.events.*
	import flash.net.*

  import de.popforge.events.*
	import caurina.transitions.Tweener
	import org.osflash.thunderbolt.Logger
	import org.casalib.util.ObjectUtil
	import org.casalib.util.ArrayUtil
	
  import com.graywhale.*
  import com.graywhale.logo.*

	public class Graywhale extends MovieClip {
		
		public var _images_json:Object
		public var _images:Array = new Array()
		public var _caption:Caption
		public var _hitarea:Hitarea
		public var _active_image:Image

		public function Slideshow() {
      FV.process(this)
      configureStage()
      showSpinner()
      loadFeed()
		}

		private function configureStage() {
      stage.align = StageAlign.TOP_LEFT
      stage.scaleMode = StageScaleMode.NO_SCALE
			stage.quality = StageQuality.HIGH
		}
		
	  private function showSpinner() {
      var spinner = new Spinner()
      addChild(spinner)
	  }
	
		private function loadFeed() {
			var loader:URLLoader = new URLLoader()
			loader.addEventListener(Event.COMPLETE, loadImages)
			loader.load(new URLRequest(FV.get.feed_url))
		}
		
		private function addCaption() {
			_caption = new Caption()
			addChild(_caption)
			
			_hitarea = new Hitarea()
			addChild(_hitarea)
		}
		
		function randomizeArray(array:Array):Array{
			var newArray:Array = new Array();
			while(array.length > 0){
				newArray.push(array.splice(Math.floor(Math.random()*array.length), 1));
			}
			return newArray;
		}
				
    private function loadImages(event:Event):void {
			_images_json = JSON.deserialize(event.target.data as String)

			// Pull keys from the object (in case we need to randomize their order)
			var keys = ObjectUtil.getKeys(_images_json)
			
			// Randomize the image order?
			Logger.debug("randomize_order: " + FV.get.randomize_order)
			if (FV.get.randomize_order) keys = randomizeArray(keys)

			var image_id = 0
			for (var i=0; i<keys.length; i++){
				var key = keys[i]
				// Only create images if they're wide enough to fill the stage
				var image_json = _images_json[key]
				if (Number(image_json[FV.get.image_size+"_width"]) > stage.stageWidth) {
					var image:Image = new Image(image_id, image_json)
					this.addChild(image)
					_images.push(image)
					image_id++
				}				
			}
			addCaption()
    }
		
	}
}
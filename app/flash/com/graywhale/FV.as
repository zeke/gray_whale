package com.graywhale {

  import flash.display.*
  import flash.events.*
  import org.osflash.thunderbolt.Logger
  
  public class FV {
    
    public static var get:Object = [];

    public function FV() {
      trace ("FV is a static class and should not be instantiated.")
    }

    public static function process(document_root) {
      var flash_vars = LoaderInfo(MovieClip(document_root).root.loaderInfo).parameters
			
			// Set string defaults
			var strings:Object = {
        // base_url:"http://localhost:3000",
				feed_url:"http://gray-whale.heroku.com/pages.json"
			}

			// Set boolean defaults
      var booleans:Object = {
			}

			// Set number defaults
      var numbers:Object = {
				dot_color_1: 0x8DC63F, // green
				dot_color_2: 0x00AEEF, // blue
				dot_color_3: 0xF68B1F, // orange
				footer_stripe_1_color: 0xC6C7C8,
				footer_stripe_1_height: 40,
				footer_stripe_2_color: 0xDEDFDF,
				footer_stripe_2_height: 20,
				footer_dot_count: 15,
				footer_dot_radius: 3,
				footer_dot_y_range: 50,
				footer_dot_speed_min: .2,
				footer_dot_speed_max: .8,
				footer_y_target_update_probability: 30,
				footer_dot_y_transition_time_min: 3,
				footer_dot_y_transition_time_max: 5
      }

      var temp:Object = [];
      
			// Load any received FlashVars
      for (var k in flash_vars) {
        temp[k] = flash_vars[k];
      }

      // Load String, Boolean, Number defaults and
      // coerce non-strings into their appropriate datatype
			for (k in strings) {
  			if (temp[k] == undefined) temp[k] = strings[k]
			}

			for (k in booleans) {
  			if (temp[k] == undefined) temp[k] = booleans[k]
        temp[k] = (temp[k] == "true" || temp[k] == "1"|| temp[k] == 1) ? true : false
			}
			
			for (k in numbers) {
  			if (temp[k] == undefined) temp[k] = numbers[k]
        temp[k] = Number(temp[k])
			}
			
			// Transfer massaged values over to 'get' container
			for (k in temp) {
			  FV.get[k] = temp[k]
        // Logger.info("FlashVar: " + k + " = " + FV.get[k])
      }

    }
        
  }
}
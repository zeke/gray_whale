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
				// pages_json_url:"http://gray-whale.heroku.com/pages.json"
				pages_json_url:"http://localhost:3000/pages.json"
			}

			// Set boolean defaults
      var booleans:Object = {
			}

			// Set number defaults
      var numbers:Object = {
				dot_color_1: 0x8DC63F, // green
				dot_color_2: 0x00AEEF, // blue
				dot_color_3: 0xF68B1F, // orange
				
				watermark_alpha: .3, 
				watermark_appear_time: 3,
				watermark_appear_delay: 5.5, 
				watermark_x: 140,
				watermark_y: 40,

				logo_dot_radius:2,
				logo_dot_appear_time: 1,
				logo_dot_appear_delay_interval:.5,
				logo_curve_appear_time: 3,
				logo_curve_appear_delay: 1.5,
				logo_curve_x: 4,
				logo_curve_initial_x_offset: 40,
				logo_zoomed_hangout_time: .1,
				logo_end_zoom_time: 1.5,
				logo_splash_x: 350,
				logo_splash_y: 145,
				logo_x: 40,
				logo_y: 145,

				logo_label_appear_time: 2,
				logo_label_appear_delay: .5,
				logo_capital_appear_time: 1.5,
				logo_capital_appear_delay: 1.5,
				
				page_x: 400,
				page_y: 144,
				page_width: 500,
				page_title_padding_bottom: 20,
				page_tagline_padding_bottom: 20,
				page_title_color_1: 0x00AEEF, // blue
				page_title_color_2: 0x6e6f73, // grey
				page_title_text_size: 60,
				page_tagline_color: 0x939598, // grey
				page_tagline_text_size: 24,
				page_body_color: 0x9D9FA2, // grey
				page_body_text_size: 15,
				page_appear_delay: .5,
				page_appear_time: 1,
				page_disappear_time: .3,
				page_blur_x: 15,
				page_blur_y: 5,
				page_x_shift: 50,
				
				nav_margin_top: 230,
				nav_splash_left_edge: 350,
				nav_post_splash_slide_time: 1,
				nav_link_slide_delay_interval: .1,
				nav_right_edge: 328,
				nav_link_margin_bottom: 7,
				nav_link_text_size: 15,
				nav_link_color: 0x000000,
				nav_link_alpha_active: .7,
				nav_link_alpha_inactive: .4,
				nav_link_appear_time: 1,
				nav_link_appear_delay: 2,
				nav_link_appear_delay_interval: .3,

				footer_margin_top: 580,
				footer_dot_count: 15,
				footer_dot_radius: 3,
				footer_dot_y_range: 50,
				footer_dot_speed_min: .2,
				footer_dot_speed_max: .8,
				footer_y_target_update_probability: 30,
				footer_dot_y_transition_time_min: 3,
				footer_dot_y_transition_time_max: 5,
				footer_stripe_1_color: 0xDFDFDF,
				footer_stripe_1_height: 30,
				footer_stripe_2_color: 0xCCCCCC,
				footer_stripe_2_height: 15,
				footer_stripe_3_color: 0xAAAAAA
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
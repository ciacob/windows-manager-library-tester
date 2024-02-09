package eu.claudius.iacob.windows.test.skins {
	
	/**
	 *  The skin for the close button in the TitleBar
	 *  of a WindowedApplication or Window.
	 */
	public class WindowMinimizeButtonSkin extends FXGButtonSkin {
		
		//--------------------------------------------------------------------------
		//
		// Define FXG to use for up, over, down and disabled states; only `up` is 
		// mandatory, it will propagate to over and down if missing. A blank FXG 
		// will be used for `disabled` if none given.
		//
		// Optionally set `upColor`, `overColor`, etc. to tint the FXG based on 
		// state. Make sure there are no unwanted fills in your FXG.
		//
		// If you don't set up any color, and there is no FXG given for `over` and
		// `down`, then `upColor` is automatically set to a 25% lighten up shade of
		// the global `color` style. Same goes for `overColor` (15% lighten up),
		// `downColor` (original shade of the `color` style), and `disabledColor`
		// (75% lighten up).
		//		
		// Overriding `measuredWidth`/`measuredHeight` is optional; default size is
		// 21x21 pixels.
		//--------------------------------------------------------------------------

		override protected function get upColor () : Number {
			return 0x000000;
		}
		
		override protected function get overColor () : Number {
			return 0x333333;
		}
		
		override protected function get downColor () : Number {
			return 0xffffff;
		}
		
		override public function get measuredWidth():Number {		
			return 14;
		}
		
		override public function get measuredHeight():Number {
			return 14;
		}
		
		override protected function get upSkin() : Class {
			return minimize;
		}
		
		override protected function get disabledSkin() : Class {
			return blank;
		}
		
	}
}
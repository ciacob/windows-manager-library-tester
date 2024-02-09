package eu.claudius.iacob.windows.test.skins {
	
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	
	import mx.skins.ProgrammaticSkin;
	
	import org.osmf.layout.ScaleMode;
	
	[Style(name="statusBarColors", type="Array", arrayType="uint", format="Color", inherit="yes")]
	[Style(name="statusBarBorderColor", format="Color", inherit="yes", type="uint")]
	[Style(name="statusBarBorderAlpha", format="Number", inherit="yes")]
	[Style(name="statusBarBorderThickness", format="Number", inherit="yes")]
	[Style(name="statusBarCornerRadius", format="Number", inherit="yes")]
	
	/**
	 *  The skin for the StatusBar of a WindowedApplication or Window.
	 *  
	 *  @langversion 3.0
	 *  @playerversion AIR 1.1
	 *  @productversion Flex 3
	 */
	public class StatusBarBackgroundSkin extends ProgrammaticSkin {		
		
		/**
		 *  Constructor.
		 *  
		 *  @langversion 3.0
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public function StatusBarBackgroundSkin() {
			super();
		}
		
		override protected function updateDisplayList (w:Number, h:Number) : void {
			super.updateDisplayList (w, h);
			
			// Collect styles
			var fillColors : Array = getStyle ('statusBarColors');
			var cornerRadius : Number = getStyle ('statusBarCornerRadius');
			var rawBorderColor : Object = getStyle ('statusBarBorderColor');
			var borderAlpha : Number = getStyle ('statusBarBorderAlpha');
			var borderThickness : Number = getStyle ('statusBarBorderThickness');
			styleManager.getColorNames (fillColors);
			styleManager.getColorNames ([rawBorderColor]);
			
			// Fill blanks with defaults
			cornerRadius = (cornerRadius || 0);
			fillColors = (fillColors || [0, 0]);
			borderAlpha = (borderAlpha || 1);
			borderThickness = (borderThickness || 1)
			var borderColor : uint = (rawBorderColor as uint || 0);
			
			// Draw
			graphics.clear();
			
			if (w > 0 && h > 0) {
				
				// Fill
				drawRoundRect (
					0, 0, w, h, 
					{tl: 0, tr: 0, bl: cornerRadius, br: cornerRadius},
					fillColors, 
					[ 1.0, 1.0 ],
					verticalGradientMatrix (0, 0, w, h)
				);
				
				// Border
				if (borderThickness > 0 && borderAlpha > 0) {
					var halfBorder : Number = (borderThickness * 0.5);
					var innerW : Number = (w - halfBorder);
					var innerH : Number = (h - halfBorder);
					graphics.lineStyle (borderThickness, borderColor, borderAlpha, true, ScaleMode.NONE, CapsStyle.SQUARE, JointStyle.BEVEL);
					graphics.moveTo (halfBorder, halfBorder);
					graphics.lineTo (innerW, halfBorder);
					graphics.lineTo (innerW, innerH - cornerRadius);
					graphics.curveTo (innerW, innerH, innerW - cornerRadius, innerH);
					graphics.lineTo (halfBorder + cornerRadius, innerH);
					graphics.curveTo (halfBorder, innerH, halfBorder, innerH - cornerRadius);
					graphics.lineTo (halfBorder, halfBorder);
				}
				graphics.endFill ();
			}
		}
	}
	
}

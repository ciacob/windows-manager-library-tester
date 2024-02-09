package eu.claudius.iacob.windows.test.skins {
	
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	
	import mx.skins.ProgrammaticSkin;
	import org.osmf.layout.ScaleMode;
	
	[Style(name="titleBarBorderColor", format="Color", inherit="yes", type="uint")]
	[Style(name="titleBarBorderAlpha", format="Number", inherit="yes")]
	[Style(name="titleBarBorderThickness", format="Number", inherit="yes")]
	[Style(name="titleBarCornerRadius", format="Number", inherit="yes")]
	
	/**
	 *  The skin for the TitleBar of a WindowedApplication or Window.
	 *  @langversion 3.0
	 *  @playerversion AIR 1.1
	 *  @productversion Flex 3
	 */
	public class ApplicationTitleBarBackgroundSkin extends ProgrammaticSkin {
				
		/**
		 *  Constructor.
		 *  
		 *  @langversion 3.0
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public function ApplicationTitleBarBackgroundSkin() {
			super();
		}

		override protected function updateDisplayList (w:Number, h:Number) : void {
			
			super.updateDisplayList(w, h);
			
			// Collect styles
			var fillColors : Array = getStyle ('titleBarColors');
			var cornerRadius : Number = getStyle ('titleBarCornerRadius');
			var rawBorderColor : Object = getStyle ('titleBarBorderColor');
			var borderAlpha : Number = getStyle ('titleBarBorderAlpha');
			var borderThickness : Number = getStyle ('titleBarBorderThickness');
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
					{tl: cornerRadius, tr: cornerRadius, bl: 0, br: 0},
					fillColors, 
					[ 1.0, 1.0 ],
					verticalGradientMatrix (0, 0, w, h));
				
				// Border
				if (borderThickness > 0 && borderAlpha > 0) {
					var halfBorder : Number = (borderThickness * 0.5);
					var innerW : Number = (w - halfBorder);
					var innerH : Number = (h - halfBorder);
					graphics.lineStyle (borderThickness, borderColor, borderAlpha, true, ScaleMode.NONE, CapsStyle.SQUARE, JointStyle.BEVEL);
					graphics.moveTo (halfBorder, innerH);
					graphics.lineTo (halfBorder, cornerRadius);
					graphics.curveTo (halfBorder, halfBorder, cornerRadius, halfBorder);
					graphics.lineTo (innerW - cornerRadius, halfBorder);
					graphics.curveTo (innerW, halfBorder, innerW, cornerRadius);
					graphics.lineTo (innerW, innerH);
					graphics.moveTo (halfBorder, innerH);
					graphics.lineTo (innerW, innerH);
				}
			}
		}
	}
}

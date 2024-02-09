package eu.claudius.iacob.windows.test.skins {

	import flash.display.Graphics;
	
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;
	import mx.states.SetProperty;
	import mx.states.State;
	
	import spark.components.Group;
	import spark.core.SpriteVisualElement;
	
	import ro.ciacob.utils.ColorUtils;

	/**
	 *  The skin for the close button in the TitleBar
	 *  of a WindowedApplication or Window.
	 */
	public class FXGButtonSkin extends UIComponent {

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		/**
		 *  Constructor.
		 */
		public function FXGButtonSkin() {
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Fields
		//
		//--------------------------------------------------------------------------
		
		private static const DEFAULT_ALPHA : Number = 0.0001; 

		private var _shapesHolder : Group;
		private var _g : Graphics;
		private var _up : SpriteVisualElement;
		private var _over : SpriteVisualElement;
		private var _down : SpriteVisualElement;
		private var _disabled : SpriteVisualElement;
		private var _defaultColor : Number;
		private var _defaultBgColor : Number;

		//--------------------------------------------------------------------------
		//
		//  Overriddable properties
		//
		//--------------------------------------------------------------------------
		
		override public function get measuredWidth():Number {		
			return 21;
		}
		
		override public function get measuredHeight():Number {
			return 21;
		}
		
		protected function get upSkin():Class {
			return null;
		}
		
		protected function get overSkin():Class {
			return null;
		}
		
		protected function get downSkin():Class {
			return null;
		}
		
		protected function get disabledSkin():Class {
			return null;
		}
		
		protected function get upColor () : Number {
			return NaN;
		}
		
		protected function get overColor () : Number {
			return NaN;
		}

		protected function get downColor () : Number {
			return NaN;
		}

		protected function get disabledColor () : Number {
			return NaN;
		}
		
		protected function get bgColor () : Number {
			return NaN;
		}
		
		protected function get bgAlpha () : Number {
			return NaN;
		}

		//--------------------------------------------------------------------------
		//
		//  Overridden methods: UIComponent
		//
		//--------------------------------------------------------------------------

		/**
		 *  @private
		 */
		override protected function createChildren():void {
			
			// Initialize skin parts, whichever given
			_shapesHolder = new Group;
			
			if (upSkin) {
				_up = (new upSkin) as SpriteVisualElement;
				_shapesHolder.addElement(_up);
				_up.visible = true;
				_up.percentWidth = _up.percentHeight = 100;
			}
			if (overSkin || upSkin) {
				_over = (new (overSkin || upSkin)) as SpriteVisualElement;
				_shapesHolder.addElement(_over);
				_over.visible = false;
				_over.percentWidth = _over.percentHeight = 100;
			}
			if (downSkin || overSkin || upSkin) {
				_down = (new (downSkin || overSkin || upSkin)) as SpriteVisualElement;
				_shapesHolder.addElement(_down);
				_down.visible = false;
				_down.percentWidth = _down.percentHeight = 100;
			}
			if (disabledSkin || downSkin || overSkin || upSkin) {
				_disabled = (new (disabledSkin || downSkin || overSkin || upSkin)) as SpriteVisualElement;
				_shapesHolder.addElement(_disabled);
				_disabled.visible = false;
				_disabled.percentWidth = _disabled.percentHeight = 100;
			}
			
			if ( upSkin && 
				 !overSkin && 
				 !downSkin &&
				 isNaN (upColor) &&
				 isNaN (overColor) &&
				 isNaN (downColor) &&
				 isNaN (disabledColor)
			) {	
					ColorUtils.tintSprite (defaultColor as uint, _up);
					_up.alpha = 0.75;
					
					ColorUtils.tintSprite (defaultColor as uint, _over);
					
					ColorUtils.tintSprite (defaultColor as uint, _down);
					_down.alpha = 0.6;
					
					ColorUtils.tintSprite (defaultColor as uint, _disabled);
					_disabled.alpha = 0.4;
			} else {
				if (!isNaN (upColor) && _up) {
					ColorUtils.tintSprite (upColor as uint, _up);
				}
				if (!isNaN (overColor) && _over) {
					ColorUtils.tintSprite (overColor as uint, _over);
				}
				if (!isNaN (downColor) && _down) {
					ColorUtils.tintSprite (downColor as uint, _down);
				}
				if (!isNaN (disabledColor) && _disabled) {
					ColorUtils.tintSprite (disabledColor as uint, _disabled);
				}
			}

			addChild(_shapesHolder);
			initializeStates();
		}

		override protected function updateDisplayList(w:Number, h:Number):void {
			super.updateDisplayList(w, h);
			_shapesHolder.setActualSize(measuredWidth, measuredHeight);
			_shapesHolder.move(0, 0);
			_g = _shapesHolder.graphics;
			_g.clear();
			_g.beginFill (isNaN (bgColor)? defaultBgColor : bgColor , isNaN(bgAlpha)? DEFAULT_ALPHA : bgAlpha);
			_g.drawRect (0, 0, measuredWidth, measuredHeight);
			_g.endFill();
		}

		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------

		private function get defaultColor () : uint {
			if (isNaN (_defaultColor)) {
				_defaultColor = FlexGlobals.topLevelApplication.getStyle('color');
			}
			return _defaultColor;
		}
		
		private function get defaultBgColor () : uint {
			if (isNaN (_defaultBgColor)) {
				_defaultBgColor = FlexGlobals.topLevelApplication.getStyle('backgroundColor');
			}
			return _defaultBgColor;
		}
		
		/**
		 *  @private
		 */
		private function initializeStates():void {

			// Props
			
			// up
			var upVisibleProp:SetProperty = new SetProperty();
			upVisibleProp.name="visible";
			upVisibleProp.target=_up;
			upVisibleProp.value=true;
			
			var upHiddenProp:SetProperty = new SetProperty();
			upHiddenProp.name="visible";
			upHiddenProp.target=_up;
			upHiddenProp.value=false;
			
			// over
			var overVisibleProp:SetProperty = new SetProperty();
			overVisibleProp.name="visible";
			overVisibleProp.target=_over;
			overVisibleProp.value=true;
			
			var overHiddenProp:SetProperty = new SetProperty();
			overHiddenProp.name="visible";
			overHiddenProp.target=_over;
			overHiddenProp.value=false;
			
			// down
			var downVisibleProp:SetProperty = new SetProperty();
			downVisibleProp.name="visible";
			downVisibleProp.target=_down;
			downVisibleProp.value=true;
			
			var downHiddenProp:SetProperty = new SetProperty();
			downHiddenProp.name="visible";
			downHiddenProp.target=_down;
			downHiddenProp.value=false;
			
			// disabled
			var disabledVisibleProp:SetProperty = new SetProperty();
			disabledVisibleProp.name="visible";
			disabledVisibleProp.target=_disabled;
			disabledVisibleProp.value=true;
			
			var disabledHiddenProp:SetProperty = new SetProperty();
			disabledHiddenProp.name="visible";
			disabledHiddenProp.target=_disabled;
			disabledHiddenProp.value=false;
			
			// States
			
			// Up
			var upState:State=new State();
			upState.name="up";
			upState.overrides.push (upVisibleProp, overHiddenProp, downHiddenProp, disabledHiddenProp);
			states.push(upState);

			// Over
			var overState:State=new State();
			overState.name="over";
			overState.overrides.push (overVisibleProp, upHiddenProp, downHiddenProp, disabledHiddenProp);
			states.push(overState);

			// Down
			var downState:State=new State();
			downState.name="down";
			downState.overrides.push(downVisibleProp, upHiddenProp, overHiddenProp, disabledHiddenProp);
			states.push(downState);

			var disabledState:State=new State;
			disabledState.name='disabled';
			disabledState.overrides.push(disabledVisibleProp, upHiddenProp, overHiddenProp, downHiddenProp);
			states.push(disabledState);

		}
	}

}

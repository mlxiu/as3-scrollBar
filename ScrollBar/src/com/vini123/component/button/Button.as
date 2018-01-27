package com.vini123.component.button
{
	import com.vini123.implement.IDestroy;
	import com.vini123.utils.DestroyUtils;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * 
	 * @author vini123
	 *  三态 + select（按钮组的时候也许会用到。与鼠标状态无关）
	 */	
	public class Button extends Sprite implements IDestroy
	{
		public static const OUT_STATE:int = 1;
		public static const OVER_STATE:int = 2;
		public static const DOWN_STATE:int = 3;
		public static const SELECT_STATE:int = 4;
		public static const DISABLE_STATE:int = 5;
		
		private var currSkin:DisplayObject = null;
		
		private var outSkin:DisplayObject = null;
		private var overSkin:DisplayObject = null;
		private var downSkin:DisplayObject = null;
		private var selectSkin:DisplayObject = null;
		private var disableSkin:DisplayObject = null;
		
		private var _enabled:Boolean = true;
		protected var _state:int = OUT_STATE;
		
		public function Button()
		{
			mouseChildren = false;
			enabled = true;
		}
		
		protected function overHandler(e:MouseEvent):void
		{
			state = OVER_STATE;
		}
		
		protected function outHandler(e:MouseEvent):void
		{
			state = OUT_STATE;
		}
		
		protected function downHandler(e:MouseEvent):void
		{
			state = DOWN_STATE;
		}
	
		public function setOutSkin(value:DisplayObject):void
		{
			if(!value)
				return;
			
			DestroyUtils.destroyObject(outSkin);
			
			outSkin = value;
			redraw();
		}
		
		/**
		 * 
		 * @param value
		 *   鼠标移上去的皮肤
		 */		
		public function setOverSkin(value:DisplayObject):void
		{
			if(!value)
				return;
			
			DestroyUtils.destroyObject(overSkin);
			
			overSkin = value;
			redraw();
		}
		
		/**
		 * 
		 * @param value
		 *  鼠标按下的皮肤
		 */		
		public function setDownSkin(value:DisplayObject):void
		{
			if(!value)
				return;
			
			DestroyUtils.destroyObject(downSkin);
			
			downSkin = value;
			redraw();
		}
		
		/**
		 * 
		 * @param value
		 *  按钮组按下时候的皮肤
		 */		
		public function setSelectSkin(value:DisplayObject):void
		{
			if(!value)
				return;
			
			DestroyUtils.destroyObject(selectSkin);
			
			selectSkin = value;
			redraw();
		}
		
		/**
		 * 
		 * @param value
		 *  设置不可用状态
		 */		
		public function setDisableSkin(value:DisplayObject):void
		{
			if(!value)
				return;
			
			DestroyUtils.destroyObject(disableSkin);
			
			disableSkin = value;
			redraw();
		}
		
		protected function redraw():void
		{
			var skin:DisplayObject;
			if(_state == OUT_STATE)
			{
				skin = outSkin;
			}
			else if(_state == OVER_STATE)
			{
				skin = overSkin ? overSkin : outSkin;
			}
			else if(_state == DOWN_STATE)
			{
				skin = downSkin ? downSkin : outSkin;
			}
			else if(_state == SELECT_STATE)
			{
				skin = selectSkin ? selectSkin : outSkin;
			}
			else if(_state == DISABLE_STATE)
			{
				skin = disableSkin ? disableSkin : outSkin;
			}
			setCurrSkin(skin);
		}
		
		private function setCurrSkin(value:DisplayObject):void
		{
			if(currSkin)
			{
				if(currSkin.parent == this)
				{
					removeChild(currSkin);
				}
				currSkin = null;
			}
			
			if(value)
			{
				currSkin = value;
				addChildAt(currSkin , 0);
			}
		}
		
		/**
		 * 
		 * @param value
		 *  鼠标事件能否可用
		 */		
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
			if(_enabled)
			{
				addEvent();
			}
			else
			{
				removeEvent();
			}
		}
		
		/**
		 * 
		 * @return 
		 *  鼠标事件可用否
		 */		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		public function set state(value:int):void
		{
			if(_state != value)
			{
				_state = value;
				redraw();
			}
		}
		
		public function get state():int
		{
			return _state;
		}
		
		/**
		 * 添加事件
		 * 
		 */		
		private function addEvent():void
		{
			if(hasEventListener(MouseEvent.ROLL_OVER))
				return;
			
			buttonMode = true;
			addEventListener(MouseEvent.ROLL_OVER , overHandler);
			addEventListener(MouseEvent.ROLL_OUT , outHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
		}
		
		/**
		 * 移除事件 
		 * 
		 */		
		private function removeEvent():void
		{
			if(!hasEventListener(MouseEvent.ROLL_OVER))
				return;
			
			buttonMode = false;
			removeEventListener(MouseEvent.ROLL_OVER , overHandler);
			removeEventListener(MouseEvent.ROLL_OUT , outHandler);
			removeEventListener(MouseEvent.MOUSE_DOWN, downHandler);
		}
		
		/**
		 * 
		 * @return 
		 *  宽度
		 */		
		override public function get width():Number
		{
			if(currSkin)
				return currSkin.width;
			return 0;
		}
		
		override public function set width(value:Number):void
		{
			if(value <= 0)
				return;
			
			if(currSkin)
				currSkin.width = value;
			
			if(outSkin)
				outSkin.width = value;
			
			if(overSkin)
				overSkin.width = value;
			
			if(downSkin)
				downSkin.width = value;
			
			if(selectSkin)
				selectSkin.width = value;
		}
		
		/**
		 * 
		 * @return 
		 *  高度
		 */		
		override public function get height():Number
		{
			if(currSkin)
				return currSkin.height;
			return 0;
		}
		
		override public function set height(value:Number):void
		{
			if(value <= 0)
				return;
			
			if(currSkin)
				currSkin.height = value;
			
			if(outSkin)
				outSkin.height = value;
			
			if(overSkin)
				overSkin.height = value;
			
			if(downSkin)
				downSkin.height = value;
			
			if(selectSkin)
				selectSkin.height = value;
		}
		
		/**
		 * 销毁 
		 * 
		 */		
		public function destroy():void
		{
			removeEvent();
			
			if(outSkin)
			{
				DestroyUtils.destroyObject(outSkin);
				outSkin = null;
			}
			
			if(overSkin)
			{
				DestroyUtils.destroyObject(overSkin);
				overSkin = null;
			}
			
			if(downSkin)
			{
				DestroyUtils.destroyObject(downSkin);
				downSkin = null;
			}
			
			if(selectSkin)
			{
				DestroyUtils.destroyObject(selectSkin);
				selectSkin = null;
			}
			
			if(disableSkin)
			{
				DestroyUtils.destroyObject(disableSkin);
				disableSkin = null;
			}
			
			if(currSkin)
			{
				currSkin = null;
			}
		}
	}
}
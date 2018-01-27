package com.vini123.component.scrollBar
{
	import com.vini123.component.button.Button;
	import com.vini123.implement.IScrollBar;
	
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 * 
	 * @author vini123
	 * @date 2015/02/12
	 */	
	
	public class ScrollBarBase extends Sprite implements IScrollBar
	{
		private var _updateTargetPositionCallBack:Function;
		private var _mouseWheelTarget:InteractiveObject = null;
		
		protected var _width:int;
		protected var _height:int;
		protected var _position:Number;
		protected var _padding:int;
		protected var _dragBarMinSize:int;
		protected var _pageSize:int;
		protected var _distanceOfMove:int;
		protected var _isDrag:Boolean;
		
		protected var rect:Rectangle;
		
		protected var upBar:Button;
		protected var downBar:Button;
		protected var lineBar:Button;
		protected var dragBar:Button;
		
		
		public function ScrollBarBase()
		{
			initialize();
		}

		private function initialize():void
		{
			initVariable();
			initButton();
			initEvent();
		}
		
		private function initVariable():void
		{
			_position = 0;
			_padding = 2;
			_dragBarMinSize = 25;
			_distanceOfMove = 5;
		}
		
		private function initButton():void
		{
			upBar = new Button();
			addChild(upBar);
			
			downBar = new Button();
			addChild(downBar);
			
			lineBar = new Button();
			addChild(lineBar);
			
			dragBar = new Button();
			addChild(dragBar);
		}
		
		private function initEvent():void
		{
			upBar.addEventListener(MouseEvent.CLICK , upBarHandler);
			downBar.addEventListener(MouseEvent.CLICK , downBarHandler);
			dragBar.addEventListener(MouseEvent.MOUSE_DOWN , dragBarDownHandler);
		}
		
		protected function upBarHandler(e:MouseEvent):void
		{
			throw new Error("this can't run");
		}
		
		protected function downBarHandler(e:MouseEvent):void
		{
			throw new Error("this can't run");
		}
		
		protected function dragBarDownHandler(e:MouseEvent):void
		{
			_isDrag = true;
			dragBar.addEventListener(MouseEvent.MOUSE_UP , dragBarUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP , dragBarUpHandler);
			addEventListener(Event.ENTER_FRAME , enterHandler);
		}
		
		protected function enterHandler(e:Event):void
		{
			throw new Error("this can't run");
		}
		
		protected function dragBarUpHandler(e:MouseEvent):void
		{
			removeEventListener(Event.ENTER_FRAME , enterHandler);
			dragBar.removeEventListener(MouseEvent.MOUSE_UP , dragBarUpHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP , dragBarUpHandler);
			_isDrag = false;
		}
	
		protected function mouseWheelHandler(e:MouseEvent):void
		{
			throw new Error("this can't run");
		}
		
		protected function redrawDragBar():void
		{
			throw new Error("this can't run");
		}
		
		protected function get dragBarCanMoveDistance():int
		{
			return 0;
		}
		
		protected function updateTargetPosition():void
		{
			if(_updateTargetPositionCallBack != null)
			{
				_updateTargetPositionCallBack(position);
			}
		}
		
		public function set updateTargetPositionCallBack(value:Function):void
		{
			_updateTargetPositionCallBack = value;
		}
		
		override public function set height(value:Number):void
		{
			if(value != _height)
			{
				_height = value;
				redrawAllBar();
			}
		}
		
		override public function set width(value:Number):void
		{
			if(value != _width)
			{
				_width = value;
				redrawAllBar();
			}
		}
		
		protected function redrawAllBar():void
		{
		
		}
		
		public function setMouseWheelTarget(value:InteractiveObject):void
		{
			if(value != _mouseWheelTarget)
			{
				if(_mouseWheelTarget != null)
				{
					_mouseWheelTarget.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
					_mouseWheelTarget = null;
				}
				
				if(value != null)
				{
					_mouseWheelTarget = value;
					_mouseWheelTarget.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
				}
			}
		}
		
		public function get position():Number
		{
			return _position;
		}
		
		public function set position(value:Number):void
		{
			throw new Error("this can't run");
		}
		
		/**
		 * 
		 * @param value 设置按钮之间间隔
		 * 
		 */		
		public function set padding(value:int):void
		{
			_padding = value;
		}
		
		/**
		 * 
		 * @param value 镜像拖动对象的大小
		 * 
		 */		
		public function set pageSize(value:int):void
		{
			if(_pageSize != value)
			{
				_pageSize = value;
				
				if(!_isDrag)
				{
					redrawDragBar();
				}
			}
		}
		
		/**
		 * 
		 * @param value dragBar的最小高度（宽度）
		 * 
		 */		
		public function set dragBarMinSize(value:int):void
		{
			_dragBarMinSize = value;
		}
		
		public function get isDrag():Boolean
		{
			return _isDrag;
		}
		/**
		 * 
		 * @param value 点击upBar或downBar一次，dragBar移动的像素数
		 * 
		 */		
		public function set distanceOfMove(value:int):void
		{
			_distanceOfMove = value;
		}

		/**
		 * 
		 * @return  获取按钮
		 * 
		 */		
		public function getUpBar():Button
		{
			return upBar;
		}
		
		public function getDownBar():Button
		{
			return downBar;
		}
		
		public function getLineBar():Button
		{
			return lineBar;
		}
		
		public function getDragBar():Button
		{
			return dragBar;
		}
	}
}
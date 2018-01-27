package com.vini123.component.scrollBar
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * 
	 * @author vini123
	 * @date 2015/02/12
	 * @describe 竖向滚动条
	 */	
	public class VScrollBar extends ScrollBarBase
	{
		public function VScrollBar()
		{
			super();
		}
		
		override protected function upBarHandler(e:MouseEvent):void
		{
			dragBar.y -= _distanceOfMove;
			adjustDragBarPosition();
			updateTargetPosition();
		}
		
		override protected function downBarHandler(e:MouseEvent):void
		{
			dragBar.y += _distanceOfMove;
			adjustDragBarPosition();
			updateTargetPosition();
		}
		
		override protected function dragBarDownHandler(e:MouseEvent):void
		{
			super.dragBarDownHandler(e);
			rect = new Rectangle(dragBar.x , upBar.height + _padding , 0 , dragBarCanMoveDistance);
			dragBar.startDrag(false , rect);
		}
		
		override protected function dragBarUpHandler(e:MouseEvent):void
		{
			super.dragBarUpHandler(e);
			dragBar.stopDrag();
		}
		
		override protected function mouseWheelHandler(e:MouseEvent):void
		{
			dragBar.y -= (e.delta * _distanceOfMove);
			adjustDragBarPosition();
			updateTargetPosition();
		}
		
		override public function get position():Number
		{
			 _position = (dragBar.y - upBar.height - _padding)/dragBarCanMoveDistance;
			 return _position;
		}
		
		override public function set position(value:Number):void
		{
			if(_position != value)
			{
				_position = value;
				dragBar.y = _position * dragBarCanMoveDistance + dragBarMinPosY;
			}
		}
		
		override protected function enterHandler(e:Event):void
		{
			updateTargetPosition();
		}
		
		override protected function redrawDragBar():void
		{
			var dragBarMaxHeight:int = _height - upBar.height - downBar.height - _padding * 2;
			var dragBarHeight:int = Math.max(Math.min(dragBarMaxHeight , dragBarMaxHeight * _height/_pageSize ) , _dragBarMinSize);
			dragBar.height = dragBarHeight;
			
			dragBar.y = upBar.height + _padding + (dragBarMaxHeight - dragBarHeight) * _position;
			adjustDragBarPosition();
		}
		
		private function adjustDragBarPosition():void
		{
			if(dragBar.y < dragBarMinPosY)
			{
				dragBar.y = dragBarMinPosY;
			}
			
			if(dragBar.y > dragBarMaxPosY)
			{
				dragBar.y = dragBarMaxPosY;
			}
		}
		
		override protected function redrawAllBar():void
		{
			if(_width != 0)
			{
				upBar.width = _width;
				downBar.width = _width;
				lineBar.width = _width;
				dragBar.width = _width;
			}
			
			if(_height != 0)
			{
				lineBar.height = _height - upBar.height - downBar.height - _padding * 2;
			}
			
			upBar.y = 0;
			lineBar.y = upBar.height + _padding;
			downBar.y = _height - downBar.height;
			dragBar.y = dragBarMinPosY;
			
			redrawDragBar();
		}
		
		private function get dragBarMinPosY():int
		{
			return upBar.height + _padding
		}
		
		private function get dragBarMaxPosY():int
		{
			return _height - downBar.height - _padding - dragBar.height;
		}
		
		/**
		 * 
		 * @return dragBar能够移动的距离
		 * 
		 */		
		override protected function get dragBarCanMoveDistance():int
		{
			return _height - upBar.height - downBar.height - _padding * 2 - dragBar.height;
		}
	}
}
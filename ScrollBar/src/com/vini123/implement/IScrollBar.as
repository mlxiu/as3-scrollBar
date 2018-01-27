/**
 *  下拉条，不一定有upBar，downBar，lineBar，一定有dragBar 
 */
package com.vini123.implement
{
	import com.vini123.component.button.Button;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;

	/**
	 * 
	 * @author vini123
	 * @date 2015/02/21
	 */	
	public interface IScrollBar
	{
		function set position(value:Number):void; //被拖动对象的位置占比
		function get position():Number; //dragBar的位置占比
		function set padding(value:int):void //按钮之间的间隔
		function set pageSize(value:int):void;//被拖动对象的高度（VScroll）或宽度（HScroll）
		function set dragBarMinSize(value:int):void //dragBar的最小高度（VScroll）或最小宽度（HScroll）
		function set distanceOfMove(value:int):void; //点击upBar，downBar时，dragBar一次移动的距离。
		
		function setMouseWheelTarget(value:InteractiveObject):void; //鼠标滑轮对象
		function set updateTargetPositionCallBack(value:Function):void;//拖动滑块回调函数
		function get isDrag():Boolean;
		
		function getUpBar():Button; //顶部或左边Button
		function getDownBar():Button; //底部或右边Button
		function getLineBar():Button; //dragBar底下的Button
		function getDragBar():Button; //dragBar拖动Button
		
		function set x(value:Number):void;
		function get x():Number;
		function set y(value:Number):void;
		function get y():Number;
		function set width(value:Number):void;
		function get width():Number;
		function set height(value:Number):void;
		function get height():Number;
		function set visible(value:Boolean):void;
		function get visible():Boolean;
		function get parent():DisplayObjectContainer;
		function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
	}
}
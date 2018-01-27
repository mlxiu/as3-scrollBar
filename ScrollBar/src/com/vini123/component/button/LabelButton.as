package com.vini123.component.button
{
	import com.vini123.component.text.Label;

	/**
	 * 
	 * @author vini123
	 *  简化label按钮，鼠标移上去最多改变文字的颜色，其他不变
	 *  
	 */	
	public class LabelButton extends Button
	{	
		/**
		 * 如果设置了皮肤。文字距皮肤左右两端的最小间距。 
		 */		
		private const PADDING_LR:int = 16;
		
		/**
		 * 如果文字太多，使得大于最小间距。就切割文字，并用signs追加 
		 */		
		public var signs:String = "";
		
		private var _label:Label;
		
		private var outTxtColor:int;
		
		private var overTxtColor:int;
		
		private var downTxtColor:int;
		
		private var selectTxtColor:int;
		
		private var disableTxtColor:int;
		
		
		/**
		 * 
		 * @param label
		 * @param font
		 * @param size
		 * @param color
		 * @param bold
		 * @describe 默认是文字居中。想要文字和图片位置不一样。可以继承该按钮，继续重写layout扩展
		 */	
		
		public function LabelButton(label:String = "" , font:String = "微软雅黑" , size:int = 12 , color:uint = 0xffffff , bold:Boolean = false)
		{
			super();
			
			_label = new Label(label , font , size , color , bold);
			addChild(_label);
			
			outTxtColor = color;
		}
		
		/**
		 * 
		 * @param value
		 *  设置默认文字的颜色
		 */		
		public function setOutTxtColor(value:int):void
		{
			outTxtColor = value;
		}
		
		/**
		 * 
		 * @param value
		 *  设置鼠标移上去的文字颜色
		 */		
		public function setOverTxtColor(value:int):void
		{
			overTxtColor = value;
		}
		
		/**
		 * 
		 * @param value
		 *  设置鼠标按下，文字的颜色
		 */		
		public function setDownTxtColor(value:int):void
		{
			downTxtColor = value;
		}
		
		/**
		 * 
		 * @param value
		 *  选中时候颜色
		 */		
		public function setSelectTxtColor(value:int):void
		{
			selectTxtColor = value;
		}
		
		/**
		 * 
		 * @param value
		 *  不可用时候颜色
		 */		
		public function setDisableTxtColor(value:int):void
		{
			disableTxtColor = value;
		}
		
		override public function set enabled(value:Boolean):void
		{
			super.enabled = value;	
			
			state = OUT_STATE;
			
			if(!_label)
				return;
			
			if(!value)
			{
				_label.color = disableTxtColor;
			}
			else
			{
				_label.color = outTxtColor;
			}
		}
		
		override protected function redraw():void
		{
			super.redraw();
			
			var color:int;
			if(_state == OUT_STATE)
			{
				color = outTxtColor;
			}
			else if(_state == OVER_STATE)
			{
				color = overTxtColor ? overTxtColor : outTxtColor;
			}
			else if(_state == DOWN_STATE)
			{
				color = downTxtColor ? downTxtColor : outTxtColor;
			}
			else if(_state == SELECT_STATE)
			{
				color = selectTxtColor ? selectTxtColor : outTxtColor;
			}
			else if(_state == DISABLE_STATE)
			{
				color = disableTxtColor ? disableTxtColor : outTxtColor;
			}
			
			_label.color = color;
			
			layout();
		}
		
		/**
		 * 布局皮肤和文字 
		 * 
		 */		
		private function layout():void
		{
			_label.maxWidth = 0;
			if(super.width !=0 && _label.width >= super.width)
			{
				_label.signs = signs;
				_label.maxWidth = super.width - PADDING_LR;
			}
			
			if(_label.width < super.width)
			{
				_label.x = super.width * 0.5 - _label.width * 0.5;
				_label.y = super.height * 0.5 - _label.height * 0.5;
			}
		}

		override public function get width():Number
		{
			if(super.width == 0)
			{
				return _label.width;
			}
			return super.width;
		}
		
		override public function get height():Number
		{
			if(super.height == 0)
			{
				return _label.height;
			}
			return super.height;
		}
		
		/**
		 * 
		 * @return 
		 *  按钮里边的完整文字
		 */	
		public function get label():String
		{
			return _label.text;
		}
		
		public function set label(value:String):void
		{
			_label.text = value;
			layout();
		}
		
		/**
		 * 
		 * @return 
		 *  返回真实的label
		 */		
		public function get rawLabel():Label
		{
			return _label;
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			if(_label && _label.parent)
			{
				_label.parent.removeChild(_label);
				_label.destroy();
				_label = null;
			}
		}
	}
}
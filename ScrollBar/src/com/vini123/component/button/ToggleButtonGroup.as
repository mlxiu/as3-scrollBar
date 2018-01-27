package com.vini123.component.button
{
	import flash.events.MouseEvent;

	/**
	 * 
	 * @author vini123
	 *  按钮组（应先添加按钮组，再外部自己定义click事件。）
	 */	
	public class ToggleButtonGroup
	{
		private var buttonList:Vector.<Button>;
		
		public function ToggleButtonGroup()
		{
			buttonList = new Vector.<Button>();
		}
		
		/**
		 * 
		 * @param args
		 *  添加多个到按钮组中
		 */		
		public function addMultiple(...args):void
		{
			for each(var value:Object in args)
			{
				if(value is Button)
				{
					add(value as Button);
				}
			}
		}
		
		/**
		 * 
		 * @param value Button
		 *  添加到按钮组中
		 */		
		public function add(value:Button):void
		{
			buttonList.push(value);
			value.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		/**
		 * 
		 * @param value
		 *  从按钮组中移除
		 */		
		public function remove(value:Button):void
		{
			for(var i:int = 0; i < buttonList.length; i++)
			{
				if(buttonList[i] == value)
				{
					buttonList[i].removeEventListener(MouseEvent.CLICK, clickHandler);
					buttonList.splice(i, 1);
					break;
				}
			}
		}
		
		/**
		 * 
		 * @return 
		 *  获取按钮组列表
		 */		
		public function getButtonList():Vector.<Button>
		{
			return buttonList;
		}

		private function clickHandler(e:MouseEvent):void
		{
			var button:Button = (e.currentTarget as Button);
			if(!button.enabled)
			{
				e.stopImmediatePropagation();
				return;
			}
			
			for each(button in buttonList)
			{
				if(button == (e.currentTarget as Button))
				{
					button.enabled = false;
					button.state = Button.SELECT_STATE;
				}
				else
				{
					button.enabled = true;
					button.state = Button.OUT_STATE;
				}
			}
		}
		
		/**
		 * 销毁 
		 * （移除事件侦听，删除按钮列表）
		 */		
		public function destroy():void
		{
			for(var i:int = 0; i< buttonList.length; i++)
			{
				buttonList[i].removeEventListener(MouseEvent.CLICK, clickHandler);
			}
			buttonList.splice(0, buttonList.length);
		}
	}
}
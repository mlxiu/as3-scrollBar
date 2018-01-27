package com.vini123.component.text
{
	/**
	 * 
	 * @author vini123
	 *  其实没做啥
	 */	
	public class Label extends Text
	{
		public function Label(label:String, font:String="微软雅黑", size:int=12, color:uint=0xffffff, bold:Boolean=false)
		{
			super(font, size, color, bold);
		
			text = label;
		}
		
		public function get label():String
		{
			return super.text;
		}

		public function set label(value:String):void
		{
			super.text = value;
		}
	}
}
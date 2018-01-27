package com.vini123.component.system
{
	import flash.events.ContextMenuEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;

	/**
	 * 
	 * @author vini123
	 *  flash 右键
	 */	
	public class RightContextMenu
	{
		public static var contextMenu:ContextMenu = new ContextMenu();
		
		public function RightContextMenu()
		{
			
		}
		
		
		/**
		 * 
		 * @param name 右键中文label
		 * @param url 跳转的链接
		 * @param separatorBefore 右键上方是否显示横线
		 * @param enabled 是否可用
		 * @param visible 是否显示
		 *  
		 */			
		public static function addLinkItem(name:String , url:String = null , separatorBefore:Boolean = false, enabled:Boolean = true, visible:Boolean = true):void
		{
			var contextItemMenu:ContextMenuItem = new ContextMenuItem(name , separatorBefore , enabled , visible);
			contextItemMenu.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT , function(e:ContextMenuEvent):void
			{
				if(url)
				{
					navigateToURL(new URLRequest(url) , "_blank");
				}
			});
			contextMenu.customItems.push(contextItemMenu);
		}
		
		/**
		 * 
		 * @param name 右键中文label
		 * @param fun 回调函数
		 * @param separatorBefore 右键上方是否显示横线
		 * @param enabled 是否可用
		 * @param visible 是否显示
		 *  
		 */		
		public static function addFunItem(name:String , fun:Function , separatorBefore:Boolean = false, enabled:Boolean = true, visible:Boolean = true):void
		{
			var contextItemMenu:ContextMenuItem = new ContextMenuItem(name , separatorBefore , enabled , visible);
			contextItemMenu.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT , function(e:ContextMenuEvent):void
			{
				if(fun != null)
				{
					fun();
				}
			});
			contextMenu.customItems.push(contextItemMenu);
		}
	}
}
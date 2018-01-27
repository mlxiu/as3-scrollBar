package com.vini123.utils
{
	import com.vini123.implement.IDestroy;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;

	public class DestroyUtils
	{
		public function DestroyUtils()
		{
			
		}
		
		public static function destroyObject(value:Object):void
		{
			if(!value)return;
			
			if(value is IDestroy)
			{
				(value as IDestroy).destroy();
			}
			else if(value is Bitmap)
			{
				if((value as Bitmap).bitmapData)
				{
					(value as Bitmap).bitmapData.dispose();
				}
			}
			else if(value is BitmapData)
			{
				(value as BitmapData).dispose();
			}
			else if(value is MovieClip)
			{
				try
				{
					(value as MovieClip).stopAllMovieClips();
				}
				catch(e:Error)
				{
				
				}
			}
			else if(value is Sprite)
			{
				(value as Sprite).graphics.clear();
			}
			else if(value is Shape)
			{
				(value as Shape).graphics.clear();
			}
			else if(value is Loader)
			{
				(value as Loader).unloadAndStop();
			}
		}
	}
}
/*
|----------------------------------------------------------------------------------------------------
| creatShape 适宜创建动态宽高可带弧度可带边框的矩形矢量图（动态宽高时，带边框不适合）
|----------------------------------------------------------------------------------------------------
| eg： var shape:Shape = RectBitmap.createShape(72 , 45 , 8 , 8 , 0xf4fafc , 1.5 , 0x0f0af);
|     addChild(shape);
| 
|----------------------------------------------------------------------------------------------------
| crecteFixBitmap 适宜创建固定宽高可带弧度可带边框的矩形位图
|----------------------------------------------------------------------------------------------------
| eg： var shape:Shape = RectBitmap.crecteFixBitmap(72 , 45 , 8 , 8 , 0xf4fafc , 1.5 , 0x0f0af);
|     addChild(shape);
| 
|----------------------------------------------------------------------------------------------------
| crecteScaleBitmap 适宜创建动态宽高可带弧度可带边框的矩形位图（如果功能不需要动态宽高，请用crecteFixBitmap）
|                   该API还有一个亮点，就是适宜有title的窗体。title部分和主体部分颜色不一。
|----------------------------------------------------------------------------------------------------
| eg： var scaleBitmap:ScaleBitmap = RectBitmap.crecteScaleBitmap(100 , 80 , 10 , 10 , 0xf4fafc , 0x99d8e4 , 40 , 1.5 , 0xcde1f4);
|     addChild(scaleBitmap);
|     scaleBitmap.width = 480;
|	  scaleBitmap.height = 360;
|
*/

package com.vini123.component.bitmap
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Rectangle;

	/**
	 * 
	 * @author vini123
	 *  面板生成器
	 */	
	public class RectBitmap
	{
		public function RectBitmap()
		{
			
		}
		
		/**
		 * 
		 * @param w 宽度
		 * @param h 高度
		 * @param topRadius 顶部的radius
		 * @param bottomRadius 底部的radius
		 * @param color 背景颜色
		 * @param borderThickness 边框颜色
		 * @param borderColor 边框线条粗细
		 * @return 
		 *  任意宽高的矢量图 (如果想变形，最好不要带边框。想实现带边框变形，可使用下边的API -> crectScaleBitmap)
		 */	
		public static function createShape(w:int , h:int , topRadius:int , bottomRadius:int , color:int , borderThickness:Number = 0 , borderColor:int = 0):Shape
		{
			var drawSource:Shape = new Shape();
			drawSource.graphics.beginFill(color , 1);
			drawSource.graphics.drawRoundRectComplex(0 , 0 , w , h , topRadius , topRadius , bottomRadius , bottomRadius);
			drawSource.graphics.endFill();
			
			if(borderThickness > 0)
			{
				drawSource.graphics.lineStyle(borderThickness , borderColor , 1 , true);
				drawSource.graphics.beginFill(color , 0);
				drawSource.graphics.drawRoundRectComplex(borderThickness * 0.5 , borderThickness * 0.5 , w - borderThickness , h - borderThickness ,
					topRadius , topRadius , bottomRadius , bottomRadius);
				drawSource.graphics.endFill();
			}
			return drawSource;
		}
	
		/**
		 * 
		 * @param w 宽度
		 * @param h 高度
		 * @param topRadius 顶部的radius
		 * @param bottomRadius 底部的radius
		 * @param color 背景颜色
		 * @param borderThickness 边框颜色
		 * @param borderColor 边框线条粗细
		 * @return 
		 *  固定宽高的位图
		 */		
		public static function crecteFixBitmap(w:int , h:int , topRadius:int , bottomRadius:int , color:int , borderThickness:Number = 0 , borderColor:int = 0):Bitmap
		{
			var drawSource:Shape = new Shape();
			drawSource.graphics.beginFill(color , 1);
			drawSource.graphics.drawRoundRectComplex(0 , 0 , w , h , topRadius , topRadius , bottomRadius , bottomRadius);
			drawSource.graphics.endFill();
			
			if(borderThickness > 0)
			{
				drawSource.graphics.lineStyle(borderThickness , borderColor , 1 , true);
				drawSource.graphics.beginFill(color , 0);
				drawSource.graphics.drawRoundRectComplex(borderThickness * 0.5 , borderThickness * 0.5 , w - borderThickness , h - borderThickness ,
					topRadius , topRadius , bottomRadius , bottomRadius);
				drawSource.graphics.endFill();
			}
			
			var bitmapData:BitmapData = new BitmapData(w , h , true , 0);
			bitmapData.draw(drawSource);
			drawSource.graphics.clear();
			drawSource = null;
			return new Bitmap(bitmapData);
		}
		
		/**
		 * 
		 * @param w 宽度
		 * @param h 高度
		 * @param topRadius 顶部的圆角
		 * @param bottomRadius 底部的圆角
		 * @param color 颜色
		 * @param topColor 顶部颜色
		 * @param topHeight 顶部高度
		 * @param lineThickness 边框粗细
		 * @param lineColor 边框颜色
		 * @return 
		 *  改变宽高的位图。单宽高不能小于设置好的Rectangle范围。
		 */		
		public static function crecteScaleBitmap(w:int , h:int , topRadius:int , bottomRadius:int , color:int , 
												topColor:int , topHeight:int , lineThickness:Number = 0 , lineColor:int = 0xff0000):ScaleBitmap
		{
			var  maxRadius:int = Math.max(topRadius , bottomRadius);
			var borrowW:int = 4;
			var borrowH:int = 4;

			if(w - maxRadius * 2 - borrowW < 0 || h - topRadius - bottomRadius - topHeight - borrowH < 0 || topRadius > topHeight)
			{
				throw new Error("Please set right params!");
			}
			var drawSource:Shape = new Shape();
			drawSource.graphics.beginFill(topColor);
			drawSource.graphics.drawRoundRectComplex(0 , 0 , w , topHeight , topRadius , topRadius , 0 , 0 );
			drawSource.graphics.beginFill(color);
			drawSource.graphics.drawRoundRectComplex(0 , topHeight , w , h - topHeight , 0 , 0 , bottomRadius , bottomRadius);
			drawSource.graphics.endFill();
			
			if(lineThickness > 0)
			{
				drawSource.graphics.lineStyle(lineThickness , lineColor , 1 , true);
				drawSource.graphics.beginFill(color , 0);
				drawSource.graphics.drawRoundRectComplex(lineThickness * 0.5 , lineThickness * 0.5 , w - lineThickness , h - lineThickness , 
															topRadius , topRadius , bottomRadius , bottomRadius);
				drawSource.graphics.endFill();
			}
			var bitmapData:BitmapData = new BitmapData(w , h , true , 0);
			bitmapData.draw(drawSource);
			drawSource.graphics.clear();
			drawSource = null;
			
			var bitmap:ScaleBitmap = new ScaleBitmap(bitmapData);
			bitmap.scale9Grid = new Rectangle(maxRadius , topHeight , w - maxRadius * 2 - borrowW , h - topHeight - bottomRadius - borrowH);
			return bitmap;
		}

		/**
		 * 
		 * @param bgW 背景的长度
		 * @param bgH 背景的高度
		 * @param bgLineThickness 背景线条粗细
		 * @param bgRadius 背景圆角
		 * @param bgLineColor 背景线条颜色（背景自身透明）
		 * @param bgLineAlaha 背景颜色透明度
		 * @param tgW 三角宽度
		 * @param tgH 三角高度
		 * @param tgColor 三角颜色(该类画的是实心的)
		 * @param direction 三角方向： top:0, right:1, bottom:2, left:3
		 * @return 
		 * 
		 */		
		public static function createTriangle(bgW:int, bgH:int, bgLineThickness:int, bgRadius:int, bgLineColor:int, bgLineAlaha:Number, tgW:int, tgH:int, tgColor:int, direction:int):Bitmap
		{
			bgW = Math.max(bgW, tgW);
			bgH = Math.max(bgH, tgH);
			
			var drawSource:Shape = new Shape();
			drawSource.graphics.lineStyle(bgLineThickness, bgLineColor, bgLineAlaha, true);
			drawSource.graphics.beginFill(bgLineColor, 0);
			drawSource.graphics.drawRoundRect(0, 0, bgW, bgH, bgRadius, bgRadius);
			drawSource.graphics.endFill();
			
			var tgRt:Rectangle = new Rectangle((bgW - tgW) * 0.5, (bgH- tgH) * 0.5, tgW, tgH);
			drawSource.graphics.lineStyle(1, tgColor, 0);
			drawSource.graphics.beginFill(tgColor, 1);
			if(direction == 0)
			{
				drawSource.graphics.moveTo(tgRt.x + tgW * 0.5, tgRt.y -1); 
				drawSource.graphics.lineTo(tgRt.x, tgRt.y + tgH -1);
				drawSource.graphics.lineTo(tgRt.x + tgW, tgRt.y + tgH -1);
				drawSource.graphics.lineTo(tgRt.x + tgW * 0.5, tgRt.y -1);
			}
			else if(direction == 1)
			{
				drawSource.graphics.moveTo(tgRt.x + 1, tgRt.y);
				drawSource.graphics.lineTo(tgRt.x  +1, tgRt.y + tgH);
				drawSource.graphics.lineTo(tgRt.x + 1 + tgW, tgRt.y + tgH * 0.5);
				drawSource.graphics.lineTo(tgRt.x + 1, tgRt.y);
			}
			else if(direction == 2)
			{
				drawSource.graphics.moveTo(tgRt.x + tgW * 0.5 + 0.5, tgRt.y + tgH + 1); 
				drawSource.graphics.lineTo(tgRt.x + 0.5, tgRt.y + 1);
				drawSource.graphics.lineTo(tgRt.x + tgW + 0.5, tgRt.y +1);
				drawSource.graphics.lineTo(tgRt.x + tgW * 0.5 + 0.5, tgRt.y + tgH + 1);
			}
			else if(direction == 3)
			{
				drawSource.graphics.moveTo(tgRt.x - 1, tgRt.y + tgH * 0.5);
				drawSource.graphics.lineTo(tgRt.x -1 + tgW, tgRt.y + tgH);
				drawSource.graphics.lineTo(tgRt.x -1 + tgW, tgRt.y);
				drawSource.graphics.lineTo(tgRt.x - 1, tgRt.y + tgH * 0.5);
			}
			drawSource.graphics.endFill();
			
			var bitmapData:BitmapData = new BitmapData(drawSource.width , drawSource.height , true , 0);
			bitmapData.draw(drawSource);
			drawSource.graphics.clear();
			drawSource = null;
			return new Bitmap(bitmapData);
		}
	}
}
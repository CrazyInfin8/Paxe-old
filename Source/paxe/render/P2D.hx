package paxe.render;

import openfl.display.Sprite;
import openfl.display.Graphics;
import openfl.display.BitmapData;
import openfl.display.GraphicsPath;
import paxe.PRenderer;
import paxe.color.PColor;
import paxe.core.Core;
import paxe.core.Core.EllipseMode;
import paxe.core.Core.RectMode;
import paxe.core.Core.AngleMode;
class P2D implements PRenderer {
	public var width:Float = 600;
	public var height:Float = 500;
	public var renderMode:RenderMode = RenderMode.USE2D;
	public var fillColor:PColor;
	public var strokeColor:PColor;
	public var strokeWeight:Float;
	var renderer:Sprite;
	var display:Sprite;
	var g:Graphics;
	var b:BitmapData;
	public function new(s:Sprite, width, height):Void {
		this.width = width;
		this.height = height;
		display = s;
		renderer = new Sprite();
		display.addChild(renderer);
		renderer.visible = true;
		fillColor = PColor.createFromHex(0xffffff);
		strokeColor = PColor.createFromHex(0);
		strokeWeight = 1;
		g = renderer.graphics;
		b = new BitmapData(Math.round(width), Math.round(height), true, 0x00FFFFFF);
		g.beginFill(fillColor.getColorValue(), fillColor.getAlpha());
		g.lineStyle(strokeWeight, strokeColor.getColorValue(), strokeColor.getAlpha());
	}

	public function ellipse(x:Float, y:Float, a:Float, b:Float):Void {
		switch (Core.getEllipseMode()) {
			case EllipseMode.CENTER:
				g.drawEllipse(x, y, a, b);
			case EllipseMode.RADIUS:
				g.drawEllipse(x, y, a, b);
			case EllipseMode.CORNER:
				g.drawEllipse(x, y, a, b);
			case EllipseMode.CORNERS:
				g.drawEllipse(x, y, a, b);
		}
	};

	public function line(x1:Float, y1:Float, z1:Float, x2:Float, y2:Float, z2:Float):Void {
		g.moveTo(x1, y1);
		g.lineTo(x2, y2);
	};

	public function rect(x:Float, y:Float, a:Float, b:Float):Void {
		switch (Core.getRectMode()) {
			case RectMode.CENTER:
				g.drawRect(x, y, a, b);
			case RectMode.RADIUS:
				g.drawRect(x, y, a, b);
			case RectMode.CORNER:
				g.drawRect(x, y, a, b);
			case RectMode.CORNERS:
				g.drawRect(x, y, a, b);
		}
	};

	public function rrect(x:Float, y:Float, a:Float, b:Float, tl:Float, tr:Float, br:Float, bl:Float):Void {
		switch (Core.getRectMode()) {
			case CENTER:
				g.drawRoundRectComplex(x, y, a, b, tl, tr, br, bl);
			case RADIUS:
			case CORNER:
			case CORNERS:
		}
	};

	public function point(x:Float, y:Float, z:Float):Void {

	};

	public function triangle(x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float):Void {
		var gp:GraphicsPath = new GraphicsPath();
		gp.moveTo(x1, y1);
		gp.lineTo(x2, y2);
		gp.lineTo(x3, y3);
		gp.lineTo(x1, x1);
	};

	public function beginShape():Void {

	};

	public function endShape():Void {

	};

	public function fill(c:PColor):Void {
		fillColor = c;
		g.beginFill(fillColor.getColorValue(), fillColor.getAlpha());
	};

	public function stroke(c:PColor):Void {
		strokeColor = c;
		g.lineStyle(strokeWeight, strokeColor.getColorValue(), strokeColor.getColorValue());
	};

	public function clear():Void {
		g.clear();
		b.disposeImage();
		b.dispose();
		b = new BitmapData(Math.round(width), Math.round(height), true, 0x00FFFFFF);
		g.beginFill(fillColor.getColorValue(), fillColor.getAlpha());
		g.lineStyle(strokeWeight, strokeColor.getColorValue(), strokeColor.getAlpha());
	};

	public function background(col:PColor):Void {
		g.lineStyle(0, 0, 0);
		g.beginFill(col.getColorValue(), col.getAlpha());
		g.drawRect(0, 0, width, height);
		g.beginFill(fillColor.getColorValue(), fillColor.getAlpha());
	};

	public function render():Void {
		b.draw(renderer);
		g.clear();
		display.graphics.clear();
		g.beginFill(fillColor.getColorValue(), fillColor.getAlpha());
		g.lineStyle(strokeWeight, strokeColor.getColorValue(), strokeColor.getColorValue());
		display.graphics.beginBitmapFill(b, false, true);
		display.graphics.drawRect(0, 0, b.width, b.height);
	}
}
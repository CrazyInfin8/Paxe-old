package paxe.color;

import paxe.core.Core;
import paxe.core.Core.ColorMode;
import paxe.core.Core.ColorBounds;

class PColor {
	var red:Float;
	var green:Float;
	var blue:Float;
	var alpha:Float;
	var value:UInt;
	public function new(op1:Float, ?op2:Float, ?op3:Float, ?op4:Float) {
		set(op1, op2, op3, op4);
	}

	public function getColorValue():UInt {
		return value;
	}

	public function getAlpha():Float {
		return alpha;
	}

	public function setAlpha(a:Float):Void {
		alpha = Math.min(Math.max(a / Core.getColorBounds(Core.getColorMode()).opA, 0), 1);
	}

	static public function createFromHex(col:UInt, ?a:Float):PColor {
		var c:PColor = new PColor(0);
		c.setFromHex(col, a);
		return c;
	}

	public function setFromHex(col:UInt, ?a:Float):Void {
		var r:Float = (col >> 16 & 255) / 255;
		var g:Float = (col >> 8 & 255) / 255;
		var b:Float = (col & 255) / 255;
		red = r;
		green = g;
		blue = b;
		if(a != null) {
			alpha = Math.min(Math.max(a / Core.getColorBounds(Core.getColorMode()).opA, 0), 1);
		}
	}

	function set(op1:Float, ?op2:Float, ?op3:Float, ?op4:Float) {
		var rgba = switch (Core.getColorMode()) {
			case RGB: PColor.createRGBArray(op1, op2, op3, op4);
			case HSL: PColor.createRGBArrayFromHSL(op1, op2, op3, op4);
			case HSB: PColor.createRGBArrayFromHSB(op1, op2, op3, op4);
			case HSV: PColor.createRGBArrayFromHSV(op1, op2, op3, op4);
		}
		red = rgba[0];
		green = rgba[1];
		blue = rgba[2];
		alpha = rgba[3];
		var r = Math.round(red * 255);
		var g = Math.round(green * 255);
		var b = Math.round(blue * 255);
		value = (r << 16) + (g << 8) + b;

	}

	public function toString():String {
		return '[$red, $green, $blue]; value:$value';
	}

	// normalize and limits RGB input also allows the optional parameters to work like how they did in Processing
	static function createRGBArray(op1:Float, ?op2:Float, ?op3:Float, ?op4:Float):Array<Float> {
		var bounds = Core.getColorBounds(ColorMode.RGB);
		var r:Float, g:Float, b:Float, a:Float;
		if(op2 == null) {
			r = Math.min(Math.max(op1 / bounds.op1, 0), 1);
			g = Math.min(Math.max(op1 / bounds.op2, 0), 1);
			b = Math.min(Math.max(op1 / bounds.op3, 0), 1);
			a = 1;
		} else if(op3 == null) {
			r = Math.min(Math.max(op1 / bounds.op1, 0), 1);
			g = Math.min(Math.max(op1 / bounds.op2, 0), 1);
			b = Math.min(Math.max(op1 / bounds.op3, 0), 1);
			a = Math.min(Math.max(op2 / bounds.opA, 0), 1);
		} else if(op4 == null) {
			r = Math.min(Math.max(op1 / bounds.op1, 0), 1);
			g = Math.min(Math.max(op2 / bounds.op2, 0), 1);
			b = Math.min(Math.max(op3 / bounds.op3, 0), 1);
			a = 1;
		} else {
			r = Math.min(Math.max(op1 / bounds.op1, 0), 1);
			g = Math.min(Math.max(op2 / bounds.op2, 0), 1);
			b = Math.min(Math.max(op3 / bounds.op3, 0), 1);
			a = Math.min(Math.max(op4 / bounds.opA, 0), 1);
		}
		return [r, g, b, a];
	}

	// normalize, limit, and convert HSL to RGB to store better
	static function createRGBArrayFromHSL(op1:Float, ?op2:Float, ?op3:Float, ?op4:Float):Array<Float> {
		var rgb:Array<Float>;
		var a:Float = 1;
		var bounds:ColorBounds = Core.getColorBounds(ColorMode.HSL);
		if(op2 == null) {
			rgb = PColor.hsl2rgb(0, 0, 
				Math.min(Math.max(op1, 0), bounds.op3),
			true);
		} else if(op3 == null) {
			rgb = PColor.hsl2rgb(0, 0, 
				Math.min(Math.max(op1, 0), bounds.op3),
			true);
			a = Math.min(Math.max(op2, 0), bounds.opA) / bounds.opA;
		} else if(op4 == null) {
			rgb = PColor.hsl2rgb(
				Math.min(Math.max(op1, 0), bounds.op1),
				Math.min(Math.max(op2, 0), bounds.op2),
				Math.min(Math.max(op3, 0), bounds.op3),
			true);
		} else {
			rgb = PColor.hsl2rgb(
				Math.min(Math.max(op1, 0), bounds.op1),
				Math.min(Math.max(op2, 0), bounds.op2),
				Math.min(Math.max(op3, 0), bounds.op3),
			true);
			a = Math.min(Math.max(op4, 0), bounds.opA) / bounds.opA;
		}
		return [rgb[0], rgb[1], rgb[2], a];
	}

	// same here…
	static function createRGBArrayFromHSV(op1:Float, ?op2:Float, ?op3:Float, ?op4:Float):Array<Float> {
		var rgb:Array<Float>;
		var a:Float = 1;
		var bounds:ColorBounds = Core.getColorBounds(ColorMode.HSV);
		if(op2 == null) {
			rgb = PColor.hsv2rgb(0, 0, 
				Math.min(Math.max(op1, 0), bounds.op3),
			true);
		} else if(op3 == null) {
			rgb = PColor.hsv2rgb(0, 0, 
				Math.min(Math.max(op1, 0), bounds.op3),
			true);
			a = Math.min(Math.max(op2, 0), bounds.opA) / bounds.opA;
		} else if(op4 == null) {
			rgb = PColor.hsv2rgb(
				Math.min(Math.max(op1, 0), bounds.op1),
				Math.min(Math.max(op2, 0), bounds.op2),
				Math.min(Math.max(op3, 0), bounds.op3),
			true);
		} else {
			rgb = PColor.hsv2rgb(
				Math.min(Math.max(op1, 0), bounds.op1),
				Math.min(Math.max(op2, 0), bounds.op2),
				Math.min(Math.max(op3, 0), bounds.op3),
			true);
			a = Math.min(Math.max(op4, 0), bounds.opA) / bounds.opA;
		}
		return [rgb[0], rgb[1], rgb[2], a];
	}

	// almost duplicate of HSV because HSB is the same as HSV but Paxe supports color bounds for both HSB and HSV so
	static function createRGBArrayFromHSB(op1:Float, ?op2:Float, ?op3:Float, ?op4:Float):Array<Float> {
		var rgb:Array<Float>;
		var a:Float = 1;
		var bounds:ColorBounds = Core.getColorBounds(ColorMode.HSB);
		if(op2 == null) {
			rgb = PColor.hsv2rgb(0, 0, 
				Math.min(Math.max(op1, 0), bounds.op3),
			true);
		} else if(op3 == null) {
			rgb = PColor.hsb2rgb(0, 0, 
				Math.min(Math.max(op1, 0), bounds.op3),
			true);
			a = Math.min(Math.max(op2, 0), bounds.opA) / bounds.opA;
		} else if(op4 == null) {
			rgb = PColor.hsb2rgb(
				Math.min(Math.max(op1, 0), bounds.op1),
				Math.min(Math.max(op2, 0), bounds.op2),
				Math.min(Math.max(op3, 0), bounds.op3),
			true);
		} else {
			rgb = PColor.hsb2rgb(
				Math.min(Math.max(op1, 0), bounds.op1),
				Math.min(Math.max(op2, 0), bounds.op2),
				Math.min(Math.max(op3, 0), bounds.op3),
			true);
			a = Math.min(Math.max(op4, 0), bounds.opA) / bounds.opA;
		}
		return [rgb[0], rgb[1], rgb[2], a];
	}

	public static function hsl2rgb(h:Float, s:Float, l:Float, ?normalizeResults:Bool = false):Array<Float> {
		// Thanks to https://stackoverflow.com/a/9493060 for nice neat looking conversion algorithms
		var hslBounds:ColorBounds = Core.getColorBounds(ColorMode.HSL);
		var r:Float, g:Float, b:Float;
		h /= hslBounds.op1;
		h = h % 1;
		s /= hslBounds.op2;
		l /= hslBounds.op3;
		if(s == 0) {
			r = g = b = l;
		} else {
			var h2b = function(p:Float, q:Float, t:Float):Float {
				if(t < 0) t += 1;
				if(t > 1) t -= 1;
				if(t < 1/6) return p + (q - p) * 6 * t;
				if(t < 1/2) return q;
				if(t < 2/3) return p + (q - p) * (2/3 - t) * 6;
				return p;
			}
			var q = l < 0.5 ? l * (1 + s) : l + s - l * s;
			var p = 2 * l - q;
			r = h2b(p, q, h + 1/3);
			g = h2b(p, q, h);
			b = h2b(p, q, h - 1/3);
		}
		if(normalizeResults) {
			return [r, g, b];
		} else {
			var rgbBounds:ColorBounds = Core.getColorBounds(ColorMode.RGB);
			return [r * rgbBounds.op1, g * rgbBounds.op2, b * rgbBounds.op3];
		}
	}

	public static function rgb2hsl(r:Float, g:Float, b:Float, ?normalizeResults:Bool = false):Array<Float> {
		var rgbBounds:ColorBounds = Core.getColorBounds(ColorMode.RGB);
		r /= rgbBounds.op1;
		g /= rgbBounds.op2;
		b /= rgbBounds.op3;
		var max:Float = Math.max(Math.max(r, g), b);
		var min:Float = Math.min(Math.min(r, g), b);
		var h:Float = 0, s:Float = 0, l:Float = (max + min) / 2;
		var d = max - min;
		if(max != min) {
			h = if(max == r) (g - b) / d + (g < b ? 6 : 0);
			else if(max == g) (b - r) / d + 2;
			else (r - g) / d + 4;
			h /= 6;
			s = d / (1 - Math.abs(2 * l - 1));
		}
		if(normalizeResults) {
			return [h, s, l];
		} else {
			var hslBounds:ColorBounds = Core.getColorBounds(ColorMode.HSL);
			return [h * hslBounds.op1, s * hslBounds.op2, l * hslBounds.op3];
		}
	}

	public static function hsv2rgb(h:Float, s:Float, v:Float, ?normalizeResults:Bool = false):Array<Float> {
		var hsvBounds = Core.getColorBounds(ColorMode.HSV);
		var r:Float, g:Float, b:Float;
		h /= hsvBounds.op1;
		h = (h * 6) % 6;
		s /= hsvBounds.op2;
		v /= hsvBounds.op3;
		var c:Float = v * s;
		var x:Float = c * (1 - Math.abs((h % 2) - 1));
		var m = v - c;
		if(h < 1) { r = c; g = x; b = 0; }
		else if(h < 2) { r = x; g = c; b = 0; }
		else if(h < 3) { r = 0; g = c; b = x; }
		else if(h < 4) { r = 0; g = x; b = c; }
		else if(h < 5) { r = x; g = 0; b = c; } 
		else { r = c; g = 0; b = x; }
		if(normalizeResults) {
			return [r + m, g + m, b + m];
		} else {
			var rgbBounds:ColorBounds = Core.getColorBounds(ColorMode.RGB);
			return [(r + m) * rgbBounds.op1, (g + m) * rgbBounds.op2, (b + m) * rgbBounds.op3];
		}
	}

	public static function rgb2hsv(r:Float, g:Float, b:Float, ?normalizeResults:Bool = false):Array<Float> {
		var rgbBounds:ColorBounds = Core.getColorBounds(ColorMode.RGB);
		r /= rgbBounds.op1;
		g /= rgbBounds.op2;
		b /= rgbBounds.op3;
		var max:Float = Math.max(Math.max(r, g), b);
		var min:Float = Math.min(Math.min(r, g), b);
		var h:Float = 0, s:Float = 0, v:Float = max;
		var d = max - min;
		if(max != min) {
			h = if(max == r) ((g - b) / d) % 6;
			else if(max == g) ((b - r) / d) + 2;
			else ((r - g) / d) + 4;
			h /= 6;
			if(h < 0) h ++;
			if(h > 1) h --;
			s = d / max;
		}
		if(normalizeResults) {
			return [h, s, v];
		} else {
			var hsvBounds:ColorBounds = Core.getColorBounds(ColorMode.HSV);
			return [h * hsvBounds.op1, s * hsvBounds.op2, v * hsvBounds.op3];
		}
	}

	public static function hsb2rgb(h:Float, s:Float, b:Float, ?normalizeResults:Bool = false):Array<Float> {
		var hsvBounds = Core.getColorBounds(ColorMode.HSB);
		var r:Float, g:Float, bl:Float;
		h /= hsvBounds.op1;
		h = (h * 6) % 6;
		s /= hsvBounds.op2;
		b /= hsvBounds.op3;
		var c:Float = b * s;
		var x:Float = c * (1 - Math.abs((h % 2) - 1));
		var m = b - c;
		if(h < 1) { r = c; g = x; bl = 0; }
		else if(h < 2) { r = x; g = c; bl = 0; }
		else if(h < 3) { r = 0; g = c; bl = x; }
		else if(h < 4) { r = 0; g = x; bl = c; }
		else if(h < 5) { r = x; g = 0; bl = c; } 
		else { r = c; g = 0; bl = x; }
		if(normalizeResults) {
			return [r + m, g + m, bl + m];
		} else {
			var rgbBounds:ColorBounds = Core.getColorBounds(ColorMode.RGB);
			return [(r + m) * rgbBounds.op1, (g + m) * rgbBounds.op2, (bl + m) * rgbBounds.op3];
		}
	}

	public static function rgb2hsb(r:Float, g:Float, b:Float, ?normalizeResults:Bool = false):Array<Float> {
		var rgbBounds:ColorBounds = Core.getColorBounds(ColorMode.RGB);
		r /= rgbBounds.op1;
		g /= rgbBounds.op2;
		b /= rgbBounds.op3;
		var max:Float = Math.max(Math.max(r, g), b);
		var min:Float = Math.min(Math.min(r, g), b);
		var h:Float = 0, s:Float = 0, br:Float = max;
		var d = max - min;
		if(max != min) {
			h = if(max == r) ((g - b) / d) % 6;
			else if(max == g) ((b - r) / d) + 2;
			else ((r - g) / d) + 4;
			h /= 6;
			if(h < 0) h ++;
			if(h > 1) h --;
			s = d / max;
		}
		if(normalizeResults) {
			return [h, s, br];
		} else {
			var hsvBounds:ColorBounds = Core.getColorBounds(ColorMode.HSB);
			return [h * hsvBounds.op1, s * hsvBounds.op2, br * hsvBounds.op3];
		}
	}
}

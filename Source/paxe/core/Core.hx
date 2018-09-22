package paxe.core;

import haxe.EnumTools;
import haxe.macro.Type.EnumType;
import haxe.ds.StringMap;
import haxe.EnumTools.EnumValueTools;

class Core {
	private function new() {
		angleMode = AngleMode.RADIANS;
		rectMode = RectMode.CORNER;
		ellipseMode = EllipseMode.RADIUS;
		colorMode = ColorMode.RGB;
		colorBounds = new StringMap<ColorBounds>();

		// Set default color bounds
		colorBounds.set("RGB", {
			op1: 255,
			op2: 255,
			op3: 255,
			opA: 255,
		});
		colorBounds.set("HSV", {
			op1: 360,
			op2: 100,//255,
			op3: 100,//255,
			opA: 100,//255,
		});
		colorBounds.set("HSB", {
			op1: 360,
			op2: 100,//255,
			op3: 100,//255,
			opA: 100,//255,
		});
		colorBounds.set("HSL", {
			op1: 360,
			op2: 100,//255,
			op3: 100,//255,
			opA: 100,//255,
		});
	}

	private static var core:Core = new Core();

	public static function getAnlgeMode():AngleMode {
		return core.angleMode;
	}

	public static function setAngleMode(mode:AngleMode):Void {
		core.angleMode = mode;
	}

	public static function getEllipseMode():EllipseMode {
		return core.ellipseMode;
	}

	public static function setEllipseMode(mode:EllipseMode):Void {
		core.ellipseMode = mode;
	}

	public static function getRectMode():RectMode {
		return core.rectMode;
	}

	public static function setRectMode(mode:RectMode):Void {
		core.rectMode = mode;
	}

	public static function getColorMode():ColorMode {
		return core.colorMode;
	}

	public static function setColoMode(mode:ColorMode):Void {
		core.colorMode = mode;
	}

	public static function getColorBounds(?mode:ColorMode):ColorBounds {
		if(mode == null) mode = core.colorMode;
		return core.colorBounds.get(EnumValueTools.getName(mode));
	}

	public static function setBounds(op1:Float, op2:Float, op3:Float, opA:Float, ?mode:ColorMode):Void {
		if(mode == null) mode = core.colorMode;
		core.colorBounds.set(EnumValueTools.getName(mode), {
			op1: op1,
			op2: op2,
			op3: op3,
			opA: opA
		});
	}

	var angleMode:AngleMode;
	var rectMode:RectMode;
	var ellipseMode:EllipseMode;
	var colorMode:ColorMode;
	var colorBounds:StringMap<ColorBounds>;

}

enum AngleMode {
	RADIANS;
	DEGREES;
	// A little bit more units than processing had ∙∪∙
	PERCENT;
	GRADIAN;
}

enum RectMode {
	CORNER;
	CORNERS;
	CENTER;
	RADIUS;
}

enum EllipseMode {
	CENTER;
	RADIUS;
	CORNER;
	CORNERS;
}

enum ColorMode {
	RGB;
	HSL;
	HSB;
	HSV;
}

typedef ColorBounds = {
	var op1:Float;
	var op2:Float;
	var op3:Float;
	var opA:Float;
}
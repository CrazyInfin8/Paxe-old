package paxe;

import openfl.display.Sprite;
import openfl.events.Event;
import lime.ui.Window;
import paxe.render.*;
import paxe.color.PColor;
import openfl.display.FPS;
import openfl.Lib;
import paxe.core.Core;
import paxe.core.Core.EllipseMode;
import paxe.math.PNoise;
class Paxe {
	public var surface:PSurface;
	public var display:PRenderer;
	public var parent:Sprite;
	var noiseGenerator:PNoise = new PNoise();

	public function new(s:Sprite, ?win:Window):Void {
		// parent.width = flash.
		if(win == null) win = Lib.application.window;
		surface = new PSurface(this, win);
		parent = s;
		displayWidth = flash.Lib.current.stage.fullScreenWidth;
		displayHeight = flash.Lib.current.stage.fullScreenHeight;
		windowWidth = win.width;
		windowHeight = win.height;
		setup();
		if(display == null) display = new P2D(parent, win.width, win.height);
		parent.addChild(new FPS());
		parent.addEventListener(Event.ENTER_FRAME, __update);
	}

	public dynamic function setup():Void {}
	public dynamic function draw():Void {}

	/**
	 * The size function specifies the width and the height of your application. It also specifies what render mode your (P2D is default)
	 * @param w the width of your application
	 * @param h the height of your application
	 * @param renderer the render mode of your application (P2D is default)
	 */
	function size(w:Int, h:Int, ?renderer:Class<PRenderer>):Void {
		if(display == null) {
			var r:Class<PRenderer> = renderer != null ? renderer : P2D;
			display = Type.createInstance(r, [parent, w, h]);               // TODO - see if I can improve the way default width and height are handled
			surface.setSize(w, h);
		} else {
			throw "Paxe function size should be called during setup!";
		}
	}

	public var width:Float;
	public var height:Float;
	public var windowWidth:Int;
	public var windowHeight:Int;
	public var displayWidth:Int;
	public var displayHeight:Int;
	public var mouseX:Float;
	public var mouseY:Float;
	public var deltaTime:Float;
	@:noCompletion private var _prevTime:Int = 0;
	function __update(e:Event):Void {
		var curTime:Int = Lib.getTimer();
		deltaTime = (curTime - _prevTime) / 1000;
		_prevTime = curTime;
		width = display.width;
		height = display.height;
		mouseX = parent.mouseX;
		mouseY = parent.mouseY;
		windowWidth = surface.window.width;
		windowHeight = surface.window.height;
		// #if (android || ios || blackberry)
		displayWidth = flash.Lib.current.stage.fullScreenWidth;
		displayHeight = flash.Lib.current.stage.fullScreenHeight;
		// #else
		// displayWidth = surface.window.display.bounds.width;
		// displayHeight = surface.window.display.bounds.height;
		// #end
		redraw();
	}

	public function millis():Float {
		return Lib.getTimer();
	}

	public function redraw(numOfRedraws:UInt = 1):Void {
		for( i in 0...numOfRedraws) {
			draw();
		}
		display.render();

	}

	public function ellipse(x:Float, y:Float, w:Float, ?h:Float):Void {
		if (h == null) h = w;
		display.ellipse(x, y, w, h);
	}

	function noise(x:Float, y:Float = 0, z:Float = 0):Float {
		return noiseGenerator.noise(x, y, z);
	}

	public function circle(x:Float, y:Float, r:Float):Void {
		display.ellipse(x, y, r, r);
	}

	public function rect(x:Float, y:Float, w:Float, h:Float, ?a:Float, ?b:Float, ?c:Float, ?d:Float):Void {
		if(a == null) {
			display.rect(x, y, w, h);
		} else if (d != null) {
			display.rrect(x, y, w, h, a, b, c, d);
		} else {
			display.rrect(x, y, w, h, a, a, a, a);
		}
	}

	public function line(a:Float, b:Float, c:Float, d:Float, ?e:Float, ?f:Float):Void {
		if(e == null) {
			display.line(a, b, 0, c, d, 0);
		} else {
			display.line(a, b, c, d, e, f);
		}
	}

	public function point(x:Float, y:Float, z:Float = 0):Void {
		display.point(x, y, z);
	}

	public function triangle(x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float):Void {
		display.triangle(x1, y1, x2, y2, x3, y3);
	}

	public function noLoop():Void {
		parent.removeEventListener(Event.ENTER_FRAME, __update);
	}

	public function loop():Void {
		parent.addEventListener(Event.ENTER_FRAME, __update);
	}

	public function fill(?col:PColor, op1:Float = 0, ?op2:Float, ?op3:Float, ?op4:Float):Void {
		if (col == null) {
			col = new PColor(op1, op2, op3, op4);
		}
		display.fill(col);
	}

	public function stroke(?col:PColor, op1:Float = 0, ?op2:Float, ?op3:Float, ?op4:Float):Void {
		if (col == null) {
			col = new PColor(op1, op2, op3, op4);
		}
		display.stroke(col);
	}

	public function clear():Void {
		display.clear();
	}
	
	public function background(?col:PColor, op1:Float = 0, ?op2:Float, ?op3:Float, ?op4:Float):Void {
		if (col == null) {
			col = new PColor(op1, op2, op3, op4);
		}
		display.background(col);
	}
	
	public function ellipseMode(?mode:EllipseMode):EllipseMode {
		if (mode != null) {
			Core.setEllipseMode(mode);
		}
		return Core.getEllipseMode();
	}
	
	public function rectMode(?mode:RectMode):RectMode {
		if (mode != null) {
			Core.setRectMode(mode);
		}
		return Core.getRectMode();
	}
	
	public function print(data:Dynamic) {
		trace(data);
	}
}

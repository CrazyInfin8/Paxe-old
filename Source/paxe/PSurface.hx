package paxe;

import openfl.display.Sprite;
import lime.ui.Window;
import openfl.Lib;
import openfl.display.Application;
import lime.ui.MouseCursor;

class PSurface {
	public var app:Application;
	public var window:Window;
	public var paxe:Paxe;

	public function new(p:Paxe, ?win:Window):Void {
		if(win == null) win = Lib.application.window;
		paxe = p;
		window = win;
		app = Lib.application;
	}

	public function setAlwaysOnTop() {

	}

	public function setCursor(mode:MouseCursor) {
		window.cursor = mode;
	}

	public function getCurser():MouseCursor {
		return window.cursor;
	}

	public function setTitle(title:String) {
		window.title = title;
	}

	public function getTitle():String {
		return window.title;
	}

	public function setSize(x:Int, y:Int) {
		window.resize(x, y);
	}

	public function setUndecorated(undecorate:Bool) {
		window.borderless = undecorate;
	}

	public function isUndecorated():Bool {
		return window.borderless;
	}

	public function setResizable(resizable:Bool) {
		window.resizable = resizable;
	}

	public function isResizable():Bool {
		return window.resizable;
	}

	public function setFrameRate(rate:Float) {
		window.frameRate = rate;
	}

	public function getFrameRate():Float {
		return window.frameRate;
	}

	public function lockMouse(lock:Bool) {
		window.mouseLock = lock;
	}

	public function isMouseLocked():Bool {
		return window.mouseLock;
	}

	public function fullscreen() {
		window.fullscreen = true;
	}

	public function normalScreen() {
		window.fullscreen = false;
	}

	public function minimize() {
		window.minimized = true;
	}

	public function unMinimize() {
		window.minimized = false;
	}
}
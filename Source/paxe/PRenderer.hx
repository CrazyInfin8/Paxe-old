package paxe;

import paxe.color.PColor;

interface PRenderer {
    public var width:Float;
    public var height:Float;
    public var renderMode:RenderMode;
    public var fillColor:PColor;
    public var strokeColor:PColor;
    public function ellipse(x:Float, y:Float, a:Float, b:Float):Void;
    public function line(x1:Float, y1:Float, z1:Float, x2:Float, y2:Float, z2:Float):Void;
    public function rect(x:Float, y:Float, a:Float, b:Float):Void;
    public function rrect(x:Float, y:Float, a:Float, b:Float, tl:Float, tr:Float, br:Float, bl:Float):Void;
    public function point(x:Float, y:Float, z:Float):Void;
    public function triangle(x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float):Void;
    public function beginShape():Void;
    public function endShape():Void;
    public function fill(c:PColor):Void;
    public function stroke(c:PColor):Void;
    public function clear():Void;
    public function background(col:PColor):Void;
    public function render():Void;
}

enum RenderMode {
    USE2D;
    USE3D(force3D:Bool);
}
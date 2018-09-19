package paxe.render;

import openfl.display.Sprite;

class PGraphics {
    public var display:PRenderer;
    public var width:Float;
    public var height:Float;
    public var sprite:Sprite;

    public function new(w:Float, h:Float, ?renderer:Class<PRenderer>):Void {
        sprite = new Sprite();
        sprite.width = w;
        sprite.height = h;
        if(display == null) {
            var r:Class<PRenderer> = renderer != null ? renderer : P2D;
            display = Type.createInstance(r, [sprite]);
        } else {
            throw "Paxe function size should be called during setup!";
        }
    }

    public function ellipse(x:Float, y:Float, w:Float, ?h:Float = Math.NaN):Void {
        if(h == Math.NaN) {
            display.ellipse(x, y, w, w);
        } else {
            display.ellipse(x, y, w, h);
        }
    }

    public function circle(x:Float, y:Float, r:Float):Void {
        display.ellipse(x, y, r, r);
    }

    public function rect(x:Float, y:Float, w:Float, h:Float, ?a:Float = Math.NaN, ?b:Float = Math.NaN, ?c:Float = Math.NaN, ?d:Float = Math.NaN):Void {
        if(a == Math.NaN) {
            display.rect(x, y, w, h);
        } else if (b == Math.NaN) {
            display.rrect(x, y, w, h, a, a, a, a);
        } else {
            display.rrect(x, y, w, h, a, b, c, d);
        }
    }

    public function line(a:Float, b:Float, c:Float, d:Float, ?e:Float = Math.NaN, ?f:Float = Math.NaN):Void {
        if(e == Math.NaN) {
            display.line(a, b, 0, c, d, 0);
        } else {
            display.line(a, b, c, d, e, f);
        }
    }

    public function point(x:Float, y:Float, ?z:Float = 0):Void {
        display.point(x, y, z);
    }

    public function triangle(x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float):Void {
        display.triangle(x1, y1, x2, y2, x3, y3);
    }
}
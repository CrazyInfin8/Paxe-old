package paxe.math;

class PVector {
	public var x:Float;
	public var y:Float;
	public var z:Float;
	public function new(x:Float, y:Float, ?z:Float = 0):Void {
		this.x = x;
		this.y = y;
		this.z = z;
	}

		public static function set(vec:PVector, ?vec2:PVector, ?arr:Array<Float>, ?x:Float = 0, ?y:Float = 0, ?z:Float = 0):PVector {
		if(vec2 != null) {
			vec.x = vec2.x;
			vec.y = vec2.y;
			vec.z = vec2.z;
		} else if(arr != null) {
			vec.x = arr.length > 0 ? arr[0] : 0;
			vec.y = arr.length > 1 ? arr[1] : 0;
			vec.z = arr.length > 2 ? arr[2] : 0;
		} else {
			vec.x = x;
			vec.y = y;
			vec.z = z;
		}
		return vec;
	}

	public static function copy(vec:PVector):PVector {
		return new PVector(vec.x, vec.y, vec.z);
	}

	public static function add(vec:PVector, ?vec2:PVector, ?arr:Array<Float>, ?x:Float = 0, ?y:Float = 0, ?z:Float = 0):PVector {
		if(vec2 != null) {
			vec.x += vec2.x;
			vec.y += vec2.y;
			vec.z += vec2.z;
		} else if(arr != null) {
			vec.x += arr.length > 0 ? arr[0] : 0;
			vec.y += arr.length > 1 ? arr[1] : 0;
			vec.z += arr.length > 2 ? arr[2] : 0;
		} else {
			vec.x += x;
			vec.y += y;
			vec.z += z;
		}
		return vec;
	}

	public static function sub(vec:PVector, ?vec2:PVector, ?arr:Array<Float>, ?x:Float = 0, ?y:Float = 0, ?z:Float = 0):PVector {
		if(vec2 != null) {
			vec.x -= vec2.x;
			vec.y -= vec2.y;
			vec.z -= vec2.z;
		} else if(arr != null) {
			vec.x -= arr.length > 0 ? arr[0] : 0;
			vec.y -= arr.length > 1 ? arr[1] : 0;
			vec.z -= arr.length > 2 ? arr[2] : 0;
		} else {
			vec.x -= x;
			vec.y -= y;
			vec.z -= z;
		}
		return vec;
	}

	public static function mult(vec:PVector, ?vec2:PVector, ?arr:Array<Float>, ?x:Float = 0, ?y:Float = 0, ?z:Float = 0):PVector {
		if(vec2 != null) {
			vec.x *= vec2.x;
			vec.y *= vec2.y;
			vec.z *= vec2.z;
		} else if(arr != null) {
			vec.x *= arr.length > 0 ? arr[0] : 0;
			vec.y *= arr.length > 1 ? arr[1] : 0;
			vec.z *= arr.length > 2 ? arr[2] : 0;
		} else {
			vec.x *= x;
			vec.y *= y;
			vec.z *= z;
		}
		return vec;
	}

	public static function div(vec:PVector, ?vec2:PVector, ?arr:Array<Float>, ?x:Float = 0, ?y:Float = 0, ?z:Float = 0):PVector {
		if(vec2 != null) {
			vec.x /= vec2.x;
			vec.y /= vec2.y;
			vec.z /= vec2.z;
		} else if(arr != null) {
			vec.x /= arr.length > 0 ? arr[0] : 0;
			vec.y /= arr.length > 1 ? arr[1] : 0;
			vec.z /= arr.length > 2 ? arr[2] : 0;
		} else {
			vec.x /= x;
			vec.y /= y;
			vec.z /= z;
		}
		return vec;
	}

	public static function magSq(vec:PVector):Float {
		return (vec.x * vec.x) + (vec.y * vec.y) + (vec.z * vec.z);
	}

	public static function mag(vec:PVector):Float {
		return Math.sqrt(magSq(vec));
	}

	public static function cross(vec1:PVector, vec2:PVector):PVector {
		return new PVector((vec1.y * vec2.z) - (vec1.z * vec2.y), (vec1.z * vec2.x) - (vec1.x * vec2.z), (vec1.x * vec2.y) - (vec1.y * vec2.y));
	}

	public function dot(vec1:PVector):Float {
		return 0;
	}
}
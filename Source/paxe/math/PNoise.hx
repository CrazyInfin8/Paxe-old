package paxe.math;

class PNoise {
	var PERLIN_YWRAPB:Int = 4;
	var PERLIN_YWRAP:Int = 1 << 4;
	var PERLIN_ZWRAPB:Int = 8;
	var PERLIN_ZWRAP:Int = 1 << 8;
	var PERLIN_SIZE:Int = 4095;
	var perlin_octaves:Int = 4; // default to medium smooth
	var perlin_amp_falloff:Float = 0.5; // 50% reduction/octave
	var perlin:Array<Float>;

	function scaled_cosine(i:Float):Float {
		return 0.5 * (1 - Math.cos(i * Math.PI));
	}

	public function noise(x:Float, y:Float = 0, z:Float = 0) {
		if(perlin == null) {
			perlin = new Array<Float>();
			for(i in 0...PERLIN_SIZE) {
				perlin[i] = Math.random();
			}
		}
		if(x < 0) {
			x = -x;
		}
		if(y < 0) {
			y = -y;
		}
		if(z < 0) {
			z = -z;
		}
		var xi:Int = Math.floor(x);
		var yi:Int = Math.floor(y);
		var zi:Int = Math.floor(z);
		var xf:Float = x - xi;
		var yf:Float = y - yi;
		var zf:Float = z - zi;
		var rxf:Float, ryf:Float;
		var r:Float = 0;
		var ampl:Float = 0.5;
		var n1:Float, n2:Float, n3:Float;
		for(o in 0...perlin_octaves) {
			var _o = xi + (yi << PERLIN_YWRAPB) + (zi << PERLIN_ZWRAPB);
			rxf = scaled_cosine(xf);
			ryf = scaled_cosine(yf);

			n1 = perlin[_o & PERLIN_SIZE];
			n1 += rxf * (perlin[(_o + 1) & PERLIN_SIZE] - n1);
			n2 = perlin[(_o + PERLIN_YWRAP) & PERLIN_SIZE];
			n2 += rxf * (perlin[(_o + PERLIN_YWRAP + 1) & PERLIN_SIZE] - n2);
			n1 += ryf * (n2 - n1);

			_o += PERLIN_ZWRAP;
			n2 = perlin[_o & PERLIN_SIZE];
			n2 += rxf * (perlin[_o & PERLIN_SIZE] - n2);
			n3 = perlin[(_o + PERLIN_YWRAP) & PERLIN_SIZE];
			n3 += rxf * (perlin[(_o + PERLIN_YWRAP + 1) & PERLIN_SIZE] - n3);
			n2 += ryf * (n3 - n2);

			n1 += scaled_cosine(zf) * (n2 - n1);
			r += n1 * ampl;
			ampl *= perlin_amp_falloff;
			xi = xi << 1;
			xf *= 2;
			yi = yi << 1;
			yf *= 2;
			zi = zi << 1;
			zf *= 2;

			if (xf >= 1.0) {
				xi++;
				xf--;
			}
			if (yf >= 1.0) {
				yi++;
				yf--;
			}
			if (zf >= 1.0) {
				zi++;
				zf--;
			}
		}
		return r;
	}

	public function noiseDetail(lod:Int, falloff:Float) {
		if (lod > 0) {
			perlin_octaves = lod;
		}
		if (falloff > 0) {
			perlin_amp_falloff = falloff;
		}
	}

	public function noiseSeed(?seed:Int) {
		var m = 4294967296;
		var a = 1664525;
		var c = 1013904223;
		if(seed == null) seed = Math.round(Math.abs(Math.random() * m));
		var z:Float = seed;
		for(i in 0...PERLIN_SIZE) {
			z = (a * z + c) % m;
			perlin[i] = z / m;
		}
	}

	public function new() {}
}
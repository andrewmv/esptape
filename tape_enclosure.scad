xdim = 45.39;
ydim = 53.33;

screw_pos = [
    [3.81, 3.81],
    [41.91, 49.53]
];

wall_t = 2;
wall_h = 1.6;
ledge_t = 2;
ledge_h = 1.4;
base_h = 2;

stem_r = 8.75/2;	
hole_r = 2.75/2;	//for M2 screws
stem_h = base_h + ledge_h;

color("white") base();
color("pink") ledge();
color("red") wall();

module base() {
    cube(size=[xdim, ydim, base_h]);
}

module ledge() {
    xt = -ledge_t;
    yt = -ledge_t;
    xs = xdim + (2 * ledge_t);
    ys = ydim + (2 * ledge_t);
    zs = base_h + ledge_h;
    difference() {
        translate([xt, yt, 0])
            cube(size=[xs, ys, zs]);
        cube(size=[xdim, ydim, 10]);
    } 
}

module wall() {
    xt = -ledge_t - wall_t;
    yt = -ledge_t - wall_t;
    xs = xdim + (2 * ledge_t) + (2 * wall_t);
    ys = ydim + (2 * ledge_t) + (2 * wall_t);
    zs = base_h + ledge_t + wall_t;
    difference() {
        translate([xt, yt, 0])
            cube(size=[xs, ys, zs]);
        translate([-ledge_t, -ledge_t, 0])
            cube(size=[xdim + (2 * ledge_t), ydim + (2 * ledge_t), 10]);
    }
}

module mounting_stem() {
	difference() {
		linear_extrude(stem_h) {
			circle(stem_r);
		}
		translate([0,0,2]) {
			linear_extrude(stem_h + 1) {
				circle(hole_r);
			}
		}
	}
}
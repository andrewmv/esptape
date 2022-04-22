xdim = 45.39;
ydim = 53.33;

label1 = "A1 Bridge";
label2 = "v1.0 2022-04";

screw_pos = [
    [3.81, 3.81],
    [41.91, 49.53]
];

// pos, len
top_cuts = [
    [9.25, 26.25 - 9.25]
];
bottom_cuts = [
    [9.00, 19.00 - 9.00],   // USB-C
    [22.00, 32.00 - 22.00], // Barrel Plug
    [34.25, 42.75 - 34.25]  // Mono Jack
];

wall_t = 2;
wall_h = 1.6;
ledge_t = 2;
ledge_h = 1.75;
base_h = 2;

stem_r = 2.75;	
hole_r = 2.75/2;	//for M2 threaded inserts
stem_h = base_h + ledge_h; // 3.6

$fn = 20;

print_supports = false;

// Regular Assembly
if (print_supports == false) {
    color("white") base();
    color("pink") ledge();
    difference() {
        color("red") wall();
        color("blue") cuts();
    }

    // Labels
    text_x = 4.0;
    text_y = 30;
    text_z = base_h;
    translate([text_x, text_y, text_z]) {
        linear_extrude(0.5) {
            text(label1, size=5);
        }
    }
    translate([text_x, text_y - 7, text_z]) {
        linear_extrude(0.5) {
            text(label2, size=5);
        }
    }
    // Mounting Stems
    for (i = [0:len(screw_pos)-1]) {
        translate(screw_pos[i]) {
            mounting_stem();
     }
}

} else {
    // Support Assembly
    for (i = [0:len(screw_pos)-1]) {
        translate(screw_pos[i]) {
            cylinder(r=stem_r + 1, h=stem_h+2);
        }
    }
}




// Modules

module base() {
    difference() {
        cube(size=[xdim, ydim, base_h]);
        for (i = [0:len(screw_pos)-1]) {
            translate(screw_pos[i])
                cylinder(r=stem_r, h=10);
        }
    }
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
		translate([0,0,0.25]) {
			linear_extrude(stem_h + 1) {
				circle(hole_r);
			}
		}
	}
}

module cuts() {
    // bottom cuts
    yt = -wall_t - ledge_t - 1;
    xt = -ledge_t;
    zt = base_h + ledge_h;
    translate([xt, yt, zt]) {
        for (i = [0:len(bottom_cuts)-1]) {
            translate([bottom_cuts[i][0], 0, 0]) {
                cube(size=[bottom_cuts[i][1],wall_t + 2, wall_h + 1]);
            }
        }
    }
    // top cuts
    yt2 = ydim + ledge_t - 1;
    translate([xt, yt2, zt]) {
        for (i = [0:len(top_cuts)-1]) {
            translate([top_cuts[i][0], 0, 0]) {
                cube(size=[top_cuts[i][1], wall_t + 2, wall_h + 1]);
            }
        }
    }
}

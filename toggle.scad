// toggle.scad
// Toggle for Shock Cord
// 
// Copyright 2013 Christopher Roberts

// Global Parameters
// chrisjrob

toggle_radius     = 26/2; // Radius of the toggle itself
//large_hole_radius = 14.0/2; // This should be big enough for a knot to fit, approx double small_hole
//small_hole_radius = 7/2; // This should be just big enough for the cord to fit through
large_hole_radius = 9.6/2; // This should be big enough for a knot to fit, approx double small_hole
small_hole_radius = 4.8/2; // This should be just big enough for the cord to fit through
bung_height       = large_hole_radius * 1.2; // Length of bung
raft_height       = 0.3;
precision         = 100; // Set 15 for a standard toggle or 100 for a smooth one

module toggle() {

	difference() {

		// Things that exist
		union() {
			// The toggle
			translate([0,0,toggle_radius * 0.92])
				sphere(r=toggle_radius, $fn = precision);
                        if ( raft_height > 0 ) {
                            cylinder(r = toggle_radius, h = raft_height);
                        }
		}

		// Things to be cut out
		union() {

			// Large hole
			translate([0,0,toggle_radius*0.5])
				cylinder(h=toggle_radius*1.5, r=large_hole_radius, $fn = 100);

			// Small hole
			translate([0,0,toggle_radius*-0.1])
				cylinder(h=toggle_radius, r=small_hole_radius, $fn = 100);

                        // Remove everything below z = 0
                        translate([-toggle_radius, -toggle_radius, -toggle_radius])
                            cube([toggle_radius * 2, toggle_radius * 2, toggle_radius]);

		}
	}

}

module bung() {

	difference() {

		// Things that exist
		union() {
			// The bung
			intersection() {
				translate([toggle_radius*2,0,(bung_height - toggle_radius)])
					sphere(r=toggle_radius, $fn = precision);
				translate([toggle_radius*2,0,0])
					cylinder(h = bung_height, r2 = large_hole_radius, r1 = large_hole_radius * 0.95, $fn = 100);
			}
		}

		// Things to be cut out
		union() {

		}
	}

}

toggle();
bung();

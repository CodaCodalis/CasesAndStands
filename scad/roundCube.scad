$fn = 100;

/*
difference() {
  union() {
    intersection() {
      cube(50, center = true);
      sphere(d = 65);
    }
  }
  sphere(d = 64);
}
rotate([90,0,0]) {
  cylinder(80,r = 19,center = true);
}
*/

/*
//Vorderwand
translate([2.5,0,2.5])
cube([45, 5, 45]);

translate([2.5,2.5,47.5])
  sphere(2.5);
translate([47.5,2.5,47.5])
  sphere(2.5);
translate([2.5,2.5,2.5])
  sphere(2.5);
translate([47.5,2.5,2.5])
  sphere(2.5);
  
translate([2.5,2.5,47.5])
  rotate([0,90,0])
    cylinder(45,2.5,2.5);
translate([2.5,2.5,2.5])
  rotate([0,0,0])
    cylinder(45,2.5,2.5);
translate([2.5,2.5,2.5])
  rotate([0,90,0])
    cylinder(45,2.5,2.5);
translate([47.5,2.5,2.5])
  rotate([0,0,0])
    cylinder(45,2.5,2.5);
    
//Rückwand
*/

/* [Maße] */
//Länge
boxLength = 47.5;
boxWidth = 47.5;
boxHeight = 47.5;
roundingRadius = 2.5;

roundCube(boxLength, boxWidth, boxHeight, roundingRadius);
//cornerSpheres();
//cornerCylinders();
//coverPlates();
//filling();

module roundCube (boxLength, boxWidth, boxHeight, roundingRadius) {
hull() {
for (x = [roundingRadius,boxLength]) {
  for (y = [roundingRadius,boxWidth]) {
    for (z = [roundingRadius,boxHeight]) {
      translate([ x , y , z ]) {
        sphere(roundingRadius);
      }
    }
  }
}
}
}

module cornerSpheres () {
for (x = [2.5,47.5]) {
  for (y = [2.5,47.5]) {
    for (z = [2.5,47.5]) {
      translate([ x , y , z ]) {
        sphere(2.5);
      }
    }
  }
}
}


module cornerCylinders () {
for (x = [2.5,47.5]) {
  for (y = [2.5,47.5]) {
    translate([ x , y, 2.5 ]) {
      cylinder(45,2.5,2.5);
    }
  }
}

rotate([0,90,0]) 
  translate([-50,0,0]){
    union() {
      for (x = [2.5,47.5]) {
        for (y = [2.5,47.5]) {
          translate([ x , y, 2.5 ]) {
            cylinder(45,2.5,2.5);
          }
        }
      }
    }
  }
  
rotate([90,90,0]) 
  translate([-50,0,-52.5]){
    union() {
      for (x = [2.5,47.5]) {
        for (y = [2.5,47.5]) {
          translate([ x , y, 5 ]) {
            cylinder(45,2.5,2.5);
          }
        }
      }
    }
  }
}

module coverPlates () {
  for (z = [0,47.5]) {
    translate([2.5,2.5,z])
      cube([45,45,2.5]);
  }
  rotate([0,90,0]) {
    for (z = [0,47.5]) {
      translate([-47.5,2.5,z])
        cube([45,45,2.5]);
    }
  }
  rotate([90,0,0]) {
    for (z = [-50,-2.5]) {
      translate([2.5,2.5,z])
        cube([45,45,2.5]);
    }
  }
}

module filling () {
   translate([2.5,2.5,2.5])
    cube([45,45,45]);
}
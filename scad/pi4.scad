$fn=100;
epsilon=0.01;

//Zeige Pi4
visibility = false;

if (visibility) {
  pi4();
}

module pi4() {
  pi4pcb();
  gpio();
  display();
  cpu();
  ram();
  usbc();
  hdmi();
  cameraslot();
  audio();
  usb();
  lan();
}

module pi4pcb() {
  difference() {
    union(){
      color("green")
        minkowski() {
          translate([3,3,0])
            cube([79,50,0.625]);
          cylinder(0.625, r1 = 3, r2 = 3);
        }
        for(x = [3.5,61.5]) {
          for(y = [3.5,52.5]) {
            translate([x,y,1.25])
              cylinder(0 + epsilon,r1=3,r2=3);
          }
        } 
      }

      for(x = [3.5,61.5]) {
        for(y = [3.5,52.5]) {
          translate([x,y,0 - epsilon])
            cylinder(1.5 + epsilon,r1=1.35,r2=1.35);
        }
      }
    }
}

module gpio() {
  translate([32.5,52.5,1.5])
    cube([51,6,2.5],center=true);
      for(x=[8.5:2.5:57])
        for(y=[51,54])
          translate([x,y,1.75])
            cube([0.5,0.5,6]);
}

module display() {
  translate([1.75,28,4.25])
    cube([3,21,5.5],center=true);
}

module cpu() {
  translate([29.25,32.5,2.65])
    cube([14,14,2.4],center=true);
}

module ram() {
  translate([44.25,32.5,2.65])
    cube([10,14,2.4],center=true);
}

module usbc() {
  for (x = [8.4,14.2])
    translate([x,6.25,2.85])
      rotate([90,0,0])
        cylinder(h=7.25,d1=3.2,d2=3.2);
  translate([11.2,2.625,2.85])
    cube([5.8,7.25,3.2],center=true);
}

module hdmi() {
  for (x = [26,39.5])
  translate([x,3,2.75])
    cube([6.5,8,3.0],center=true);
}

module cameraslot() {
  translate([46,10.5,4.25])
    cube([3,21,5.5],center=true);
}

module audio() {
  translate([53,6.25,4.25])
    cube([7.25,12.5,6.0],center=true); 
    translate([53,0,4.25])
      rotate([90,0,0])
        difference() {
          cylinder(2.5,3,3);
          translate([0,0,0.5])
            cylinder(2.5 + epsilon,1.5,1.5);
        }
}

module usb() {
  for(y = [9,27]) {
    translate([78.5,y,9.25])
      difference() {
      cube([17.25,13.15,16],center=true);
        for (z = [-4,4])
          translate([4,0,z])
            cube([12,10,4],center=true);
      }
  }
}

module lan() {
  translate([76.5,45.75,8])
    difference() {
      cube([21.25,15.75,13.5],center=true);
      translate([4,0,0])
        cube([15,12,11],center=true);
    }
}
$fn=50;
//unterer Arm
union() {

//Halterung  
difference(){
    rotate([0,90,0])
        difference(){
            cylinder(200,60,60);
            translate([0,0,-1])
                cylinder(202,40,40);
    }
    translate([-1,-60,0])
    cube([202,100,60]);
}

rotate([0,90,0])
    translate([0,-50,0])
        cylinder(200,10,10);

//Rückwand
translate([0,40,0])
    cube([200,20,500]);
}

//linker Arm
rotate([0,90,0])
    translate([-500,0,-100])
union() {

//Halterung  
difference(){
    rotate([0,90,0])
        difference(){
            cylinder(180,60,60);
            translate([0,0,-1])
                cylinder(182,40,40);
    }
    translate([-1,-60,0])
        cube([182,100,60]);
}

rotate([0,90,0])
    translate([0,-50,0])
        cylinder(180,10,10);

//Rückwand
translate([0,40,0])
    cube([180,20,100]);
}

//rechter Arm
rotate([0,-90,0])
    translate([300,0,-300])
union() {

//Halterung  
difference(){
    translate([20,0,0])
    rotate([0,90,0])
        difference(){
            cylinder(180,60,60);
            translate([0,0,-1])
                cylinder(282,40,40);
    }
    translate([19,-60,0])
    cube([182,100,60]);
}

rotate([0,90,0])
    translate([0,-50,20])
        cylinder(180,10,10);

//Rückwand
translate([20,40,0])
    cube([180,20,100]);
}

//Lenkerhalterung
//Halbkugel
difference(){
translate([100,60,320])
    difference() {
        cylinder(180,180,180);
        translate([-190,-220,-200])
            cube([380,200,400]);
    }
    union(){
translate([200,39,160])
    cube([100,180,140]);
translate([-100,39,160])
    cube([100,180,140]);
rotate([0,90,0])
    translate([-150,210,-1])
        cylinder(202,150,150);
translate([-70,150,299])
    cylinder(202,90,90);
translate([270,150,299])
    cylinder(202,90,90);
translate([100,220,199])
    cylinder(302,70,70);
    }
}

//Zylinder
translate([100,270,320])
difference(){
cylinder(180,120,120);
    union(){
        translate([0,0,-1])
            cylinder(182,80,80);
        translate([0,-50,-1])
            cylinder(182,70,70);
        translate([-30,70,-1])
            cube([60,50,182]);
    }
}

    
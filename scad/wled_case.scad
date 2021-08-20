/* [Einstellungen] */
//Faktor für Rundungen
$fn=100;

//Faktor für Spielraum [mm]
epsilon=0.1;

/* [Ansicht] */
//Druckansicht
print = false;

//Platine zeigen
showPCB = false;

//Lage des Schraublochs;
screwHolePosition = 5; //[0:1:20]

//Deckel schieben
topTranslate = 0; // [0:1:20]

if (showPCB) {
    translate([2,2,4.5])
        platine();
  } else {}
color("grey")
    gehaeuse();
    
module platine() {
//Bohrungen    
difference(){
    color("green")
        cube([75.0,28.0,1.6]);
            union(){
                translate([3.5,3.5,-epsilon])
                    cylinder(1.6+2*epsilon,1.0,1.0);
                translate([3.5,24.5,-epsilon])
                    cylinder(1.6+2*epsilon,1.0,1.0);
            }
    }
//Strombuchse
color("black")
    translate([61.5,9.5,1.6])
        cube([13.5,9.0,11.0]);
//Kondensator
color("white")
    translate([52.0,14.5,1.6])
        cylinder(10.4,5.0,5.0);
//ESP8266
color("white")
    translate([18.0,9.0,1.6])
        cube([12.0,15.0,3.4]);
//Kabelausführung
color("yellow")
    hull() {
        for(y=[13,15])
            translate([-2.5,y,3.4])
            rotate([0,90,0])
            cylinder(12.5,1.6,1.6);
        }
    
}

module gehaeuse() {
    boden();
    seitenwaende();
    if (print) {
        rotate([180,0,0])
            translate([0,-70.0,-24.0])
                deckel();
                topTranslate = 0;
    } else {
        translate([0,0,-2.0+topTranslate])
            //rotate([0,-shiftTranslate,0])
                deckel();
        }
}

module boden() {
//Platte
    difference() {
        hull() {
        for(x=[2.0,77.0])
            for(y=[2.0,30.0])
                translate([x,y,2.0])
                    sphere(2.0);
        }
        union() {
        translate([0,0,2.0])
            cube([79.0,32.0,2.0]);
        translate([1.5,1.5,1.5])
            cube([76.0,29.0,0.5+2]);
        //Öffnung für Schraubenhalterung
          translate([0-screwHolePosition,0,0])
            union() {
              translate([40.5,17.0,0-epsilon])
                cylinder(1.5+2*epsilon,3.0,3.0);
              translate([32.5,15.25,0-epsilon])
                cube([6.0,3.5,1.5+2*epsilon]);
              translate([32.5,17.0,0-epsilon])
                cylinder(1.5+2*epsilon,1.75,1.75);
          }
        }
    }
    
//Auflagezylinder
    for(x=[5.5,73.5])
        for(y=[5.5,26.5])
            translate([x,y,1.5])
                cylinder(3.0,1.5,1.5);
    for(y=[5.5,26.5])
        translate([5.5,y,4.5])
            cylinder(2,0.8,0.8);
        
}
module seitenwaende() {
    difference() {
        hull() {
            for(x=[2.0,77.0])
                for(y=[2.0,30.0])
                    translate([x,y,2.0])
                        cylinder(18.0,2.0,2.0);
        }
        translate([1.5,1.5,2.0])
            cube([76.0,29.0,18.0+epsilon]);

        //Öffnung für Strombuchse
        translate([77.5-epsilon,16,12.5])
            rotate([0,90,0])
                cylinder(1.5+2*epsilon,4.5,5.5);

        //Öffnung für Kabel
        hull() {
            for(y=[15,17])
                translate([0-epsilon,y,7.9])
                rotate([0,90,0])
                cylinder(1.5+2*epsilon,1.8,1.8);
        }
        translate([0-epsilon,13.2,7.9])
            cube([1.5+2*epsilon,5.6,12.1+epsilon]);

        //Kerbe für Deckelhalterung über Stromanschluss
        translate([77.5-epsilon,13.5,18.5])
            cube([0.5,5.0,0.5+epsilon]);
        
        //Kerbe für Deckelhalterung über Kabel
        translate([1.0+epsilon,10.5,12.0])
            cube([0.5,11.0,0.5+epsilon]);
    }
}

module deckel() {
//Deckplatte
    difference() {
        hull() {
        for(x=[2.0,77.0])
            for(y=[2.0,30.0])
                translate([x,y,22.0])
                    sphere(2.0);
        }
        union(){
        translate([0,0,20.0])
            cube([79.0,32.0,2.0]);
        }
        translate([1.5,1.5,22.0])
            cube([76.0,29.0,0.5]);
    }
//Halteschnalle über Kabel
antilidbend = 0.2;
    //äußere Lasche
    difference(){
        translate([0,13.2+epsilon,9.9])
            cube([1.5,5.6-2*epsilon,12.1]);
        hull() {
            for(y=[15,17])
                translate([0-epsilon,y,9.9])
                rotate([0,90,0])
                cylinder(1.5+2*epsilon,1.8,1.8);
    }
    }
    //innere Lasche
    difference(){
        translate([1.5,13.2+epsilon,9.9])
            cube([1.5+antilidbend,5.6-2*epsilon,12.1]);
        hull() {
            for(y=[15,17])
                translate([1.5-epsilon,y,9.9])
                rotate([0,90,0])
                cylinder(1.5+antilidbend+2*epsilon,1.8,1.8);
    }
    }
    translate([1.5+antilidbend,10.5,11.7])
        cube([1.5,11.0,10.8]);
    translate([1.5+antilidbend,10.5,8.2])
        cube([1.5,2.7+epsilon,3.5]);
    translate([1.5+antilidbend,18.8-epsilon,8.2])
        cube([1.5,2.7+epsilon,3.5]);
    //Feder
    translate([1.2,10.6,14.1])
        cube([0.5,10.8,0.4]);
//Halteschnalle über Stromanschluss
    translate([76,13.6,19.2])
        cube([1.5,4.8,3.8]);
    //Feder
    translate([77.5,13.6,20.6])
        cube([0.4,4.8,0.4]);
    
//Anti-Verrutsch-Balken an Längsseiten
    translate([34.5,1.5,21.0])
        cube([10.0,1.5,1.5]);
    translate([34.5,29.0,21.0])
        cube([10.0,1.5,1.5]);
    }


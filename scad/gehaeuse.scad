/* [Parameter] */
$fn=100;
epsilon = .05;

/* [Ansicht] */
//Deckel anheben
topTranslate = 10; // [0:1:20]

//Druckansicht
print = false;

/* [Gehäuse und Deckel] */
//Länge
boxLength = 50; // [40:10:100]

//Breite
boxWidth = 100; // [20:10:200]

//Höhe
boxHeight = 40; // [20:10:40]

/* [Schrauben] */
//Schraubendurchmesser
screwDiameter = 2.5;

//Schraubenlänge
screwLength = 10;

//Senkkopfschraube
screwHead = false;

/* [Gravur] */
//Auswahl der Gravurform
engraving="Quadrat"; // [Quadrat, Rechteck,Kreis]

//Eingabe der Gravur
engravedText="Boxtext";

//Schriftgröße


box();

if (print) {
  rotate([180,0,0])
    translate ([boxLength + 10, -boxWidth, -boxHeight - 2])
      lid();
}
else {
  lid(topTranslate);
}
module box() {
  difference() {
    cube([boxLength,boxWidth,boxHeight]);
    translate([2,2,2]) {
     cube([boxLength - 4,boxWidth - 4,boxHeight - 2 + epsilon]);
    } 
  }
  for (x = [5,boxLength - 5]) {
    for (y = [5,boxWidth -5]) {
        translate([ x , y , 0 ]) {
          difference() {  
            cylinder( boxHeight - 2 , 5 , 5 );
              translate([ 0 , 0 , boxHeight - 12 + epsilon ]) {
                cylinder( screwLength , d1 = screwDiameter - .5 , d2 = screwDiameter - .5 );
              }
          }
        }
    }
  }
}

module lid(topTranslate = 0) {
  translate([ 0 , 0 , boxHeight + topTranslate ]) {
  difference(){ 
    
    union() {
      difference() {
        cube([ boxLength , boxWidth , 2 ]);
        if (engraving == "Quadrat") {
          translate([boxLength/2,boxWidth/2,2])
            cube([ boxLength/2, boxLength/2, 2], center = true );
        }
        if (engraving == "Rechteck") {
          translate([boxLength/2,boxWidth/2,2])
            cube([ boxLength/2, boxWidth/3 , 2], center = true );
        }
        if (engraving == "Kreis") {
          translate([boxLength/2,boxWidth/2,2])
            cylinder( 2, d1 = boxWidth/1.5, d2= boxWidth/1.5, center = true);
        }
      }
      translate([2,2,-2]) {
        cube([ boxLength - 4 , boxWidth - 4 , 2 ]);
      }
    }
    for (x = [ 5 , boxLength - 5 ]) {
      for (y = [ 5 , boxWidth - 5 ]) {
        translate([ x , y , -4 ]) {
          cylinder(5 + epsilon, d1 = screwDiameter, d2 = screwDiameter);
            translate([0,0,5]) {
              if (screwHead) {
              cylinder(2, d1 = screwDiameter + 2.5, d2 = screwDiameter);
              }
              else {
              cylinder(2, d1 = screwDiameter + 1, d2 = screwDiameter + 1);  
              }
            } 
        }
      }
    }
  }
  translate([boxLength/2, boxWidth/2, 1])
        linear_extrude(1)
          text(engravedText, size=1,5, halign = "center", valign = "center", font = "Uroob");
  }
}             
 

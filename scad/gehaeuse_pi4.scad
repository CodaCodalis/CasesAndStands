include <pi4.scad>;
include </home/robert/openscad/libraries/NopSCADlib/lib.scad>;

/* [Einstellungen] */
//Faktor für Rundungen
$fn=100;

//Faktor für Spielraum [mm]
epsilon=0.01;

/* [Ansicht] */
//Druckansicht
print = false;

//Deckel anheben
topTranslate = 10; // [0:1:20]

/* [Schrauben] */
//Schraubendurchmesser [mm]
screwDiameter = 2.0; // [0.5,1.0,1.5,2.0,2.5]

/* [Gravur] */
//Eingabe der Gravur
engravedText="Gravur";

color("white")
  gehaeuse();
//translate([3,3,5])
  //pi4();
//translate([45.5,31,5])
  //pcb(RPI4);
//translate([35,36,24+topTranslate])
  //camera(rpi_camera_v1);
//translate([33,37,22]) 
  //fan(fan17x8);

module gehaeuse() {
  grundplatte();
  seitenplattenUndGeruest();
  if (print) {
    rotate([0,0,0])
      translate ([0, 68, -26 - topTranslate])
        deckplatte();
  } else {
    deckplatte();
  }
}

module grundplatte() {
  translate([2,2,0])
    difference(){
      cube([87,58,2]); //Platte
      for (y = [2:2:22])
      translate([22,23+y,-epsilon])
        cube([20,1,2+epsilon*2]);
    }
  difference() {  
    for(x = [6.5,64.5]) {
      for(y = [6.5,55.5]) {
        translate([x,y,2])
          cylinder(3,r1=3,r2=3); //Erhebungen für Schraublöcher
      }
    }
    for(x = [6.5,64.5]) {
      for(y = [6.5,55.5]) {
        translate([x,y,2])
          cylinder(3 + epsilon,r1=1,r2=1); //Schraublöcher
      }
    }
  }
}

module seitenplattenUndGeruest() {
  difference(){
  union(){
  seitenplatten();
  for(x=[2,89])
    for(y=[2,60])
      for(z=[2,26])
        translate([x,y,z])
          sphere(r=2); //Kugeln an 8 Ecken, nur 4 in Benutzung
  
  for(x=[2,89])
    for(y=[2,60])
      translate([x,y,2])
        cylinder(24,r1=2,r2=2); //Zylinder an langen Kanten
  
  rotate([0,90,0])
    for(y=[2,60])
      for(z=[2,26])
          translate([-z,y,2])
            cylinder(87,r1=2,r2=2); //Zylinder an kurzen Kanten
        
  rotate([90,0,0])
    for(x=[2,89])
      for(z=[2,26])
        translate([x,z,-60])
          cylinder(58,r1=2,r2=2); //Zylinder, senkrecht
  }
  union(){
    translate([0,0,26])
      cube([91,62,2]); //2 mm entfernen, inkl. Rundungen :/
    translate([2,2,24-epsilon])
      difference(){
        cube([87,58,2+epsilon*2]);
          for(x=[0,87])
            for(y=[0,58])
              translate([x,y,0])
                cylinder(h=2, d=4); //fehlendes Material bei Zylindern ergänzen
      }
    for(x=[2.5,88.5])
      for(y=[2.5,59.5])
       translate([x,y,14])
        cylinder(h=14, d=screwDiameter - 0.5); //Schraublöcher
  }
  }
}

module deckplatte() {
  translate([2,2,26+topTranslate])
    difference(){
      union(){
        cube([87,58,2]); //Deckplatte
        for(x=[0,87])
          for(y=[0,58])
            translate([x,y,0])
              sphere(2); //runde Ecken
        for(x=[0,87])
          translate([x,58,0])
            rotate([90,0,0])
              cylinder(58,2,2); //runde Kante, kurz
        for(y=[0,58])
          translate([0,y,0])
            rotate([0,90,0])
              cylinder(87,2,2); //runde Kante, lang
      }
      union(){
        for(x=[0.5,86.5])
          for(y=[0.5,57.5])
            translate([x,y,-epsilon])
            cylinder(h=2+epsilon*2, d1=screwDiameter - 0.5, d2=screwDiameter + 0.5); //Schraublöcher für Deckel
        translate([31,34.9,-epsilon])
          cylinder(2+epsilon*2,r1=8,r2=8); //Ausschnitt für Lüfter
        for(x=[24.3,37.8])
          for(y=[28.2,41.7])
            translate([x,y,-epsilon])
            cylinder(h=2+epsilon*2, d1=screwDiameter - 0.2, d2=screwDiameter - 0.2); //Schraublöcher für Lüfter
        translate([-2,-2,-2])
          cube([93,64,2+epsilon]); //untere runde Kanten entfernen 
        translate([70,10,1.5-epsilon])
            linear_extrude(1+epsilon*2)
              rotate([0,0,90])
                text(engravedText, size=3.5, halign = "left", valign = "center", font = "Chandas"); //Textgravur
      }
    }
}

module seitenplatten() {
//RJ45-USB Seitenplatte
  translate([89,2,2])
    difference(){
      cube([2,58,24]);
        translate([-1,3,3])
          cube([4,52,18]);
    }
  translate([89,19,5])
    cube([2,4,18]); //zwischen USBs
  translate([89,37,5])
    cube([2,3.5,18]); //zwischen USB und RJ45
  translate([89,40.4,20.5])
    cube([2,16.6,2.5]); //über RJ45
    
//POWER-HDMI-AUDIO Seitenplatte
  translate([2,0,2])
    difference(){
      cube([87,2,24]);
      union(){
        translate([9.4,0-epsilon,3.4])
          steckerAusklinkung(); //POWER
        translate([24.2,0-epsilon,3.4])
          steckerAusklinkung(); //HDMI
        translate([37.8,0-epsilon,3.4])
          steckerAusklinkung(); //HDMI2
        translate([55,4,7.3])
          rotate([90,0,0])
            cylinder(h=7.25,r1=3.8,r2=3.8); //AUDIO
      }
    }
    
//kurze Seitenplatte
  translate([0,2,2])
    difference(){
      cube([2,58,24]);
      for (z = [4,6,8,10,12,14])
        translate([-epsilon,25,z])
          cube([2+epsilon*2,20,1]);
    }
//lange Seitenplatte
  translate([2,60,2])
    difference(){  
      cube([87,2,24]); 
      for (z = [4,6,8,10,12,14])
        translate([22,-epsilon,z])
          cube([20,2+epsilon*2,1]);
    }
}


module steckerAusklinkung() { 
//ovale Ausklinkung
  for (x = [0,5.8])
    translate([x,7.25,2.5])
      rotate([90,0,0])
        cylinder(h=7.25,d1=5,d2=5);
  translate([0,0,0])
    cube([5.8,7.25,5]);
}
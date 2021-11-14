
$fa = 1;                // Quality: minimum angle for a fragment.
$fs = 0.4;              // Quality: minimum size of a fragment.

// Object major dimensions.
slot = 80;              // cube partition width
wall = 3;               // object wall thickness
base = 2;               // bottom thickness
height = 25;
length = 80;
MarkerR = 10;           // marker holder radius
MarkerD = 20;           // marker holder radius
MarkerH = 30;
smidge = 0.01;          // a small offset to guarantee overlap

module MarkerHolder()
{
    difference()
    {
        cylinder(d=wall+MarkerD+wall, h=MarkerH);
        translate([0, 0, 2*smidge])
            cylinder(d=MarkerD, h=MarkerH);
    }
}

module EraserHolder()
{
    len = length - 1.5 * (wall+MarkerD+wall);
    difference()
    {
        cube([wall+slot+wall, len, height], center=false);
        translate([wall, wall, smidge])
            cube([slot, len-2*wall, height], center=false);
    }
}

// Base
cube([wall+slot+wall, length, base], center=false);


// Two Marker Holders

marginX = (wall+slot+wall) - 2*(wall+MarkerD+wall);
posX1 = marginX/3 + MarkerD/2 + wall;
posX2 = (wall+slot+wall) - posX1;

translate([posX1, 2*wall+MarkerD/2, smidge])
    MarkerHolder();

translate([posX2, 2*wall+MarkerD/2, smidge])
    MarkerHolder();

translate([0, 1.5 * (wall+MarkerD+wall), smidge])
    EraserHolder();

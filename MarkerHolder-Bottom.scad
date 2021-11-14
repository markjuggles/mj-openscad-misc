
$fa = 1;                // Quality: minimum angle for a fragment.
$fs = 0.4;              // Quality: minimum size of a fragment.

// Object major dimensions.
slot = 80;              // cube partition width
wall = 3;               // object wall thickness
base = 2;               // bottom thickness
height = 25;
length = 80;
smidge = 0.01;         // a small offset to guarantee overlap

difference()
{
    cube([wall+slot+wall, length, height], center=false);
    translate([wall, -smidge, base])
        cube([slot, length+2*smidge, height], center=false);
}


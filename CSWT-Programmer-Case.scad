// Air-Compliance Programming PCB Case
//
// The PCBA has a BMI Connector end and a USB connector end.
// Dimensions are sloppy to support FDM printing.
//

$fa = 1;                // Quality: minimum angle for a fragment.
$fs = 0.4;              // Quality: minimum size of a fragment.

// Object major dimensions.
wall = 3;               // general wall thickness
objz1 = 50;             // total
objz2 = 20;             // BMI to USB transition point

InteriorX = 16.6;
CaseX = 2*wall+InteriorX;
CaseY = 13.75;          // at the BMI end

UsbSlotSizeX = 13.6;
UsbSlotSizeY = 5.8;
UsbSlotPosY = 3.6;      // Position in Y.  X is centered.

BmiSlotZ = 7.8;

// PCB Slot dimensions.
slotwidth  = 2;         // The PCB measures 1.5 mm.
slotdepth  = 1.5;       // How deep into the wall the slot goes.
PcbSlotSizeY = 3.5;     // Position in Y.

// A small offset to guarantee overlap.
smidge = 0.001;

module side()
{
    zz = objz1-objz2;
    
    TriPoints = [
    [0,0,0],            // point 0
    [0,0,zz],           // point 1
    [wall,0,zz],        // point 2
    [wall,0,0],         // point 3
    [wall,5.25,zz],     // point 4
    [0,5.25,zz]         // point 5
];

TriFaces = [
    [0,1,2,3],
    [1,5,4,2],
    [0,3,4,5],
    [3,2,4],
    [1,0,5]
];
    cube([wall,CaseY,objz1],center=false);
    translate([0,0,(objz1-objz2)])
        cube([wall,19,objz2],center=false);

    translate([0,CaseY-smidge,objz1-objz2-zz+smidge])
        polyhedron(TriPoints, TriFaces);
};

module side1()
{
    difference() 
    {
        side();
        translate([wall-slotdepth,PcbSlotSizeY,-smidge]) cube([wall,slotwidth,objz1+2*smidge]);
    }
}

module side2()
{
    difference() 
    {
        side();
        translate([-wall+slotdepth,PcbSlotSizeY,-smidge]) 
            cube([wall,slotwidth,objz1+2*smidge]);
    }
}

// Create the USB Face with hard-coded 2 mm wall.
module usbFace()
{
    difference()
    {
        cube([CaseX, CaseY, 2+2*smidge]);
        translate([ (CaseX/2)-(UsbSlotSizeX/2),
                    UsbSlotPosY, -smidge]) 
            cube([UsbSlotSizeX,UsbSlotSizeY,2.2]);
    } 
}

module MajorAssembly()
{
    side1();
    translate([wall+InteriorX,0,0]) side2();
    cube([CaseX, 2, objz1]);
    translate([0,19-2,objz1-objz2]) cube([CaseX, 2, objz2]);
    usbFace();

    // Calculate the angle and translate until it fits.
    angle = atan(5.25/(objz1-objz2));
    translate([0,11.8,0.2]) rotate([-angle,0,0]) 
        cube([CaseX,2,objz1-objz2+1]);
}



difference()
{
    MajorAssembly();
    
    // Cut out the BMI Connector rib slot. 
    translate([wall,wall+CaseY,objz1-BmiSlotZ+smidge]) 
        cube([InteriorX,2*wall,BmiSlotZ]);
}

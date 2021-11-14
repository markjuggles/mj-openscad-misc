//
// USB Hub Clip
//
// Clip a USB hub to a table.  
// The printing is rotated from the installed position so
// the axis naming is confusing. 
//

hub_y  = 15;        // Hub depth.
hub_z  = 16.5;      // Hub vertical.
thick =  4;         // thickness of clip
width = 10;         // width of clip

table = 28;         // table thickness


// Under the table.
cube([width+hub_y+width, thick, width],center=false);

// Up the back.
cube([thick, thick+table+thick+hub_z+thick, width],center=false);

// Under the hub.
translate([0,thick+table,0]) 
    cube([width+hub_y+width, thick, width],center=false);

// Over the hub.
translate([0,thick+table+thick+hub_z,0]) 
    cube([width+hub_y+width, thick, width],center=false);
       
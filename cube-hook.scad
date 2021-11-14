// 
// Matthew
// @mkmakare
// https://www.myminifactory.com/object/3d-print-cubicle-hook-107219
//
// Added variable comments and parameterized the back wall vertical.
//

t = 79;                 // thickness of cube wall
b = 30;                 // back side of cube wall vertical

f = 5;                  // hook body thickness, increase for strength
h = 12.7;               // hook vertical height
w = 25.4;               // hook diameter

length = 127;           // vertical height of the entire hook

smidge = 0.001;         // provide a tiny bit of overlap

union(){
//main body
translate([0,0,0])
cube([w,f,length]);
//thickness body
translate([0,0,length-f])
cube([w,t+f*2,f]);
//back support
//translate([0,(t+f*2)-f,length-2*w])
//cube([w,f,w*2]);
translate([0,(t+f*2)-f,length-b-f])     // added 'b' parameter
cube([w,f,b+f]);
    
    
//top hook
difference(){
rotate([0,90,0])
translate([-w*4,-w+f,0])
cylinder(w,w,w,$fn=150);
union(){
rotate([0,90,0])
translate([-w*4,-w+f,-smidge])          // the rotation makes z into x
cylinder(w+(2*smidge),w-f,w-f,$fn=150);
translate([-smidge,-2*w+f,w*4])
cube([w+2*smidge,w*2,w]);   
}
}
//bottom hook
difference(){
rotate([0,90,0])
translate([-w*1,-w+f,0])
cylinder(w,w,w,$fn=150);
union(){
rotate([0,90,0])
translate([-w*1,-w+f,-smidge])
cylinder(w+(2*smidge),w-f,w-f,$fn=150);
translate([-smidge,-2*w+f,w*1])
cube([w+2*smidge,w*2,w]);    
} 
}
//top hook addition
translate([0,-w*2+f,w*4])
cube([w,f,h]);
//bottom hook addition
translate([0,-w*2+f,w*1])
cube([w,f,h]);
}
$fn = 20 ; 
sheetThickness = 3; 
postGap = 136.36;
laserCurf = .1;

slideHeight = 160; 

boltHoleRadius = 1.5; 
roundingError = 1; 

wallThickness = 3; 
washerOD = 20; 
verticalSlideBoltToEdgeDistance = wallThickness + washerOD/ 2; 

postDiameter = 19; 

outerSlidePlateWidth = postGap + wallThickness *2 + postDiameter; 

pogoMountPlateWidth = postGap/2; 
pogoMountPlateDeapth = 50; 

circuitMountHeight = 20; 
pogoPinHeight = 10; 

pogoPinWireGap = 30; 

pogoMountPlateSeatSize = 20; 

partsPlateGap = 2;




module pogoMountPlate()
{
    cube([pogoMountPlateWidth, pogoMountPlateDeapth, sheetThickness]);
}

module slideCutOut()
{
    translate([-pogoMountPlateWidth/2 + postGap/2, 0, 0])
    cube([pogoMountPlateWidth,sheetThickness + roundingError, circuitMountHeight]);
    translate([-(pogoMountPlateWidth - pogoMountPlateSeatSize)/2 + postGap/2, 0, 0])
    cube([pogoMountPlateWidth - pogoMountPlateSeatSize, sheetThickness + roundingError, circuitMountHeight + pogoPinWireGap]);
}
//slideCutOut(); 

module outerSlidePlate()
{
    difference()
    {
        cube([outerSlidePlateWidth, sheetThickness, slideHeight]);
        translate([postDiameter/2 + wallThickness,0,0])
        slideBoltHoles();
        translate([postDiameter/2 + wallThickness, 0 , 0])
        slideCutOut();
    }
    
}

module centerSlidePlate()
{
    difference()
    {
        cube([postGap, sheetThickness, slideHeight]);
        slideBoltHoles();
        slideCutOut();
    }
    
}

module boltHole()
{
    translate([0,0,-roundingError/2 + sheetThickness/2])
       cylinder(h= sheetThickness*3 + roundingError, r = boltHoleRadius, center = true);     
}
    

module slideBoltHoles()
{
    translate([verticalSlideBoltToEdgeDistance,0,verticalSlideBoltToEdgeDistance])
    rotate([-90,0,0])
        boltHole();
    
    translate([-verticalSlideBoltToEdgeDistance + postGap,0,verticalSlideBoltToEdgeDistance])
    rotate([-90,0,0])
        boltHole(); 
    
    translate([-verticalSlideBoltToEdgeDistance + postGap,0,-verticalSlideBoltToEdgeDistance + slideHeight])
    rotate([-90,0,0])
        boltHole(); 
    
    translate([verticalSlideBoltToEdgeDistance ,0,-verticalSlideBoltToEdgeDistance + slideHeight])
    rotate([-90,0,0])
        boltHole(); 
}

module slideWasher()
{
    difference()
    {
        cylinder(h = sheetThickness, r = washerOD/2, center = true); 
        #boltHole(); 
    }
}
    
    


module assemble()
{
    centerSlidePlate();
    translate([verticalSlideBoltToEdgeDistance,0,verticalSlideBoltToEdgeDistance])
    rotate([-90,0,0]) 
       slideWasher();
    translate([-postDiameter/2 - wallThickness ,sheetThickness *2,0])
    outerSlidePlate();
    translate([-pogoMountPlateWidth/2 + postGap/2, -pogoMountPlateDeapth/2, 20])
    pogoMountPlate(); 
    
}
//assemble();

module partsPlate()
{
    
    trans1 = 100 + postGap; 
    translate([trans1,0,0])
    rotate([90,0,0])
    centerSlidePlate();
    
    trans2 = trans1 + partsPlateGap + postGap; 
    translate([trans2,0,0])
    rotate([90,0,0])
    outerSlidePlate();
    
    trans3 = trans2 + outerSlidePlateWidth + partsPlateGap;
    translate([trans3,-slideHeight,0])
    rotate([0,0,0])
    pogoMountPlate();
    
    translate([trans3 + washerOD + partsPlateGap,0,0])
    rotate([0,0,0])
    slideWasher();
    
    
    
}


projection()

partsPlate(); 



    
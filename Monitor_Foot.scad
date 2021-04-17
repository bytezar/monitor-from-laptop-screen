baseLength=120;
topLeftLength=20;
topRightSpaceLength=10;
topBarLeftHolderLength=8;
topBarRightHolderLength=5;

height=160;
width=10;
thickness=20;

barWidth=20+0.4;
barThickness=5+0.2;

screwHoleOffset=8;
screwDiameter=3.6;
nutDiameter=8;

//Computional data:
topWidth=width+barThickness;

topRightLength=topRightSpaceLength+
	barWidth+topBarRightHolderLength;
topLength=topLeftLength+topRightLength;

diffLeftLength=baseLength/2-topLeftLength;
angleLeft=atan(diffLeftLength/height);
armLeftHeight=sqrt(diffLeftLength*diffLeftLength+
	height*height);

rightHeight=height+barThickness;
diffRightLength=baseLength/2-topRightLength;
angleRight=atan(diffRightLength/rightHeight);
armRightHeight=sqrt(diffRightLength*diffRightLength+
	rightHeight*rightHeight);
	
module triangle(l,w)
{
	polygon([
		[0,0],
		[l,w],
		[l,0]
	]);
}

module top()
{
	union()
	{
		translate([-topLeftLength,height-width])
		square([topLength,width]);
		
		translate([topRightSpaceLength-topBarLeftHolderLength,height])
		triangle(topBarLeftHolderLength,barThickness);
		
		translate([topRightSpaceLength,height])
		square([barWidth+topBarRightHolderLength,barThickness]);
	}
}

module base()
{
	translate([-(baseLength-width)/2,0])
	square([baseLength-width,width]);
}

module leftArm()
{
	translate([-baseLength/2,0])
	rotate(-angleLeft)
	square([width,armLeftHeight]);
}

module rightArm()
{
	translate([baseLength/2,0])
	rotate(angleRight)
	translate([-width,0])
	square([width,armRightHeight]);
}

module barHole()
{
	translate([topRightSpaceLength,height])
	square([barWidth,barThickness]);
}

module bottomArmCut()
{
	translate([-baseLength/2-1,-width])
	square([baseLength+2,width]);
}

module main2D()
{
	difference()
	{
		union()
		{
			top();
			base();
			leftArm();
			rightArm();
		}
		
		barHole();
		bottomArmCut();
	}
}

module screwHoles()
{
	for(t=[-1,1])
	{
		x=topRightSpaceLength+barWidth/2+t*screwHoleOffset/2;
		
		translate([x,height-width-1,thickness/2])
		rotate([-90,0,0])
		cylinder(d=screwDiameter,h=width+2,$fn=16);
	}
	
	translate([topRightSpaceLength+barWidth/2+
		screwHoleOffset/2,height-width-40,thickness/2])
	rotate([-90,0,0])
	cylinder(d=nutDiameter,h=40,$fn=32);
}

difference()
{
	linear_extrude(thickness)
	main2D();
	
	screwHoles();
}

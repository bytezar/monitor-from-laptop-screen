wallThickness=2.4;
baseThickness=2.0;

space=1;

wireHoleOffsetY=wallThickness+space+35;
wireDiameter=7;
wireRadius=wireDiameter/2;

screwM3Diameter=3.6;
screwHolderDiameter=8;
nutHoleSmallInnerDiameter=8;
nutHoleBigInnerDiameter=12;
nutHoleBigOuterDiameter=
	nutHoleBigInnerDiameter+2*wallThickness;

pcbSpaceHeight=16;
screwHolderHeight=1.4;
nutBaseHeight=1.6;
nutSpaceHeight=4;
nutHolderTotalHeight=screwHolderHeight+
	nutBaseHeight+nutSpaceHeight;

innerLength=139+2*space;
innerWidth=58+2*space;
totalLength=innerLength+2*wallThickness;
totalWidth=innerWidth+2*wallThickness;

totalHeight=pcbSpaceHeight+nutHolderTotalHeight;
innerHeight=totalHeight-baseThickness;

hole1OffsetX=wallThickness+space+13.3;
hole2OffsetX=wallThickness+space+125;
hole12OffsetY=wallThickness+space+21;

hole3OffsetX=wallThickness+space+14.3;
hole4OffsetX=wallThickness+space+119.3;
hole34OffsetY=wallThickness+space+49;

holderFn=32;
screwFn=16;

module mainBox()
{
	difference()
	{
		cube([totalLength,totalWidth,totalHeight]);
		
		translate([wallThickness,wallThickness,baseThickness])
		cube([innerLength,innerWidth,innerHeight+1]);
		
	}
}

module makeForEveryScrew()
{
	for(t=[[hole1OffsetX,hole12OffsetY],[hole2OffsetX,hole12OffsetY],
		[hole3OffsetX,hole34OffsetY],[hole4OffsetX,hole34OffsetY]])
	{
		translate([t[0],t[1],0])
		children();
	}
}

module nutHolder()
{
	cylinder(
		d=nutHoleBigOuterDiameter,
		//d2=nutHoleSmallOuterDiameter,
		h=nutSpaceHeight,
		$fn=holderFn
	);
	
	translate([0,0,nutSpaceHeight])
	cylinder(
		d=nutHoleBigOuterDiameter,
		h=nutBaseHeight,
		$fn=holderFn
	);
	
	translate([0,0,nutSpaceHeight+nutBaseHeight])
	cylinder(
		d=screwHolderDiameter,
		h=screwHolderHeight,
		$fn=holderFn
	);
}

module nutHole()
{
	cylinder(
		d1=nutHoleBigInnerDiameter,
		d2=nutHoleSmallInnerDiameter,
		h=nutSpaceHeight,
		$fn=holderFn
	);
}

module screwHole()
{
	//We must use drill to whole screw hole
	//We need print bridges above nut space
	translate([0,0,nutSpaceHeight+nutBaseHeight])
	cylinder(
		d=screwM3Diameter,
		h=screwHolderHeight+1,
		$fn=screwFn
	);
}

module wireHole()
{
	translate([totalLength-wallThickness-1,
		wireHoleOffsetY,totalHeight-wireRadius])
	{
		rotate([0,90,0])
		cylinder(d=wireDiameter,h=wallThickness+20,$fn=holderFn);
		
		translate([0,-wireRadius,0])
		cube([wallThickness+2,wireDiameter,wireRadius]);
	}
}

module plugsHole()
{
	translate([wallThickness,-1,totalHeight-pcbSpaceHeight])
	cube([innerLength,wallThickness+2,pcbSpaceHeight+1]);
}

difference()
{
	union()
	{
		mainBox();
		
		makeForEveryScrew()
		nutHolder();
	}
	
	wireHole();
	
	plugsHole();
	
	makeForEveryScrew()
	nutHole();
	
	makeForEveryScrew()
	screwHole();
}

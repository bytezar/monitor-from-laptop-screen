height=14;
nutHeight=4;
coneHeight=2;

nutDiameter=7;
holderDiameter=8;
screwM3Diameter=3.6;

holderFn=32;
screwFn=16;

wallThickness=2.4;

bottomDiameter=nutDiameter+2*wallThickness;

module main()
{
	cylinder(
		d=bottomDiameter,
		h=nutHeight,
		$fn=holderFn
	);
	
	translate([0,0,nutHeight])
	cylinder(
		d1=bottomDiameter,
		d2=holderDiameter,
		h=coneHeight,
		$fn=holderFn
	);
	
	cylinder(
		d=holderDiameter,
		h=height,
		$fn=holderFn
	);
}

module hole()
{
	translate([0,0,-1])
	cylinder(
		d=nutDiameter,
		h=nutHeight+1,
		$fn=screwFn
	);
	
	
	translate([0,0,nutHeight])
	cylinder(
		d1=nutDiameter,
		d2=screwM3Diameter,
		h=coneHeight,
		$fn=screwFn
	);
	
	translate([0,0,-1])
	cylinder(
		d=screwM3Diameter,
		h=height+2,
		$fn=screwFn
	);
}


difference()
{
	main();
	hole();
}

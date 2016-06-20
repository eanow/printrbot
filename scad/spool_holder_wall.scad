
$fs=1;
$fa=1;
rod_r=8.5/2;
top_r=5;

ep=0.01;

num8slot=4.8;

module num8counter()
//countersink shape
{
    hh=3.6;
    rr=8.6/2;
    foot_t=10;
    translate([0,0,-hh])
    {
        cylinder(r1=num8slot/2,r2=rr,h=hh,$fn=24);
        translate([0,0,-foot_t])cylinder(r1=num8slot/2,r2=num8slot/2,h=hh+foot_t,$fn=24);
        translate([0,0,hh-ep])cylinder(r=rr,h=foot_t,$fn=24);
    }
}



body_r=26;
body_t=30;
module shape()
{
    rotate([5,0,0])
    {
        difference()
        {
            union()
            {
                translate([0,0,(body_t-top_r-3)/2])cylinder(r=body_r,h=body_t-top_r+3,center=true);
                translate([0,0,(body_t)/2])cylinder(r=body_r-top_r,h=body_t,center=true);
                translate([0,0,body_t-top_r])rotate_extrude(angle=360)
                {
                    translate([body_r-top_r,0])circle(r=top_r);
                }
                translate([0,0,body_t+1-ep])cylinder(r=6,h=2,center=true);
            }
            translate([0,0,body_t/2])cylinder(r=rod_r,h=2*body_t,center=true);
            //%translate([0,0,body_t/2])cylinder(r=rod_r,h=2*body_t,center=true);
        }
    }
    for (ii=[0:3])
    {
        rotate([0,0,90*ii])translate([0,-10,0])difference()
        {
            minkowski()
            {
                rotate([90,0,0])cylinder(r1=22,r2=9,h=43,$fn=6);
                sphere(r=2,$fn=30);
            }

            translate([0,-33,10])rotate([20,0,0])num8counter();
        }
    }
}
module mount()
{
    difference()
    {
        shape();
        translate([0,0,-50])cube([200,200,100],center=true);
    }
}

shaft_t=70;
plate_t=3;
shaft_r=50/2;
plate_r=shaft_r+20;
bearing_r=22.4/2;
bearing_t=7.1;
gap_r=13/2;
module shaft()
{
    difference()
    {
        union()
        {
            minkowski()
            {
                cylinder(r=shaft_r-2,h=shaft_t+plate_t+.8-2);
                sphere(r=2,$fn=40);
            }
            cylinder(r=plate_r,h=plate_t);
        }
    
    
        translate([0,0,-ep])cylinder(r=bearing_r,h=bearing_t);
        translate([0,0,-ep])cylinder(r=gap_r,h=plate_t+shaft_t+1);
        translate([0,0,plate_t+shaft_t-bearing_t+ep])cylinder(r=bearing_r,h=bearing_t);
        translate([0,0,bearing_t-ep*2])cylinder(r1=bearing_r,r2=gap_r,h=bearing_r-gap_r);
        translate([0,0,plate_t+shaft_t])cylinder(r1=bearing_r,r2=bearing_r-.8,h=.8+ep);
        translate([0,0,-5])cube([200,200,10],center=true);
    }
}
module tester()
{
    difference()
    {
        cylinder(r=20,h=8,center=true);
        cylinder(r=bearing_r,h=12,center=true);
    }
}

//tester();
shaft();

num8slot=4.8;
ep=0.01;

foot_t=8;
shaft_t=10;
foot_l=20;
foot_w=16;
$fa=1;
$fs=1;

m4_slot=4.5;
m4_nut_h=3;
m4_nut_d=7.9;


module num8counter()
//countersink shape
{
    hh=3.6;
    rr=8.6/2;
    translate([0,0,-hh])
    {
        cylinder(r1=num8slot/2,r2=rr,h=hh,$fn=24);
        translate([0,0,-foot_t])cylinder(r1=num8slot/2,r2=num8slot/2,h=hh+foot_t,$fn=24);
        translate([0,0,hh-ep])cylinder(r=rr,h=foot_t,$fn=24);
    }
}

//num8counter();

module foot()
{
    difference()
    {
        union()
        {
            //roundy bit
            translate([foot_l,0,foot_t/2])cylinder(r=foot_w/2,h=foot_t,center=true);
            //squarey bit
            translate([foot_l/2,0,foot_t/2])cube([foot_l,foot_w,foot_t],center=true);
        }
        translate([0,0,(foot_t-3.6)-.8])translate([foot_l,0,foot_t/2])rotate([0,20,0])num8counter();
    }
}
module solids()
{

    foot();
    rotate([0,0,120])foot();
    translate([0,0,shaft_t/2])cylinder(r=foot_w/2,h=shaft_t,center=true);
}
difference()
{
    solids();
    cylinder(r=m4_nut_d/2,h=m4_nut_h*2,center=true,$fn=6);
    translate([0,0,2+m4_nut_h*2-ep])cylinder(r1=m4_nut_d/2,r2=.1,h=m4_nut_h*2+4,center=true,$fn=6);
    translate([0,0,ep])cylinder(r=m4_slot/2,h=shaft_t*2,center=true);
}
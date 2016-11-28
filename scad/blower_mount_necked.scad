/*intersection()
{   
    import("../stl/Mounting_kit_-_Blower_mount.stl");
    translate([0,0,13.15])cube([60,60,10],center=true);
}*/
//scale([1.03,1.03,1])import("../stl/Mounting_kit_-_Blower_mount.stl");
plate_t=3;
module fan_bracket()
{
    fansize=40;
    holespace=32;
    round_r=4;
    m3_slot=3.5;
    linear_extrude(height=plate_t)difference()
    {
        minkowski()
        {
            square([fansize-round_r*2,fansize-round_r*2],center=true);
            circle(r=round_r,$fn=40);
        }
        for (aa=[-.5:1:.5])
        {
            for (bb=[-.5:1:.5])
            {
                translate([aa*holespace,bb*holespace])circle(r=m3_slot/2,$fn=30);
            }
        }
        //circle(r=36/2,$fn=60);
    }
}
b_l=20.5;
b_w=15.6;
module blower_neck()
{
    translate([0,0,6])cube([b_w,b_l,20],center=true);
}
module slope()
{
    hull()
    {
        translate([0,0,9])cube([b_w+2.4,b_l+2.4,2],center=true);
        translate([0,0,1])cube([b_w+11,b_l+9,2],center=true);
    }
}
module retainer()
{
    translate([0,0,10-0.1+1.5])cube([b_w+2.4,b_l+2.4,2.5+3],center=true);
}
module latch_cut()
{
    translate([0,-b_l/2,5+10])cube([4.5,10,10],center=true);
    translate([0,b_l/2,5+10+2.5])cube([b_w,10,10],center=true);
}
difference()
{
    union()
    {
        slope();
        fan_bracket();
        retainer();
    }
    blower_neck();
    latch_cut();
}
module mount()
{
    intersection()
    {
        import("../stl/extruder_body_fixed.stl");
        translate([22,0,0])cube([100,100,100],center=true);
    }
}

back_d=52.7;
metal_thick=3.5;
$fs=.5;
$fa=2;
lip=6.6;
back_t=1;
thick=4;
mount_d=46.86;
mount_s=2.6;

module bracket()
{
    b_t=5;
    ep=.001;
    rod=60;
    r_g=60.76;
    r_d=10.1;
    difference()
    {
        translate([0,0,b_t/2])cube([rod,back_d,b_t],center=true);
        //translate([0,.707*mount_d/2,back_t+b_t])cube([back_d,8,b_t*2],center=true);
        //translate([0,-.707*mount_d/2,back_t+b_t])cube([back_d,8,b_t*2],center=true);

        
        
        
        //screw holes
        for (ii=[0:4])
        {
            rotate(ii*90+45,[0,0,1])translate([mount_d/2,0,-back_t+back_t/2])cylinder(r1=mount_s/2,r2=mount_s/2,h=back_t*2);
        }
        //groove
        translate([0,0,-ep])difference()
        {
            cylinder(r1=back_d/2+1, r2=back_d/2+.5, h=back_t+ep*2);
            cylinder(r1=back_d/2-.5, r2=back_d/2, h=back_t+ep*2);
        }
    }
}
difference()
{
    union()
    {
        mount();
        translate([-(37.7-6.5),32,19.7/2])rotate(-90,[0,0,1])rotate(90,[-1,0,0])bracket();
    }
    translate([-(37.7-6.5)+50+back_t,15.3,26.3])cube([100,5,5],center=true);
    translate([-(37.7-6.5)+50+back_t,33+15.3,26.3])cube([100,5,5],center=true);
    translate([-(37.7-6.5)+50+back_t,33+15.3,-6.5])cube([100,5,5],center=true);
    translate([-(37.7-6.5)+50+back_t,15.3,-6.5])cube([100,5,5],center=true);
}


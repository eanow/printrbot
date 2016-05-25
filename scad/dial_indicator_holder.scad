back_d=52.7;
metal_thick=3.5;
$fs=.5;
$fa=2;
lip=6.6;
back_t=2;
thick=4;
mount_d=46.86;
mount_s=2.5;
difference()
{
    cylinder(r1=back_d/2, r2=back_d/2, h=back_t);
    for (ii=[0:4])
    {
        rotate(ii*90+45,[0,0,1])translate([mount_d/2,0,-back_t+back_t/2])cylinder(r1=mount_s/2,r2=mount_s/2,h=back_t*2);
    }
}

translate([0,-5,0])
{
    difference()
    {
        translate([back_d/4-1.5,0,lip/2+back_t-0.001])cube([back_d/2-3,thick+thick+metal_thick,lip],center=true);
        translate([back_d/4-.01,0,lip/2+back_t-0.001])cube([back_d/2,metal_thick+0.01,lip+1],center=true);
        xpos=back_d/2-15-20;
        translate([xpos,-thick,lip/2+back_t-0.001])cube([30,thick+1,lip+1],center=true);
        //setscrew hole
        translate([back_d/8,thick+metal_thick,back_t+lip/2])rotate(90,[1,0,0])cylinder(r1=3/2,r2=3/2,h=thick*2);
        translate([3*back_d/8,thick+metal_thick,back_t+lip/2])rotate(90,[1,0,0])cylinder(r1=3/2,r2=3/2,h=thick*2);
    }
    translate([-thick/2+.01,-thick*2+metal_thick/2+thick,lip/2+back_t-0.001])cube([thick,thick*4,lip],center=true);
    translate([-thick,-thick*2+metal_thick/2+thick,back_t])rotate(45,[0,1,0])cube([thick/2,thick*4,thick/2],center=true);
    translate([back_d/4-1.5,5.75,back_t])rotate(45,[1,0,0])cube([back_d/2-3,thick/2,thick/2],center=true);
    translate([back_d/4+1.5,-5.75,back_t])rotate(45,[1,0,0])cube([back_d/2-10,thick/2,thick/2],center=true);
}
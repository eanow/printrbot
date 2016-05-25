cube([22,4,60],center=true);
translate([0,12.99,-10])
difference()
{   
    cube([22,22,5],center=true);
    cylinder(r1=13/2,r2=13/2,h=10,center=true);
}
intersection()
{
    import("pbFanBlank.stl");
    translate([-250,-250,0])
    {
        cube([500,500,3]);
    }
}
$fn=50;
translate([6.75,16,0])
{
    translate([-2,-2,0])
    {
        cube([4,4,3]);
    }
    cylinder(r1=1.5,r2=1.5,h=9);
}
translate([6.75,-16,0])
{
    translate([-2,-2,0])
    {
        cube([4,4,3]);
    }
    cylinder(r1=1.5,r2=1.5,h=9);
}
translate([-25.25,16,0])
{
    translate([-2,-2,0])
    {
        cube([4,4,3]);
    }
    cylinder(r1=1.5,r2=1.5,h=9);
}
intersection()
{   
    import("../stl/Mounting_kit_-_Blower_mount.stl");
    translate([0,0,13.15])cube([60,60,10],center=true);
}
scale([1.03,1.03,1])import("Mounting_kit_-_Blower_mount.stl");
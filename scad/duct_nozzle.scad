fansize=40;
holespace=32;
round_r=4;
bracket_h=8;
wall_thick=4;
m3_tap=3;
m3_slot=3.5;
$fa=.5;
$fs=.5;
print_buff=1.2;

kneeangle=45; //angle of fan mount, from straight out
hingegap=6.25; //space between hinge brackets

ep=0.001; //small value, used to nudge and eliminate abiguity on faces touching


nozplate=2; //thickness of nozzle baseplate
k1gap=36; //shift at first knee
k2gap=45;
k3gap=42;
k3down=3; //shift the end down a bit
shell_t=1;
duct0h=24;
duct1h=10;
duct2h=24;
duct0r=36/2;
duct1r=28/2;
duct2r=18/2;
duct3r=12/2;
module duct1(inset)
{
    hull()
    {
        cylinder(r=duct0r-inset,h=ep,center=true);
        translate([k1gap/2,0,duct0h])cylinder(r=duct1r-inset,h=ep,center=true);
    }

}
module duct2(inset)
{
    hull()
    {
        translate([k1gap/2,0,duct0h-ep])cylinder(r=duct1r-inset,h=ep,center=true);
        translate([0,0,duct0h])rotate(kneeangle/2,[1,0,0])translate([k2gap/2,0,duct1h])cylinder(r=duct2r-inset,h=ep,center=true);
    }

}
module duct3(inset)
{
    hull()
    {
        translate([0,0,duct0h-ep])rotate(kneeangle/2,[1,0,0])translate([k2gap/2,0,duct1h])cylinder(r=duct2r-inset,h=ep,center=true);
        translate([0,k3down,duct0h])rotate(kneeangle/2,[1,0,0])translate([0,0,duct1h])rotate(kneeangle/2,[1,0,0])translate([k3gap/2,0,duct2h])cylinder(r=duct3r-inset,h=ep,center=true);
        //endcap
        translate([0,k3down,duct0h])rotate(kneeangle/2,[1,0,0])translate([0,0,duct1h])rotate(kneeangle/2,[1,0,0])translate([k3gap/2,0,duct2h])sphere(r=duct3r-inset,center=true);
    }

}
module nozzle()
{
    difference()
    {
        union()
        {
        //plate
        linear_extrude(height=nozplate)minkowski()
        {
            square([fansize-round_r*2,fansize-round_r*2],center=true);
            circle(r=round_r);
        }
        //first duct
        duct1(0);
        }
        translate([0,0,-ep/2])scale([1,1,1+ep])duct1(shell_t);
        translate([-holespace/2,-holespace/2,ep])cylinder(h=nozplate*2,r=(m3_slot/2),center=true);
        translate([-holespace/2,holespace/2,ep])cylinder(h=nozplate*2,r=(m3_slot/2),center=true);
        translate([holespace/2,holespace/2,ep])cylinder(h=nozplate*2,r=(m3_slot/2),center=true);
        translate([holespace/2,-holespace/2,ep])cylinder(h=nozplate*2,r=(m3_slot/2),center=true);
    }
    difference()
    {
        duct2(0);
        translate([0,0,+ep])duct2(shell_t);
        translate([0,0,-ep])duct2(shell_t);
    }
    difference()
    {
        duct3(0);
        translate([0,0,+ep])duct3(shell_t);
        translate([0,0,-ep])duct3(shell_t);
        //air slots
        //added in extra translate
        translate([17,-10,48])rotate(kneeangle,[1,0,0])translate([0,1,-2])cube([6,4,15],center=true);
        translate([-17,-10,48])rotate(kneeangle,[1,0,0])translate([0,1,-2])cube([6,4,15],center=true);
    }
}

nozzle();
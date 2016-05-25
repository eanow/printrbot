wall=1.2;
thick=12;

$fs=1;
$fa=1;
ep=0.01;
width=40;
height=15;
flat=5;
round=4;
m3_slot=3.5;
bolt_slot=5.5;
module basic(xx,yy,rr,ff) //x extent, y extent, roundness, foot cutoff
{
    mx=xx-rr;
    my=yy-rr;
    minkowski()
    {
        difference()
        {
            ratio=xx/yy;
            scale([ratio,1])circle(r=my/2);
            translate([0,-(my-ff)])square([mx*2,my],center=true);
        }
        circle(r=rr);
    }
}
module afoot()
{
    translate([0,0,-thick/2])linear_extrude(height=thick)basic(width,height+flat,round,flat);
}
module bfoot()
{
    rotate([0,90,0])translate([0,0,-thick/2])linear_extrude(height=thick)difference()
    {
        basic(width+wall,height+flat+wall,round,flat);
        basic(width-wall,height+flat-wall,round,flat);
    }
}
difference()
{
    afoot();
    bfoot();
    rotate([-90,0,0])cylinder(r=m3_slot/2,h=height);
    rotate([90,0,0])cylinder(r=bolt_slot/2,h=height);
}

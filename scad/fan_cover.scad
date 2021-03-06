screw_space=71.5;
hole_d=3.5;
air_d=6;
cover_side=80;
fan_d=76;
round=5/2;
difference()
{
linear_extrude(height=3)difference()
{
    minkowski()
    {
        square([cover_side-round*2,cover_side-round*2],center=true);
        circle(r=round,$fn=20);
    }
    //screw holes
    translate([screw_space/2,screw_space/2])circle(r=hole_d/2,center=true,$fn=12);
    translate([-screw_space/2,screw_space/2])circle(r=hole_d/2,center=true,$fn=12);
    translate([-screw_space/2,-screw_space/2])circle(r=hole_d/2,center=true,$fn=12);
    translate([screw_space/2,-screw_space/2])circle(r=hole_d/2,center=true,$fn=12);
    intersection()
    {
        
        yy=(air_d*sqrt(3)/2)+.8;
        span=floor(cover_side/yy/2);
        xx=cos(60)*(yy-1.2)*2*2+.8;
        
        circle(r=fan_d/2);
        for(aa=[-span/2-1:span/2])
        {
            for(bb=[-span-1:span])
            {
                translate([aa*xx,bb*yy])circle(r=air_d/2,$fn=6);
                translate([aa*xx+.5*xx,bb*yy+yy*.5])circle(r=air_d/2,$fn=6);
            }
        }
    }
}
translate([0,0,5+1])cylinder(r=fan_d/2+5,h=10,center=true);
}
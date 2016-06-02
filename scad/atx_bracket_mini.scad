atx_h=150;
atx_d=86;
atx_w=141;

felt_w=19.5;
felt_t=1;

foot_t=9;
wall=8;

ep=0.01;

num8slot=4.8;

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

module atx_supply()
{
    color([.6,.6,.6])translate([0,0,atx_h/2])cube([atx_w,atx_d,atx_h],center=true);
}

module bracket()
{
    //top portion
    ww=atx_w+wall*2+felt_t*2+felt_t;
    hh=atx_h+wall+felt_t;
    zz=atx_h+felt_t;
    yy=atx_d/2+felt_t;
    xx=atx_w/2+felt_t;
    //translate([0,-(yy),zz])cube([ww,wall*2+felt_t,wall*2+felt_t],center=true);
    translate([-xx,-yy,hh/2])cube([wall*2+felt_t,wall*2+felt_t,hh],center=true);
    //translate([xx,-yy,hh/2])cube([wall*2+felt_t,wall*2+felt_t,hh],center=true);
    //foot
    translate([-(xx+7),18-(yy+(wall+felt_t/2)),foot_t/2])cube([42,36,foot_t],center=true);
    //translate([(xx),9-(yy+(wall+felt_t/2)),foot_t/2])cube([42,36,foot_t],center=true);
}
module complete()
{
    difference()
    {
        bracket();
        translate([0,0,atx_h/2])cube([atx_w+felt_t*2,atx_d+felt_t*2,atx_h+felt_t*2],center=true);
        translate([-(atx_w/2+wall*2+3),9-(atx_d/2+felt_t+(wall+felt_t/2)),foot_t])rotate([0,-20,0])num8counter();
        translate([-(atx_w/2+wall*2+3),27-(atx_d/2+felt_t+(wall+felt_t/2)),foot_t])rotate([0,-20,0])num8counter();
    }
}

complete();

//atx_supply();
    
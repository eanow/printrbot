//variables, in mm
foot_width=140; //size of total object, width
foot_length=140;    //size of total object, length (y axis of printrbot)
leg_width=18;   //width of sticking-out-feet
frame_thick=2.8;  //thickness of metal printrbot frame
side_ledge=4;   //how much thickness on sides and inside

inside_width=88;    //space between metal walls, inside
outside_width=95;
corner_thick=(outside_width-inside_width)/2;
lip=12;         //how tall to make the part that slides over the metal sides
lift=8;         //how thick of a baseplate

rivet1_z=34.3;
rivet1_y=6.2;
rivet2_z=27.75;
rivet2_y=113.5;
rivet_r=4;
rivet_thick=5;
m4_slot=4.5;
$fs=1;
$fa=1;
//intermediate values

side_xx=side_ledge*2+frame_thick;
inner_xx=inside_width+2*(frame_thick+side_ledge);

module rivet1()
{
    rotate([0,0,0])
    {
        cube([rivet_thick, rivet_r*2, lip*2], center=true);
    }
}


//baseplate
module base()
{
    linear_extrude(height=lift)
    difference()
    {
        union()
        {
            //legs
            square([foot_width-leg_width,leg_width],center=true);
            translate([foot_width/2-leg_width/2,0])
            {
                circle(r=leg_width/2,center=true);
            }
            translate([-1*(foot_width/2-leg_width/2),0])
            {
                circle(r=leg_width/2,center=true);
            }
        }
        translate([foot_width/2-leg_width/2,0])circle(r=m4_slot/2,center=true,$fn=20);
        translate([-(foot_width/2-leg_width/2),0])circle(r=m4_slot/2,center=true,$fn=20);
    }
}
module lip()
{
    translate([0,0,lip/2+lift])
    {
        cube([outside_width+side_ledge*2,leg_width,lip],center=true);
    }
}

module interior()
{
    translate([0,-side_ledge*2-frame_thick,lip+lift])
    {
        cube([inside_width-side_ledge*2,leg_width,lip*2],center=true);
    }
}
module groove()
{
    //rear bit
    translate([0,leg_width/2-frame_thick/2-side_ledge,lip])
    {
        cube([outside_width,frame_thick,lip*2],center=true);
    }
    //sides
    translate([inside_width/2+corner_thick/2,-side_ledge,lip])
    {
        cube([corner_thick,leg_width,lip*2],center=true);
    }
    //sides
    translate([-inside_width/2-corner_thick/2,-side_ledge,lip])
    {
        cube([corner_thick,leg_width,lip*2],center=true);
    }
    translate([inside_width/2+corner_thick/2,leg_width/2-side_ledge-frame_thick/2-rivet1_y,lift+lip])
{
    rivet1();
    }
    translate([-inside_width/2-corner_thick/2,leg_width/2-side_ledge-frame_thick/2-rivet1_y,lift+lip])
    {
        rivet1();
    }
}
module inside_corner()
{
    translate([inside_width/2,leg_width/2-side_ledge-frame_thick,lip+lift/2])
    {
        rotate([0,0,45])
        {
            cube([rivet_thick/2,rivet_thick/2,lip*2],center=true);
        }
    }
    translate([-inside_width/2,leg_width/2-side_ledge-frame_thick,lip+lift/2])
    {
        rotate([0,0,45])
        {
            cube([rivet_thick/2,rivet_thick/2,lip*2],center=true);
        }
    }
}
union()
{
    base();
    difference()
    {
        lip();
        groove();
        interior();
        inside_corner();
    }
}












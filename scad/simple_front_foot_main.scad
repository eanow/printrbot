//variables, in mm
foot_width=145; //size of total object, width
foot_length=140;    //size of total object, length (y axis of printrbot)
leg_width=18;   //width of sticking-out-feet
frame_thick=2.4;  //thickness of metal printrbot frame
front_ledge=3;  //how much thickness in front of edge
protrude=3;     //how much the metal plates protrude past the side, i.e. the notch needed on the front
side_ledge=3.5;   //how much thickness on sides and inside
inside_width=91.5;    //space between metal walls, inside
lip=12;         //how tall to make the part that slides over the metal sides
lift=8;         //how thick of a baseplate
usb_thick=15;   //how thick usb strain relieft should be
usb_wide=35;    //width
usb_tall=41;    //height    
usb_w=11;       //width of usb plug
usb_h=8;        //height of usb plug
usb_y=102.45;  //center of plug, relative to front edge
usb_z=35;   //center of plug, relative to top of base plate
clip_h=45;  //how tall wrap around clip should be- top of base plate to bottom of groove
clip_split=5;  //where to split clip
clip_wide=15;   //width of clip
clip_groove=1.75;  //depth of groove on top of clip
clip_thick=7; //thickness of clip
tab_thick=3.2; //tab thickness, should be multiple of extrusion width
tab_wide=6.4; //tab width
tab_slop=.3;    //additional gab to have around slot for tab due to printer tolerances
tab_length=5;
gap_width=60;
gap_y=50;   //front edge of metal to middle of cutout
center_bar=30;
curve_40=2.35;
curve_80=5.25;
curve_120=6;

rivet1_z=34.3;
rivet1_y=12.6;
rivet2_z=27.75;
rivet2_y=113.5;
rivet_r=4;
rivet_thick=1.5;

//intermediate values
front_yy=front_ledge+protrude+frame_thick+side_ledge;
side_xx=side_ledge*2+frame_thick;
inner_xx=inside_width+2*(frame_thick+side_ledge);

module rivet1()
{
    translate([-1*(inside_width/2+frame_thick),foot_length/2-front_ledge-rivet1_y,lift+rivet1_z])
    {
        rotate([0,90,0])
        {
            cylinder(h=2*rivet_thick, r1=rivet_r, r2=rivet_r, center=true);
        }
    }
}



module rivet1a()
{
    translate([1*(inside_width/2+frame_thick),foot_length/2-front_ledge-rivet1_y,lift+rivet1_z])
    {
        rotate([0,90,0])
        {
            cylinder(h=2*rivet_thick, r1=rivet_r, r2=rivet_r, center=true);
        }
    }
}



module rivet2()
{
    translate([-1*(inside_width/2+frame_thick),foot_length/2-front_ledge-rivet2_y,lift+rivet2_z])
    {
        rotate([0,90,0])
        {
            cylinder(h=2*rivet_thick, r1=rivet_r, r2=rivet_r, center=true);
        }
    }
}


//supports due to curve
module curve_adj()
{

union()
    {
        translate([-1*(inside_width/2)-frame_thick/2,foot_length/2-front_ledge-40,lift])
        {
        cube([frame_thick*2,frame_thick*2,curve_40*2],center=true);
        }
        translate([1*(inside_width/2)+frame_thick/2,foot_length/2-front_ledge-40,lift])
        {
        cube([frame_thick*2,frame_thick*2,curve_40*2],center=true);
        }
        translate([-1*(inside_width/2)-frame_thick/2,foot_length/2-front_ledge-80,lift])
        {
        cube([frame_thick*2,frame_thick*2,curve_80*2],center=true);
        }
        translate([1*(inside_width/2)+frame_thick/2,foot_length/2-front_ledge-80,lift])
        {
        cube([frame_thick*2,frame_thick*2,curve_80*2],center=true);
        }
        translate([-1*(inside_width/2)-frame_thick/2,foot_length/2-front_ledge-120,lift])
        {
        cube([frame_thick*2,frame_thick*2,curve_120*2],center=true);
        }
        translate([1*(inside_width/2)+frame_thick/2,foot_length/2-front_ledge-120,lift])
        {
        cube([frame_thick*2,frame_thick*2,curve_120*2],center=true);
        }
    }
}
//baseplate
module base()
{
    linear_extrude(height=lift)
    union()
    {
    square(size=[(frame_thick+side_ledge)*2+inside_width,foot_length], center=true);
    translate([0,-1*((foot_length-leg_width)/2)])
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
        }
    translate([0,1*((foot_length-leg_width)/2)])
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
    }
}
module slot()
{
    difference()
    {
        
        union()
        {
            //front prism
            translate([0,(foot_length-front_yy)/2,(lip+lift)/2])
            {
            cube([(frame_thick+side_ledge)*2+inside_width,front_yy,lip+lift],center=true);
            }
            translate([(inner_xx-side_xx)/2,0,(lip+lift)/2])
            {
            cube([side_xx,foot_length,lip+lift],center=true);
            }
            translate([-1*(inner_xx-side_xx)/2,0,(lip+lift)/2])
            {
            cube([side_xx,foot_length,lip+lift],center=true);
            }
        }
            
        
        difference()
        {
            union()
            {
                translate([0,((foot_length)/2)-front_ledge-frame_thick/2-protrude,(.5*lip+lift+.5)])
                {
                cube([(inside_width+frame_thick*2),frame_thick,lip+1],center=true);//1 so that faces don't overlap
                }
                translate([(inner_xx-side_xx)/2,-1*(front_ledge),(.5*lip+lift+.5)])
                {
                cube([frame_thick,foot_length,lip+1],center=true);
                }
                translate([-1*(inner_xx-side_xx)/2,-1*(front_ledge),(.5*lip+lift+.5)])
                {
                cube([frame_thick,foot_length,lip+1],center=true);
                }
            }
            curve_adj();
        }
    }
}

module usb()
{
    difference()
    {
        difference()
        {
            translate([-1*(frame_thick+(inside_width+usb_thick)/2),(foot_length/2)-front_ledge-usb_y,(usb_tall+lift)/2])
            {
            cube([usb_thick,usb_wide,usb_tall+lift],center=true);
            }
            translate([-1*(frame_thick+(inside_width+usb_thick)/2),(foot_length/2)-front_ledge-usb_y,lift+usb_z])
            {
            cube([usb_thick*2,usb_w,usb_h],center=true);
            }
        }
    //knock off edges
        union()
        {
            translate([-1*(frame_thick+inside_width/2+usb_thick),(foot_length/2)-front_ledge-usb_y+usb_wide/2,(usb_tall+lift)/2])
            {
                rotate([0,0,45])
                {
                    cube([usb_thick*.3,usb_thick*.3,usb_tall+lift*2], center=true);
                }
            }
            //knock off edges
            translate([-1*(frame_thick+inside_width/2+usb_thick),(foot_length/2)-front_ledge-usb_y-usb_wide/2,(usb_tall+lift)/2])
            {
                rotate([0,0,45])
                {
                    cube([usb_thick*.3,usb_thick*.3,usb_tall+lift*2], center=true);
                }
            }
        }
    }
}

module post()
{
    difference()
    {
        translate([inside_width/2+frame_thick+clip_thick/2,foot_length/2-front_ledge-clip_wide/2,lift+(clip_h-clip_split)/2-lift/2])
        {
            cube([clip_thick,clip_wide,clip_h-clip_split+lift],center=true);
        }
        translate([1*(inside_width/2+frame_thick+clip_thick/2),foot_length/2-front_ledge-clip_wide/2,lift+(clip_h-clip_split)])
        {
            cube([tab_thick+tab_slop,tab_wide+tab_slop,(tab_length-tab_slop)*2],center=true);
        }
    }
    difference()
    {
        translate([-1*(inside_width/2+frame_thick+clip_thick/2),foot_length/2-front_ledge-clip_wide/2,lift+(clip_h-clip_split)/2-lift/2])
        {
            cube([clip_thick,clip_wide,clip_h-clip_split+lift],center=true);
        }
        translate([-1*(inside_width/2+frame_thick+clip_thick/2),foot_length/2-front_ledge-clip_wide/2,lift+(clip_h-clip_split)])
        {
            cube([tab_thick+tab_slop,tab_wide+tab_slop,(tab_length-tab_slop)*2],center=true);
        }
    }
}


module air_cut()
{
    translate([inside_width/2+center_bar/2,foot_length/2-front_ledge-gap_y,0])
    {
    cube([(inside_width),gap_width,lift+lip*10], center=true);
    }
    translate([-1*(inside_width/2+center_bar/2),foot_length/2-front_ledge-gap_y,0])
    {
    cube([(inside_width),gap_width,lift+lip*10], center=true);
    }
}



        difference()
            {
                usb();
                rivet2();
                translate([0,0,lift+200])
                {
                    cube([400,400,400],center=true);
                }
            }

        difference()
        {
            union()
            {
                
                
                base();
                slot();
                
                difference()
                {
                    post();
                    union()
                    {
                        rivet1();
                        rivet1a();
                    }
                }
            }
            air_cut();
        }
 
    

module clip()
{
    difference()
    {
        union()
        {
        translate([200,0,clip_thick/2])
            {
                //base of clip
            cube([clip_thick*2+frame_thick,clip_wide,clip_thick],center=true);
            }
        translate([200-(clip_thick*2+frame_thick)/2+clip_thick/2,0,clip_thick/2+clip_groove/2])
            {
                //short bit
            cube([clip_thick,clip_wide,clip_thick+clip_groove],center=true);
            }
        translate([200+(clip_thick*2+frame_thick)/2-clip_thick/2,0,clip_thick/2+clip_split/2])
            {//tall bit
            cube([clip_thick,clip_wide,clip_thick+clip_split],center=true);
            }
        translate([200+(clip_thick*2+frame_thick)/2-clip_thick/2,0,clip_split+clip_thick])
            {//pin
            cube([tab_thick,tab_wide,tab_length*2],center=true);
            }
        }
        union()
        {
            translate([200+clip_thick+frame_thick/2,0,0])
            {
                //tall side
                rotate([0,45,0])
                {   
                    cube([frame_thick,clip_wide,frame_thick],center=true);
                }
            }
            translate([200-clip_thick-frame_thick/2,0,0])
            {
                //short side
                rotate([0,45,0])
                {   
                    cube([frame_thick,clip_wide,frame_thick],center=true);
                }
            }
            translate([200,clip_wide/2,0])
            {
                //other sides
                rotate([45,0,0])
                {   
                    cube([clip_wide,frame_thick,frame_thick],center=true);
                }
            }
            translate([200,-clip_wide/2,0])
            {
                //other sides
                rotate([45,0,0])
                {   
                    cube([clip_wide,frame_thick,frame_thick],center=true);
                }
            }
        }
    }
}
//clip();

translate([-150,20,0]) clip();
translate([-250,20,0]) clip();

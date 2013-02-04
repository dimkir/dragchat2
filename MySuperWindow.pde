/*
 This is window shows bouncing ball.
 It extends 'MyDraggableWindow' and this is why it appears in draggable window. 
 Draggable

*/

class MySuperWindow extends MyDraggableWindow
//implements IWordHolder
{
     MySuperWindow(float x, float y , float w, float h , Component prnt){
         super(x, y, w, h, prnt);
         
         location = new PVector(getW() / 2, getH() /2);
         
         //setRestrictDraggingToParent(true); // this is method should restrict moving to the box of the parent component(window)
     }
     
     private PVector location;
     private float radius = 20;
     float vx = 1.0;
     float vy = 1.0;
     
     
     @Override
     void updateMyself(){
         location.x += vx;
         location.y += vy;
         if ( location.x > getW() || location.x < 0){
            vx *= -1;
         }
         
         if ( location.y > getH() || location.y < 0){
            vy *= -1;
         }
     }
     
     @Override
     void draw(){
         super.draw();
         // here custom draw happens
         // what about call to translate????
         pushMatrix();
         translate(getX(), getY());
         ellipse(location.x, location.y, radius * 2, radius * 2);
         
         popMatrix();
         
         text("this is custom draw", getX(), getY() );
     }
}

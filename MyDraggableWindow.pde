/*
 How to make window draggable here?, but to be able to handle clicks as well.
*/

class MyDraggableWindow extends MyWindowWithMouseEvents
{
  
  
  
  
  
    MyDraggableWindow(float x, float y , float w, float h, Component prnt){
        super(x, y, w, h, prnt);
    }
    
    
    boolean mCapturedByMouse = false; // when this is true, then we handle 
                                      // move events and update position of the 
                                      // window accordingly
                                      
    boolean mIsMovingWindow = false;                                      
    float mMouseXOffset = -1;        // these offsets allow us to drag the window by the 'grabbing point'
    float mMouseYOffset = -1;
    int mCapturedMillis = -1;
    int mClickMillisDelay = 200; // waits 200 milliseconds before entering dragging state    
    
    @Override
    boolean onMousePressed(InputEvent evt){
        
        if ( !eventWithinBoxAbsolute(evt) ){
            return false; // not consuming event, not within us.
        }
        if ( mCapturedByMouse ){
            println("One more mouse pressed during one mouse already presed, ignoring");
            return false; // don't know what to put here.
        }
        // that's all variable setting on the mouse pressed
            mCapturedByMouse = true;
            mCapturedMillis = millis();
            mMouseXOffset = evt.getX() - getAbsoluteX();
            mMouseYOffset = evt.getY() - getAbsoluteY();
            return true;
    }
    
    
    @Override
    boolean onMouseMove(InputEvent evt){
        if ( ! mCapturedByMouse ){
            // if not captured by mouse, we don't care about mouseMove events
            return false;
        }
        
        
        if ( !mIsMovingWindow ){  // the delay has not passed yet, so we can still be doing the click
            int currTime = millis();
            int diff = currTime - mCapturedMillis;
            if ( diff > mClickMillisDelay ){
                mIsMovingWindow = true;
            }
        }        
        // update window
        // unless, we're waiting for it to be a click
        // what's the difference between a drag and click?
        // click:
        // mouseDown
        //     maybe some movement due to mouse jerking
        
        // quick release after short delay (if it is draggable object, non draggable objects like button, may wait forever until the 
        //         button is released ABOVE the button)
        
        // quick release ABOVE the window
        if ( mIsMovingWindow ){
            return onWindowMove(evt); // passing mouseMove event when it applies to window move
        }
        
        return true; // we consume the event as we follow the window
      
    }
    
    @Override 
    boolean onMouseReleased(InputEvent evt){
        if ( !mCapturedByMouse ){
            println("Some strange unaccounted mouse release");
            return false; 
        }
        
        if ( mIsMovingWindow ){
            // reset vars, moving window is dropped
            mCapturedByMouse = false;
            mIsMovingWindow = false;
            return true;  // we consume event, as we have released the window after move.
            
        }
        else{
            // this is click
            mCapturedByMouse = false;
            // click should happen in the rectangle of the window
            float xx = evt.getX();
            float yy = evt.getY();
            
            if ( hasAbsolutePoint(xx,yy) ){
                return onMouseClick(evt); // mouseRelease event
            } 
            else{
                println("Mouse was released outside of window: "+ this.toString() );
                return false; // the click was outside the window, but we still have to 
                //consume wevent as this is reaction to the fact that mCapturedByMouse was true.
            }
                        
        }
    }
    
    
//    @Override
//    void draw(){
//        pushMatrix();
//        translate(getX(), getY());
//            rect(0,0,getW(), getH());            
//            super.draw();
//        popMatrix();
//    }
    
    @Override
    void drawMyself(){
        rect(0,0,getW(), getH());
    }
    
    
    boolean onMouseClick(InputEvent mouseReleaseEvent){
        println("mouseClick happend");
        return true;
    }
    
    
    /*
    This one doesn't work yet.
  
    boolean onMouseLongClick(){
    }
    */    
    
    boolean onWindowMove(InputEvent mouseMoveEvent){
        float xx = mouseMoveEvent.getX() - mMouseXOffset;
        float yy = mouseMoveEvent.getY() - mMouseYOffset;
        setX(xx);
        setY(yy);
        return true;
    }
    
}

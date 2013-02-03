interface IOnSwipeListener {
     void onSwipe(Component comp, SwipeEvent swipeEvent);
}

/*
 This is class which contains data about the swipe.
*/
class SwipeEvent{
    private PVector mSwipeVelocity;
    private Component mComp;
    // PVector is velocity of the swipe
    SwipeEvent(Component comp, PVector velocity){
        mComp = comp;
        mSwipeVelocity = velocity;
    }
    
    PVector getSwipeVelocity(){
        return mSwipeVelocity;
    }
}

//
// remember, maybe I want to swipe what's INSIDE the window with the swipe
//
class SwipeableWindow extends MyWindowWithMouseEvents
{
    IOnSwipeListener mSwipeListener;
    

    MouseVector prevPos  = new MouseVector(0,0);    
    MouseVector curPos   = new MouseVector(0,0);
    
    private boolean mBehaviourFollowMouse = true; // behavor which tells window to follow mouse on grab.
    private boolean mFollowMouseMovement = false; // flag which tells if he's following mouse movement now
    private boolean mListeningToTheMouseMovement = false; // this is when we listen to mouse movement
    

    
    void setOnSwipeListener(IOnSwipeListener listener){
        mSwipeListener = listener;
    }
    
    //  true for drag&slide
    //  false for scroll within the image
    void setBehaviourFollowMouse(boolean behaviourFollowMouse){
        mBehaviourFollowMouse = behaviourFollowMouse;
    }
    

// ###################################################################################
// #########    mouse events, no need to super(), as they're dummies in superclass ###
// ###################################################################################
   
   @Override
   boolean onMouseMove(InputEvent evt){
       if ( !mListeningToTheMouseMovement){
           // this means the event is not for us, some other window (remember because we listen to GLOBAL mouse move)
           return false;
       }
       prevPos.setMouseClick( evt, millis() );
         
       if ( mFollowMouseMovement ){
           advance position to the mouse position
       }
       return false;
   }
   
   @Override
   boolean onMousePressed(InputEvent evt){
       if ( mListeningToTheMouseMovement ){
         return false; // got another click whilst listening to the previous one, ignore it.
       }

       // let's save coords
       mListeningToTheMouseMovement = true;
       prevPos.setMouseClick( evt, millis() );
       
       // how do we distinguish click from swipe?
       // click starts and ends at almost the same spot, within n milliseconds.
       // swipe can take same amount of time, but(!) it will aways end up far away
       println("Mouse pressed");
       
       
       return true;     
   }
   
   @Override
   boolean onMouseReleased(InputEvent evt){
      if ( !mListeningToTheMouseMovement ){
          println("Got mouseRelease without preceding mousePressed");
          return false; // don't consume this event. (Remember we listen to GLOBAL mouse released. This is why it is imporant to filter out the events don't belong to us
      }
      //   get distance of release
      // kinda we should calculate the speed of the swipe before the release. But how to do that?
      // technically speed = distance / time; if we assume that time here is 1, then we can assume that speed = distance. At least in this 'buggy' verison
      // this may work.
      // okay, here's the logic:
      // we're having 25 - 50 frames per second on my laptop. Which means each iteration takes approx: 40-20 milliseconds.
      // thus we can take last two available points, and calculate the distance and divide it by milliseconds.
      curPos.setMouseClick( evt, millis() );
      
      PVector velocity = curPos.getMouseMoveVelocity(prevPos);
      
      fireSwipeEvent(velocity);  // as the swipe event is an internal event (only applies to this window, we don't have to 
                                  // 'consume' it. As 'consumation' applies on passing events to other sibling windows. Whereas
                                  // in our case 
      return true; // now we consume event (as we are)     
   }
   

    // From here swipe seems to be a very 'local' event, which applies only to the window where it started.    
    protected void fireSwipeEvent(PVector velocity){
        if ( mSwipeListener == null ){
             return; 
        }
        
        mSwipeListener.onSwipe( this, new SwipeEvent(this, velocity) );
    }
}

class MouseVector extends PVector
{
    int mMillis;
    PVector mLocation = new PVector(0.0, 0.0);
    PVector(float x, float y)
    {
        super(x, y);
    }
    
    void setMouseClick(InputEvent evt , int vMillis){
        mMillis = vMillis;
        mLocation.x = evt.getX();
        mLocation.y = evt.getY();        
    }
    
    PVector getMouseMoveVelocity(MouseVector prevLoc){
        PVector vel = PVector.sub(mLocation, prevLoc);
        int timeLapse = getMillis() - prevLoc.getMillis();
        vel.div(timeLapse); // velocity per millisecond
        return vel;
    }
    
    int getMillis(){
        return mMillis;
    }
    
    
}

class MouseSpeedMeasurer
{
}

/*
  This is how swipe window super class may look like. 
  Remember to turn on swipe reaction via setCatchSwipes()
*/

class MySwipeWindow extends SwipeableWindow
{
    PVector mSwipeSpeed = new PVector(0,0,0);
    boolean mAnimateMove = false;
    
    MySwipeListener mMySwipeListener = new MySwipeListener(); //inner class
     
  
    MySwipeWindow(float x, float y, float w, float h, Component prnt)
    {
          super(x, y , w, h ,prnt);
          // TODO: need to decide if we need CatchSwipes or not
          //setCatchSwipes(true); // obviously catching swipes and drags is not compatible. Or at least we won't make it compatible for siplicity now.
          setOnSwipeListener(mMySwipeListener);
    }
    
    @Override
    void drawMyself(){
        fill(#0000FF);
        rect(0,0, getW(), getH(), 10);
    }
    
    
    @Override
    void updateMyself(){
//        println("runnign update myself");
//        throw new RuntimeException("Running MySwipeWindow");
        
        
        if ( mAnimateMove) {
              if ( mSwipeSpeed.mag() < 5){
                  mAnimateMove = false;
              }
              else{
                setX(getX() + mSwipeSpeed.x);
                setY(getY() + mSwipeSpeed.y);
                mSwipeSpeed.mult(0.8); // decreasing speed by 20% each time.
              }   
             
        }
    }//void updateMyself()
 

//  I put methods for catching swipe here, so they stay in one class.
//  
// 
  class MySwipeListener 
  implements IOnSwipeListener  
  {
      void onSwipe(Component cmp, SwipeEvent swipeEvent){
          if ( swipeEvent.isFastSwipeToSide() ){
              mSwipeSpeed.set(swipeEvent.getSwipeVelocity());
              mAnimateMove = true;
              return;
          }
          println("got swipe event, but it is not too fast");
      }
  }
    
    
    
}

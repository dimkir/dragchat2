/*
  This is how swipe window super class may look like. 
  Remember to turn on swipe reaction via setCatchSwipes()
*/

class MySwipeWindow extends SwipeableWindow
{
    PVector swipeSpeed = new PVector(0,0);
    boolean mAnimateMove = false;
    
    MySwipeListener mMySwipeListener = new MySwipeListener(); //inner class
     
  
    MySwipeWindow(float x, float y, float w, float h, Component prnt)
    {
          super(x, y , w, h ,prnt);
          setCatchSwipes(true); // obviously catching swipes and drags is not compatible. Or at least we won't make it compatible for siplicity now.
          setOnSwipeListener(mMySwipeListener());
    }
    
    @Override
    void updateMyself(){
        println("runnign update myself");
        throw new RuntimeException("Running MySwipeWindow");
        
        
        if ( mAnimateMove) {
              if ( swipeSpeed.equals(0.0, 0.0) {
                  mAnimateMove = false;
              }
              else{
                setX(getX() + swipeSpeed.x);
                setY(getY() + swipeSpeed.y);
                swipeSpeed.decreaseBySomeValue(0.2,0.2); // ?? need to fix this
              }   
             
        }
    }//void updateMyself()
 
 
 

//  I put methods for catching swipe here, so they stay in one class.
//  
// 
  class MySwipeListener 
  implements IOnSwipeListener  
  {
      boolean onSwipe(Component cmp, SwipeEvent swipeEvent){
          if ( swipeEvent.isFastSwipeToSide() ){
              mSwipeSpeed.set(swipeEvent.getSwipeSpeed);
              mAnimateMove = true;
              return true;
          }
          println("got swipe event, but it is not too fast");
          return false; // we don't consume it          
      }
  }
    
    
    
}

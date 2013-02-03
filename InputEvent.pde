class InputEvent{
  public static final int EVT_MOUSE_PRESSED = 1;
  public static final int EVT_MOUSE_RELEASED = 2;
  public static final int EVT_KEY_PRESSED = 3;
  public static final int EVT_MOUSE_MOVE = 4;
/*  public static final int EVT_MOUSE_CLICK = ;
  public static final int EVT_MOUSE_CLICK = ;
  */
  
  
  // mouse button
  private int mMouseButton;
  
  // click coordinates
  private float mX;
  private float mY;
  
  
  // mouse Move PREVious coordinates
  private float mPrevX;
  private float mPrevY;
  

  private int mKey;
  private int mKeyCode;

  
  private int mEvent = -1;
  
  float getX(){
      // TODO: add throw 'InvalidState' or smth exception when trying to getX() for the keyboard event
     return mX;
  }
  float getY(){
// TODO: add throw 'InvalidState' or smth exception when trying to getX() for the keyboard event    
     return mY;
  }
  
  float getPrevX(){
    // TODO: add throw 'InvalidState' or smth exception when trying to getX() for the keyboard event
     return mPrevX;
  }
  
  float getPrevY(){
    // TODO: add throw 'InvalidState' or smth exception when trying to getX() for the keyboard event
      return mPrevY;
  }
  
  /*
    Creates events for the xxx
  */
  InputEvent(int EVT, float x, float y, int vMouseButton){
      mEvent = EVT;
      mX = x;
      mY = y;
      mMouseButton  = vMouseButton;
    
  }
  
  InputEvent(int EVT, char key_,  int keyCode_){
      mEvent = EVT;
      mKey = key_;
      mKeyCode = keyCode_;
    
  }
  
  InputEvent(int EVT, float newX, float newY, float prevX, float prevY){
      mEvent = EVT;
      mX = newX;
      mY = newY;
      mPrevX = prevX;
      mPrevY = prevY;
  }
  
  
  @Override
  String toString(){
      switch( mEvent ){
          case EVT_MOUSE_PRESSED:
              return "EVT_MOUSE_PRESSED (" + mX + ", " + mY + ")";
          case EVT_MOUSE_RELEASED:
              return "EVT_MOUSE_RELEASED (" + mX + ", " + mY + ")";
          default:
              return "EVT_UNDEFINED or unregistered with toString()";
      }
  }
  
  boolean isMousePressedEvent(){
      return (mEvent == EVT_MOUSE_PRESSED);
  }
  
  boolean isMouseReleasedEvent(){
      return (mEvent == EVT_MOUSE_RELEASED);
  }
  
  int getType(){
      return mEvent;
  }

}





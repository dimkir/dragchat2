

/*
  As this is not simple 'draggable' window, but window which contains the word data, and 
  it implements IWordHolder interface so that it can hold 
*/
class MyWindow extends Component
 implements EventListener, IWordHolder
{
   private static final int C_WINDOW_ROUND_EDGE_RADIUS = 5;
  
    boolean mFollowMouse = false;
    float   mMouseOffsetX = 0.0;
    float   mMouseOffsetY = 0.0;
    
    String  mWindowTitle = "Default title";

    // DATA WHICH IS DISPLAYED BY WINDOW    
            boolean mDisplayTranslation = false;
            String  mWord = "WORD";
            String  mTranslation = "TRANSLATION";
            String  mContents = mWord;
            
            int     mClickCount = 0;
    

    // this object is to receive updates about window movements    
    IMotionTrafficController mMovementController;
    

    MyCircle mCircle;
    
    
    private static final int C_WINDOW_HANDLE_HEIGHT = 20;
    private static final int C_WINDOW_CIRCLE_RADIUS = 15;    

    MyWindow(float x,  float y , float w , float h, Component prnt){
         super(x, y , w, h, prnt);
         setEventListener(InputEvent.EVT_MOUSE_PRESSED, this);
         setEventListener(InputEvent.EVT_MOUSE_RELEASED, this);
         
         mCircle = new MyCircle(this, C_WINDOW_CIRCLE_RADIUS);
         
         addChild(mCircle);
         
         mCircle.setEventListener(InputEvent.EVT_MOUSE_PRESSED, new EventListener(){
             boolean onEvent(Component component, InputEvent evt){
                 // circle receives event
                 println("***************mCirlce of window ["+ mWord +"] received event: " + evt );
                 Thread.dumpStack();
                 if ( component.hasAbsolutePoint(evt.getX(), evt.getY() ) ){
                     println("##############Clicked inside of the circle");
                     mCircle.switchFill();  
                     MyWindow.this.setVisible(false);         
                     return true; // consume event
                 }
                 return false;
             }
         });
    }

    void setTranslations(String[] wordTranslationPair){
        mWord = wordTranslationPair[0];
        initSound(mWord);
        mTranslation = wordTranslationPair[1];
        // we swich them twice to make sure effect is on
          switchWords(); 
          switchWords();
    }    
    
    // '''''''''''''''''''''' audio
    AudioPlayer mSound;
    private void initSound(String foreignWord){
        
        mSound = minim.loadFile(phraseToFilename(foreignWord), 2048);
        
        
    }
    
    private String phraseToFilename(String foreignPhrase){
        //return "sounds/komme_hjem.mp3";
        // TODO
        String s;
        try{
        s = "sounds/" + URLEncoder.encode(
                            foreignPhrase.trim().replace(' ','_'), 
                                    "UTF-8"
                                          ) + ".mp3";
         
            println("Sound file: [" + s + "]");
        }
        catch (UnsupportedEncodingException uex){
            println(uex.getMessage());
            s = "sounds/komme_hjem.mp3";
        }
        return s;
    } 
    
    /*
        Plays one if it is available
    */
    private void playSound(){
        // TODO:
       if (mSound != null){
           mSound.play();
           mSound.rewind();
       } 
    }
    
    private void switchWords(){
        mDisplayTranslation = !mDisplayTranslation;
        if ( mDisplayTranslation ){
           mContents = mTranslation;   
        }
        else{
           mContents = mWord;
        }
    }    
    
    /*
      Interface on Event. This is method which receives registered events
    */
    boolean onEvent(Component cnt, InputEvent evt){
      println("MyWindow ["+ mWord +"]" + getCoordString() +  "received REGISTERED event " + evt.toString() );
      
      if ( evt.isMousePressedEvent() ){
           return onMousePressed(evt);
      }
      else if ( evt.isMouseReleasedEvent() ){
          return onMouseReleased(evt);
      }
      println("MyWindow received event " + evt.toString() );
      return false;
        
    }    
    
    
    /*
      On mouse pressed
    */    
    private boolean onMousePressed(InputEvent evt){
//        if ( MOUSE_IS_IN_COORDINATES_OF_CURRENT_COMPONENT) {
      if ( 
            hasPoint(   evt.getX(), evt.getY()      
                    ) 
         )
         {
              playSound();
              switchWords();
              mClickCount++;
              mMouseOffsetX = evt.getX() - getX();
              mMouseOffsetY = evt.getY() - getY();
              
              mFollowMouse = true;
              // set also the 'drag' point.
              return true;
         }
      return false; // we don't consume event
    }
    
    /*
      On GLOBAL mouse released
    */
    private boolean onMouseReleased(InputEvent evt){
        if ( mFollowMouse ){
            updateDropControllerAboutDrop();
            mFollowMouse = false;
            return true; // now we consumed the event
        }
        return false; // we don't consume the event
    }
    
    private void updateDropControllerAboutDrop(){
        if ( mMovementController == null){
          return;
        }
        mMovementController.updateDrop(this, new ComponentDropEvent(this, getAbsoluteX(), getAbsoluteY() ));
    }
    
    
    /*
      Is called by update() when mouse needs to be follows
    */
    private void updateFollowMouse(){
      if  ( mFollowMouse ){
          float nX = mouseX - mMouseOffsetX;
          float nY =mouseY - mMouseOffsetY;  
          if ( mMovementController != null ){
              ComponentMotionEvent cme = new ComponentMotionEvent(this, nX, nY);
              mMovementController.updateMovement(this, cme);
          }
          setX( nX );
          setY( nY ) ;
      }
    }
  
    void drawMyself(){
        // here we can draw window background
              if ( mDisplayTranslation ){
                fill(#FFFF00);
              }
              else{
                fill(#FF0000);
              }
              
              //rect(getX(), getY(), getW(), getH(), C_WINDOW_ROUND_EDGE_RADIUS);
              rect(0,0, getW(), getH(), C_WINDOW_ROUND_EDGE_RADIUS);
        
        // window handle
              drawWindowHandle();
      
        // window text  
              fill(#0000FF);
              textAlign(CENTER, CENTER);
              textSize(52);
              text(mContents + " " + mClickCount, getW() / 2, getH() /2);
    }

//  draws handle over the window
//    
    private void drawWindowHandle(){
          fill(#00FF00);
          //rect( getX(), getY() - C_WINDOW_HANDLE_HEIGHT,  getW(), C_WINDOW_HANDLE_HEIGHT);
          rect(0, 0 - C_WINDOW_HANDLE_HEIGHT, getW(), C_WINDOW_HANDLE_HEIGHT);
          
          textAlign(LEFT, BOTTOM);
          textSize(20);
          fill(255);
          //text(mWindowTitle, getX(), getY());
          text(mWindowTitle, 0, 0);
    }
    
   
    
    @Override
    void updateMyself(){
        updateFollowMouse();
    }
    
    
    void registerMovementController(IMotionTrafficController contr){
          mMovementController = contr;
      
    }
    
    
//  ###################################################################    
//  ##################IWORDHODLER interface implementation ############
//  ###################################################################
    
    String getCurrentWord(){
        return mContents;
    }
    
    String getForeignWord(){
        return mWord;
    }
    
    String getNativeWord(){
        return mTranslation;
    }
}

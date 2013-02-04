class MyDesktop extends Component
implements IMotionTrafficController
{
    
    MyWindow window;
    PImage mBackgroundImage;
    
    private static final int C_LABEL_PADDING = 10;
  
    MyDesktop(float x, float y, float w, float h){
        super(x, y , w, h, null); // null parent, as it is desktop
        window = new MyWindow(10, 10, 500, 200, this); // last parameter is parent, which is this dekstop
        addChild(window);

        onCreate();
    }
    
    
    void onCreate(){
    }
    
    @Override // abstract    
    void drawMyself(){
              drawBackgroundImage();
              
              fill(128,50);
              //rect(getX(), getY(), getW(), getH() );
              rect(0, 0, getW(), getH() );
          
              String txt = "this is desktop";
              textAlign(RIGHT, BOTTOM);
              text("this is desktop. framerate: " + round(frameRate), getW() - textWidth(txt) - C_LABEL_PADDING, getH() - C_LABEL_PADDING);
    }
    
//    @Override
//    void draw(){
//        pushMatrix();
//        translate(getX(), getY());
//        
//              drawBackgroundImage();
//              
//              fill(128,50);
//              //rect(getX(), getY(), getW(), getH() );
//              rect(0, 0, getW(), getH() );
//          
//              String txt = "this is desktop";
//              textAlign(RIGHT, BOTTOM);
//              text("this is desktop. framerate: " + round(frameRate), getW() - textWidth(txt) - C_LABEL_PADDING, getH() - C_LABEL_PADDING);
//          
//              super.draw();
//              
//        popMatrix();
//    }


    private void drawBackgroundImage(){
        if (mBackgroundImage != null){
            tint(255,88);
            image(mBackgroundImage, 0, 0, getW(), getH());
        }
    }

//   #######################################################################
//   ################motion traffic controller #############################
//   #######################################################################
    ArrayList<IComponentMotionListener> mMotionListeners = new ArrayList<IComponentMotionListener>();


    void  registerMotionListener(IComponentMotionListener motListener){
          // adds motion listeners to the list
          if ( !mMotionListeners.contains(motListener) ){
              mMotionListeners.add(motListener);
          }
          else{
              println("Warning: The motion listener " + motListener + " is already in the list");
          }
          
          
    }
    
    void unregisterMotionListener(IComponentMotionListener motListener){
        // removes motion listeners from the list
        if ( mMotionListeners.contains(motListener) ){
            mMotionListeners.remove(motListener);
        }
    }
    
    
    /*
      This is called by windows which want to update this parent view on their motion events
    */
    void updateMovement(Component cmp, ComponentMotionEvent cmEvt){
        // passes through the list of motion listeners and updates them with the motion
        IComponentMotionListener ml;
        for (int i = 0 ; i < mMotionListeners.size(); i++){
            
            
            ml = mMotionListeners.get(i);
            //println( "MyDesktop:: updateMovement:: found motionListener: " + ml );
            
            if ( ml.onComponentMotion(cmp,  cmEvt) ){
                println("MyDesktop::ComponentMotionController::updateMovement(): one of the events was consumed, stopped loop of events");
                // just for debugging this println
                break; // we stop if he consumes event

            }
        }
    }





    
    void setBackgroundImage(PImage img){
        mBackgroundImage = img;
    }


    ArrayList<IComponentDropListener> mDropListeners = new ArrayList<IComponentDropListener>();

    void registerDropListener(IComponentDropListener dropListener){
        if ( !mDropListeners.contains(dropListener) ){
            mDropListeners.add(dropListener);
        }
        else{
               println("Warning: The drop listener " + dropListener + " is already in the list");
        }
    }


    void unregisterDropListener(IComponentDropListener dropListener){
        if ( mDropListeners.contains(dropListener) ){
            mDropListeners.remove(dropListener);
        }
        else{
            println("WARNING: dropListener " + dropListener + " is not registerd. Cannot delete");
        }
    }
    
    
    /*
      Updates all the listeners with the drop event
    */
    void updateDrop(Component cmp, ComponentDropEvent devt){
        IComponentDropListener listener;
        for (int i = 0 ; i< mDropListeners.size() ; i++){
            listener = mDropListeners.get(i);
            if ( listener.onComponentDrop(cmp, devt) ){
                break; // if consumed event, then we stop iterating
            }
        }
    }
    
    
    @Override
    void updateMyself(){
    }
    
}





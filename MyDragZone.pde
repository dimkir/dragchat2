/*
  This is zone which is able to receive objects.
*/

class MyDragZone extends Component
implements IComponentMotionListener, IComponentDropListener
{
      
   private IMotionTrafficController mMotionController;
   private float mGridHeight = 32; // should be proportional to the text Font size
   private float mGridSpace = mGridHeight * 0.25;
   private float mNextX = 0;
   private float mNextY = 0;
   
  
   private ArrayList<String> mWordForGrid = new ArrayList<String>();
   private String mTransparentWord; 
   
   MyDragZone(float x , float y , float w , float h, IMotionTrafficController motController, Component prnt){
       super(x, y , w, h, prnt);
       
       mMotionController = motController;
       mMotionController.registerMotionListener(this);
       mMotionController.registerDropListener(this);
       
       // we add here some words just for the sake to see how they're rendered.
       String sentence = ""; //"Min søster må gjøre litt husarbeid Min søster må gjøre litt husarbeid Min søster må gjøre litt husarbeid";
       String[] words = sentence.split("\\s");
       println(words);
       for(String ww : words){
         mWordForGrid.add(ww);
       }
       
   }    
  
  
  @Override
  void drawMyself(){
           // background color and frame
           fill(0x1100FF00);
           rect(0, 0, getW(), getH(), 10);
           //rect(getX(), getY(), getW(), getH(), 10);
           drawWordGrid();    
  }  
  
  
//   @Override
//   void draw(){
//       pushMatrix();
//       translate(getX(), getY());
//           // background color and frame
//           fill(0x1100FF00);
//           rect(0, 0, getW(), getH(), 10);
//           //rect(getX(), getY(), getW(), getH(), 10);
//           drawWordGrid();
//           super.draw();
//       popMatrix();
//   }
   
   
   /*
      
   */
   private void drawWordGrid(){
        fill(#FF0000);
       float nextX = 0;
       float nextY = 0;   
       textSize(mGridHeight); 
       float wth =0;
       String word;
       fill(#550000); // text color: marron
       for(int i = 0 ; i <= mWordForGrid.size() ; i++){
           if ( i == mWordForGrid.size() ){
              if ( mTransparentWord != null){
                
                word = mTransparentWord;
                mTransparentWord = null;
                fill(#FF0000);
              }
              else{
                break;
              }  
           }
           else{
              word = mWordForGrid.get(i);
           }
           
           wth = textWidth(word);
           if ( nextX + wth >  getW() ){
               nextY += mGridHeight;
               nextX = 0;
           }
           drawWordAtNextGridPosition(word, nextX, nextY, wth);
           nextX += wth + mGridSpace;
       }
       mNextX = nextX;
       mNextY = nextY;
   }
   
   
   void drawWordAtNextGridPosition(String wrd, float nextX, float nextY, float wth){
        // TODO wouldn't wrap word at end
//            fill(#FF0000);
//            rect(nextX, nextY, wth, mGridHeight);
        //fill(#550000);
        textAlign(LEFT, TOP);
        text(wrd, nextX, nextY);
   }
   
   
   
   boolean onComponentDrop(Component comp, ComponentDropEvent evt){
       // we cast the component to have 'ForeignWord' interface
       
       
       if ( !hasAbsolutePoint(evt.getAbsX(), evt.getAbsY()) ){
           return false; // we don't consume event
       }
       
       IWordHolder wordholder = (IWordHolder) comp;
       
       
       // get word and add it to the grid
       String word = wordholder.getForeignWord(); 
       mWordForGrid.add(word);
       
       // hide component.
       comp.setVisible(false);
       return true; // we consumed event
       
   }
   
//
//   
//   
   boolean onComponentMotion(Component comp, ComponentMotionEvent evt){
       //Thread.dumpStack();
       //println("objectMoved()::   Object: " + comp + " has moved and event is :" + evt);
       line(getCenterX(), getCenterY(), evt.getMotionX(), evt.getMotionY() );
       String word = ((IWordHolder) comp).getForeignWord();
       mTransparentWord = word;
       
       /*
       textSize(mGridHeight);
       textAlign(LEFT, TOP);
       float w = textWidth(word);
       // somehow this tends to  work outside of draw(), thus without the translate
             // 
                 pushMatrix();
                 translate(getAbsoluteX(), getAbsoluteY());
                     fill(#FF0000); // red
                     drawWordAtNextGridPosition(word, mNextX, mNextY, w); // draw word at the next position
                      
                     
                     //text(word, getCenterX(), getCenterY());
                     rect(0,0, w, 10);
                 popMatrix();
              */
       return true; // we don't consume events
   }
   
   
   @Override
   void updateMyself(){
     
   }

}



/*
  What is drag text model? is it just a text? Or is it more? 
  We'll put text to separete class, 'cos we have to submit it later. We could have also
  kept it as par of DragZone as a field and make methods for dragzone, but we 
  ll seperate it in stanalone class for easier passing as parameter.
  Also we may implement methods to reorder the text. Or maybe it will contain the coordinates as well of the
  text.
  
*/
class MyDragZoneTextModel
{
     /*
       Used to wrap strings and keep extra info about them
     */
     private class StringWrapper{
        private String mS;
        StringWrapper(String s){
            mS = s;
        }
        
        void addParameter(String kkey, String vvalue){
            // TODO:
        }
        
        @Override
        String toString(){
           return mS;
        }
        
     }
    
    
    
      // ################ DATA OF THE MODEL #################
      ArrayList<StringWrapper> mParts = new ArrayList<StringWrapper>();
      /* How do we init text model?
      */  
      
     MyDragZoneTextModel(){
         
     }
     
     /*
       Null is not valid parameter so that we explicitly 
     */
     MyDragZoneTextModel(String[] phrases){
        if ( phrases == null){
            throw new NullPointerException("Cannot use this constructor with null value");
        }
        
        for(String s : phrases){
            mParts.add(new StringWrapper(s));
        }
        
        
     } 
         
     @Override
     String toString(){
         StringBuilder b = new StringBuilder();
         for(int i = 0 ; i < mParts.size(); i++){
             if ( i != 0 ) {
                 b.append(' ');
             }
             b.append(mParts.get(i));
         }
         return b.toString();
     }
}

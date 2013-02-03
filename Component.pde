/*
  Component is a rect area on the screen which can be updated and drawn and can recieve events (provided it implements interface).
  It also has chidlern Components (as inherited by the Container class)
*/

abstract class Component extends Container
{
    float mX, mY;
    float mW, mH;
    
    Component mParent;
    
    HashMap<Integer, EventListener> mEvent2ListenerMap = new HashMap<Integer, EventListener>();


    Component(float x, float y, float w, float h, Component parent){
       mX = x;
       mY = y;
       mW = w;
       mH = h;
       mParent = parent;
    }
    
    
    Component getPrnt(){
        return mParent;
    }
    
    
    float getX(){
        return mX; 
    }
    
    float getY(){
        return mY;
    }
    
    // can't use getWidth() as this method is somehow already usedi n processing
    float getW(){
      return mW;
    }
    
    float getH(){
        return mH;
    }
    
    float getCenterX(){
        return getX() + getW() / 2;
    }
    
    float getCenterY(){
        return getY() + getH() / 2;
    }
    
    float getBBoxRight(){
        return mX + mW;
    }
    
    float getBBoxBottom(){
        return mY + mH;
    }
  
    /*
      Checks point is within rectangle (but using relative coordinates?)
    */
    boolean hasPoint(float x , float y){

        boolean ret = false;
//        if ( x >= getX() && x <= getBBoxRight() ){
//            if ( y >= getY()  && y <= getBBoxBottom() ){
//                ret =  true;
//            }
//        }

        ret = rectangleHasPoint(x, y , getX(), getY(), getBBoxRight(), getBBoxBottom() );
        
        println("Component:(" + getCoordString() + ") :hasPoint(" + x + ", " + y + ") = " + ret );        
        return ret;
    }  
  
  
    // ######################################################################  
    // ####################### ABSOLUTE COORDINATE FUNCTIONS ################
    // ######################################################################    
    float getAbsoluteX(){
          Component pr = getPrnt();
          if ( pr != null){
              return pr.getAbsoluteX() + getX();
          }
          else{
              return getX(); // let's say it is dektop, thus the parent is null. So we just return getX() as it is the screen pos
          }
    }
    
    float getAbsoluteY(){
          Component pr = getPrnt();
          if ( pr != null ){
            return pr.getAbsoluteY() + getY();
          }
          else{
              return getY(); // this is say desktop (no parent). thus we already have screen coords         
          }
    }
    
    
    
    boolean hasAbsolutePoint(float x, float y){
          float aX = getAbsoluteX();
          float aY = getAbsoluteY();
        
          return rectangleHasPoint(x, y, 
                                    aX, aY, aX + getW(), aY + getH()
                                   ); 
      
    }
  
  
    // returns if the point is held within the rectangle
    protected boolean rectangleHasPoint(float x, float y,
                                         float x0, float y0,
                                          float x1 , float y1)
     {
//        if ( x >= getX() && x <= getBBoxRight() ){
//            if ( y >= getY()  && y <= getBBoxBottom() ){
//                ret =  true;
//            }
//        }
//                   
 
        boolean ret = false;
        
        if ( x >= x0 && x <= x1 ){
            if ( y >= y0  && y <= y1 ){
                ret =  true;
            }
        }
        println("rectangleHasPoint( ---x:" + x + ", y:" + y + "x:[" + x0 + ".." + x1 + "], y:[" + y0 + ".." + y1 + "] = " + ret);
        return ret;               
     }
     
     
     
    
    void setX(float x){
      mX = x;
    }
  
    void setY(float y){
         mY = y;
    }  
    
    void setWidth(float w ){
        mW = w;
    }
    
    void setHeight(float h){
        mH = h;
    }
    
//  listener can be zero if we wnat to get rid of it  
    void setEventListener(int eventType, EventListener listener){
        if ( listener == null ){
            if ( mEvent2ListenerMap.containsKey(eventType) ){
                mEvent2ListenerMap.remove(eventType);
            }
        }
        else{
            mEvent2ListenerMap.put(eventType, listener);
        }
    }
    

    // TODO: this method
//  this method handles event by the component itself (may it have no children)
    // returns true if consumed
    boolean handleInputEventMyself(InputEvent evt){
        //println("\n\n Component::handleInputEventMyself(" + evt );
        
        
        // if no event registered - return false
        // if event registered : return what the event is returning
        int evtType = evt.getType();
        if ( mEvent2ListenerMap.containsKey(evtType) ){
             EventListener listener = mEvent2ListenerMap.get(evtType);
             return listener.onEvent(this, evt);
        }
        return false;
    }    
    
    String getCoordString(){
        return "(" + getX() + ", "+ getY() +")";
    }
      
      
    
    boolean eventWithinBoxAbsolute(InputEvent evt){ // should be only mouse event or other event with coordinates
        float xx = evt.getX();
        float yy = evt.getY();
        return hasAbsolutePoint(xx,yy) ;
    }
          
      
}

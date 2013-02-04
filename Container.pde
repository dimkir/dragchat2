/*
  Adds container related functionality
  Basically just a collection class. 
*/

abstract class Container
{
  
    private boolean mIsVisible = true;
  
    private ArrayList<Container> mChildren = new ArrayList<Container>();


    void setVisible(boolean isVisible){
        mIsVisible = isVisible;
    }
    
    boolean isVisible(){
        return mIsVisible;
    }

  
    void addChild(Container container){
        mChildren.add(container);
    }

    void removeChild(Container container){
        // TODO: don't know if this one can create problem once child is removed whilst there's still loop over children.
        if ( mChildren.contains(container) ){
          mChildren.remove(container);
        }
    }    

  
    // should be abstract, as Container doesn't have GetX() GetY() and this is why cannot perform  'translate' operation
    abstract void draw(); 
    
    
    private void updateChildren(){
        Container[] children = getChildren();
        if (children != null){
            for (int i = 0 ; i < children.length ; i++){
                children[i].update();
             }
        }
    }
  
  
    protected void drawChildren(){
        Container[] children = getChildren();
        if (children != null){
            for (int i = 0 ; i < children.length ; i++){
                if ( children[i].isVisible() ){
                    children[i].draw();
                }
             }
        }
    }
    

    /*
        Makes copy of children
    */    
    Container[] getChildren(){
        if (mChildren.size() < 1 ){
            return null;
        }
        Container[] children = new Container[ mChildren.size() ];
        mChildren.toArray(children);
        return children;
    }
    
    
    // return:
    // should return true or false in case it consumed event or not.
    // the event will either be consumed by the Container, or unconsumed by anyone
    // will fall off the top of the chain
    boolean handleInputEvent(InputEvent evt){
         Container[]  children = getChildren();
         if ( children == null ){
           
             return handleInputEventMyself(evt);
         }
          
         for (int i = 0 ; i < children.length ; i++){
             if ( ! children[i].isVisible() ) continue;
             
             boolean consumed = children[i].handleInputEvent(evt);
             if ( consumed ){
                 return true;
             }
         }
         return handleInputEventMyself(evt);
    }


    
    void update(){
        updateMyself();
        updateChildren();
    }
    

    abstract void updateMyself();    
    
    abstract boolean handleInputEventMyself(InputEvent evt);
}

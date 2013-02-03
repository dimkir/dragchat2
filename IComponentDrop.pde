interface IComponentDropListener{
    boolean onComponentDrop(Component comp, ComponentDropEvent evt);
}


// now just placeholder
class ComponentDropEvent{
  private float mAbsX;
  private float mAbsY;
  private Component mComponent;
  
    ComponentDropEvent(Component comp, float absX, float absY){
       mComponent = comp;
       mAbsX = absX;
       mAbsY = absY;
    }
    
    
    Component getComponent(){
        return mComponent;
    }
    
    float getAbsX(){
        return mAbsX;
    }
    
    float getAbsY(){
        return mAbsY;
    }
    
}

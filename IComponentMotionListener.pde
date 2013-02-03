




interface IComponentMotionListener{
    // TRUE: if it consumes event, usually shouldn't be consuming event
    boolean onComponentMotion(Component comp, ComponentMotionEvent evt);
}



interface IMotionTrafficController{
      
    void registerMotionListener(IComponentMotionListener motListener);
    
    void unregisterMotionListener(IComponentMotionListener motListener);
    
    void updateMovement(Component cmp, ComponentMotionEvent mevt);
    
    
    void registerDropListener(IComponentDropListener dropListener);
    void unregisterDropListener(IComponentDropListener dropListener);
    
    void updateDrop(Component cmp, ComponentDropEvent devt);
    
}


class ComponentMotionEvent
{
    float mX, mY;
    Component mComponent;
    ComponentMotionEvent(Component com, float x , float y){
        mComponent = com;
        mX = x;
        mY = y;
    }
    
    float getMotionX(){
        return mX;
    }
    
    float getMotionY(){
        return mY;
    }
    
    Component getComponent(){
        return mComponent;
    }
      
}

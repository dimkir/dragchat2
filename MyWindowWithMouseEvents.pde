abstract class MyWindowWithMouseEvents extends Component
implements EventListener
{
   
   MyWindowWithMouseEvents(float x, float y, float w, float h, Component prnt){
       super(x,y , w, h, prnt);
       
       // register event handlers
         setEventListener(InputEvent.EVT_MOUSE_PRESSED, this);
         setEventListener(InputEvent.EVT_MOUSE_RELEASED, this);
         setEventListener(InputEvent.EVT_MOUSE_MOVE, this);
         setEventListener(InputEvent.EVT_KEY_PRESSED, this);
       
   }
   
   
   boolean onEvent(Component cnt, InputEvent evt){
       int evtType = evt.getType();
       switch (evtType){
           case InputEvent.EVT_MOUSE_PRESSED:
                 return onMousePressed(evt);

           case InputEvent.EVT_MOUSE_RELEASED:
                 return onMouseReleased(evt);

           case InputEvent.EVT_MOUSE_MOVE:
                 return onMouseMove(evt);

           case InputEvent.EVT_KEY_PRESSED:
                 return onMousePressed(evt);
                 
           default:
              throw new RuntimeException("Unregistered event happened: " + evt);
               
       }
   }
   
   @Override
   void updateMyself(){
       
   }
   

//   void drawMyself()
//   {
//        fill(255);
//        text("MyWindowWithMouseEvents::drawMyself(): NEEDS TO BE OVERRIDDEN", 0 , 0);
//   }

   boolean onMouseMove(InputEvent evt){
       return false;
   }
   
   boolean onMousePressed(InputEvent evt){
       println("Mouse pressed");
       return false;     
   }
   
   
   boolean onMouseReleased(InputEvent evt){
       return false;     
   }
   
   boolean onKeyPressed(InputEvent evt){
       return false;
   }
   
  
}

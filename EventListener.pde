
// This is interface which Components should implement, should they decide to listen to events.
// The component which implements this event should also implement it for it's children? 
//

interface EventListener{
   
   // or Container here?
   boolean onEvent(Component cnt, InputEvent evt);
  
}

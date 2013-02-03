void keyPressed(){
  // TODO: add the key
  myDesktop.handleInputEvent(new InputEvent(InputEvent.EVT_KEY_PRESSED, key, keyCode));
}


void mousePressed(){
   myDesktop.handleInputEvent(new InputEvent(InputEvent.EVT_MOUSE_PRESSED, mouseX, mouseY, mouseButton));
}

void mouseReleased(){
  println("Controller: mouseReleased");
  myDesktop.handleInputEvent(new InputEvent(InputEvent.EVT_MOUSE_RELEASED, mouseX, mouseY, mouseButton));  
}


void generateMouseMoveEvents(){
    if ( mouseX != prevMouseX || mouseY != prevMouseY ){
        myDesktop.handleInputEvent(new InputEvent(InputEvent.EVT_MOUSE_MOVE, mouseX, mouseY, prevMouseX, prevMouseY));
        prevMouseX = mouseX; // save them for next iteration
        prevMouseY = mouseY; // save them for next iteration
    }
    
}

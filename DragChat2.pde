import ddf.minim.*;
import java.net.URLEncoder;
import java.io.UnsupportedEncodingException;
import java.lang.RuntimeException;

MyMultiWindowDesktop myDesktop;

float prevMouseX = -1;
float prevMouseY = -1;

Minim minim;
AudioPlayer groove;

void draw(){
  background(255);
  generateMouseMoveEvents();
  myDesktop.update();
  myDesktop.draw();
  ellipse(mouseX, mouseY, 10,10);
  textSize(30);
  text("(" + mouseX + ", " + mouseY +")", mouseX, mouseY);
}



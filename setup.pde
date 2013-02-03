
void setup(){
    // Initilaize the sketch
    int C_SCR_WIDTH = 1200;
    int C_SCR_HEIGHT = 600;
    
    int C_WORD_COUNT = 3;
    
    int C_DESKTOP_PADDING = 10;  //padding between screen border and desktop borders around
    
//    int C_SCR_WIDTH = 800;
//    int C_SCR_HEIGHT = 600;


    size(C_SCR_WIDTH,C_SCR_HEIGHT);

    
    initFonts();

    WordSupplier norwegianWords = new WordSupplier("norwegian words 101 utf8 BOM.txt");
    norwegianWords.printPairs();
    
    minim = new Minim(this); // minim should be loaded before others, because it will be implicitly used by MyWindow
    groove = minim.loadFile("sounds/komme_hjem.mp3", 2048);
    groove.play();
    
    

    myDesktop = new MyMultiWindowDesktop( C_DESKTOP_PADDING, 
                                          C_DESKTOP_PADDING, 
                                          C_SCR_WIDTH - C_DESKTOP_PADDING * 2, 
                                          C_SCR_HEIGHT - C_DESKTOP_PADDING * 2,  
                                          norwegianWords, 
                                          C_WORD_COUNT
                                        );

    //setBackgroundImage(myDesktop);

    frameRate(24);
  
    // Choice of colors
    background(255);
    fill(255,102,0);
    stroke(0);
    
    
    //String[] list = PFont.list();
    //println(list);
    //initFonts();

    // Enable smoothing
    //smooth();
    
    
}

void initFonts(){
      PFont fnt = loadFont("28_Days_Later-52b.vlw");
      //textSize(64);
      textFont(fnt);
    //println(fnt);
    if ( fnt == null){
        println("Fnt is null");
    }
    else{
        println("Loaded font successfully");
        textFont(fnt);
    }
}      


void setBackgroundImage(MyDesktop dsk){
      PImage img = loadImage("united_colors.jpg");
    if ( img != null ){
        dsk.setBackgroundImage(img);
    }
    else{
        println("Error loading image");
    }    

}



void stop(){
    groove.close();
    minim.stop();
    super.stop();
}



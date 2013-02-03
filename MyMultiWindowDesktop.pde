class MyMultiWindowDesktop extends MyDesktop
{
    WordSupplier mWordSupplier;
    int          mWordCount;
    
    MyDragZone mDragZone;
    
    
    
    MyMultiWindowDesktop(float x, float y , float w , float h, WordSupplier ws, int wordCount){
        super(x, y, w, h);
        mWordSupplier = ws;
        mWordCount = wordCount;

        int PADDING = 20;
        int ZONE_WIDTH = (int) w  - PADDING * 2;
        int ZONE_HEIGHT = 200;
        mDragZone = new MyDragZone( PADDING, h - PADDING - ZONE_HEIGHT, ZONE_WIDTH, ZONE_HEIGHT, this, this); // last parameter is parent
        
        registerDropListener(mDragZone);
        
        
        
        
        addChild(mDragZone);
        
        
        // create mydwinowwevents
            Component prnt = this;
            MySuperWindow myWin = new MySuperWindow(100,100,500,100,prnt);
            addChild(myWin);
        
        
        createWindowsWithWords(); // and register movement controllers for these windows
    }
    


    void createWindowsWithWords(){
       // over here we can create other objects or windows
       MyWindow w1;
       String[] wordPair = new String[2];
       for (int i = 0 ; i < mWordCount ; i++){
           wordPair = mWordSupplier.nextPair(wordPair); // should get Initialized array of 2 elements here
           if (wordPair == null){
               println("Warning, ran out of words in the WordSupplier, breaking;");
               break;
           }           
           
           float maxTxtWidth = maxTextWidth(wordPair[0], wordPair[1]); 
           
           w1 = new MyWindow(50 + random(200) , 
                                  10 + random( 300),
                                  maxTxtWidth + 60,
                                  54,
                                  this);
           
           println(wordPair);
           w1.setTranslations(wordPair);
           addChild(w1);
                     // movement AND DROP controller
           w1.registerMovementController(this);    // this is to make sure that controller is receiving movements
           

       }
    }
    
    
    
    void setWordSupplier(WordSupplier ws){
        mWordSupplier = ws;
    }
    
    // it's a utility method
    private float maxTextWidth(String a, String b){
        
        float a_l  = textWidth(a);
        float b_l  = textWidth(b);
        float max =( a_l > b_l ) ? a_l : b_l;
        println("maxTextWidth(" + a + ", " + b + ") = " + max); 
         
        return max;  
    }
    

    
    
}

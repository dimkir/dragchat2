/*
  This class provides interface to load the words into memory from text file and access them.
  IMPORTANT! : reads from utf8 NOBOM files (if not then the first line will have the BOM-signagure)
*/
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.IOException;

class WordSupplier{
  
  ArrayList<String[]> mWordPairs;
  
  int mPointer = -1;
  
  
  WordSupplier(String textFileName){
     String sa = dataPath(textFileName);
     println(sa);
         /*
               try{
                String current = new java.io.File( ".").getCanonicalPath();
                println("CWD: " + current);
               }
               catch(IOException ioe){
                   println("Exception getting current dir:" + ioe.getMessage() );
               }
           */
      // open file
        mWordPairs =  readFileToMemory(dataPath(textFileName));
      
      
      // read words to memory (or actually if I keep the words in wordPair array already, then I don't have to   
    
  }


  void printPairs(){
      if ( mWordPairs == null){
          println("mWordPairs = null");
      }
      else{
          for(String[] pair : mWordPairs){
              println("Pair: \t\t" + pair[0] + " = " + pair[1]);
          }
      }
  }



  /*
    Returns either NULL (on end of list or on error)
    Or String[2].
    
    Doesn't have to use wordPairDest (but may)
  */  
  String[] nextPair(String[] wordPairDest){
      if ( mWordPairs == null ){
          return null;
      }
      

  
       // mPointer+1 is '1-based index of' cannot be larger or equal than the size
      if ( mPointer+1 >= mWordPairs.size() ){
          // we reached the end of the list
          return null;
      }
      
      
      mPointer++;
      
      return mWordPairs.get(mPointer);
  } 
  
  
  
  private ArrayList<String[]> readFileToMemory(String textFileName){
      ArrayList<String[]> listOfPairs = new ArrayList<String[]>();
       
      try{
          FileInputStream fis = new FileInputStream(textFileName);
          InputStreamReader in = new InputStreamReader(fis, "UTF-8");
          BufferedReader bur = new BufferedReader(in);
          String line;
          String[] parts;
          while (  ( line = bur.readLine() ) != null){
               parts = line.split("\\t+");
               if ( parts.length != 2 ){
                    println("received from file: [" + line + "]. Cannot split it into 2 parts, split into : " + parts.length );
                    continue;
               }
               listOfPairs.add(parts);
          }
          bur.close();
       }
       catch (IOException fex){
           println("Exception: " + fex.getMessage() );
           return null;
       }
       
        return listOfPairs;       
  }
  
}

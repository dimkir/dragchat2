//
// This is circle which will be drawin inside of the window. 
// It should handle clicks. How do we update them about the location?
//
class MyCircle extends Component
{
    
  private int mRadius;
  private static final int C_PADDING_RIGHT = 10;
  private static final int C_PADDING_TOP =  C_PADDING_RIGHT;
  
  
  private static final int C_FILL1 = #00FF00;
  private static final int C_FILL2 = #0000FF;
  
  private int mFill = C_FILL1;
  
  MyCircle(Component parent, int radius){
      //super(parent.getW() / 2, parent.getH() /2, radius * 2, radius * 2, parent);
      super(parent.getW()  - C_PADDING_RIGHT - radius * 2, 0 + C_PADDING_TOP, radius * 2, radius * 2, parent);
      // first we just draw in the center of the parent
//      setX( parent.getCenterX() );
//      setY( parent.getCenterY() );
      mRadius = radius;      
  }
  
  @Override
  void draw(){
      fill(mFill);
        // here we comment ellipse.
                //ellipse(getX() + mRadius, getY() + mRadius, mRadius * 2 , mRadius * 2);
                //fill(mFill, 100);
      rect(getX(), getY(), getW(), getH());
      // draw cross
        line(getX(), getBBoxBottom(), getBBoxRight() , getY() );
        line(getX(), getY()     ,  getBBoxRight() , getBBoxBottom() );
  }
  
  @Override
  boolean hasAbsolutePoint(float x, float y){
      // here we should calculate if the point is within the circle (not the rectangle), but 
      // maybe that's for the future
      return super.hasAbsolutePoint(x,y);
  }
  

  void switchFill(){
     mFill = (mFill == C_FILL1) ? C_FILL2 : C_FILL1;
  }
  
  @Override
  void updateMyself(){
  }
  
}

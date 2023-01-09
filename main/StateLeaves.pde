
class Leaves extends BaseState {
  
  Leaves() {
    super();
  }
  
  Leaves(StateMgr _stateMgr, int _duration) {
    super(_stateMgr, _duration); 
  }
  
  void draw() {
    fill(165,42,42);
    rect(0, 0, width, height);   
    
    //I guess thats Leaves?
    //if(osCompatible) drawPath(img2);

  }
}

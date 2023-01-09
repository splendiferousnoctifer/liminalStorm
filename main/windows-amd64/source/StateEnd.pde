class End extends BaseState {
  
  End() {
    super();
  }
  
  End(StateMgr _stateMgr, int _duration) {
    super(_stateMgr, _duration); 
  }
  
  void draw() {
    fill(200, 162, 200);
    rect(0, 0, width, height);
  }  
  
}

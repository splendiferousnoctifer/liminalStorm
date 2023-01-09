class Storm extends BaseState {
  
  Storm() {
    super();
  }
  
  Storm(StateMgr _stateMgr, int _duration) {
    super(_stateMgr, _duration); 
  }
  
  void draw() {
    fill(0, 0, 0);
    rect(0, 0, width, height);
  }  
  
}

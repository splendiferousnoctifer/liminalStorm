class StateA extends BaseState {
  
  StateA() {
    super();
  }
  
  StateA(StateMgr _stateMgr, int _duration, String _startFrame) {
    super(_stateMgr, _duration, _startFrame); 
  }
  
  void draw() {
    fill(255, 0, 0);
    rect(0, 0, width, height);
  }  
  
}

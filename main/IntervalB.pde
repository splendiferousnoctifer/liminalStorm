class StateB extends BaseState{
  
  StateB() {
    super();
  }
  
  StateB(StateMgr _stateMgr, int _duration, String _startFrame) {
    super(_stateMgr, _duration, _startFrame); 
  }
  
  void draw() {
    fill(0, 255, 0);
    rect(0, 0, width, height);    
  }
  
}


class StateC extends BaseState {
  
  StateC() {
    super();
  }
  
  StateC(StateMgr _stateMgr, int _duration, String _startFrame) {
    super(_stateMgr, _duration, _startFrame); 
  }
  
  void draw() {
    fill(0, 0, 255);
    rect(0, 0, width, height);    
  }

  // state transition from inside of state:
  // after 3 seconds, next state is A
  int getNextStateID() {
    if (stateMgr.getTimeInState() > 3000)
    {
      return idOfStateA; 
    }
    return super.getNextStateID();
  }  
  
  int idOfStateA;
}


class BaseState {
  
  BaseState() {
  }
  
  BaseState(StateMgr _stateMgr, int _duration) {
    stateMgr = _stateMgr;
    duration = _duration;
  }

  
  void setup() {
  }
  
  void draw() {
  }
  
  int getNextStateID() {
    return stateID;
  }
 
  void setID(int _stateID) {
    stateID = _stateID;
  }

  int getID() {
    return stateID;
  }
  
  void setStateMgr(StateMgr _stateMgr) {
    stateMgr = _stateMgr;
  }

  int stateID; 
  int duration;
  
  StateMgr stateMgr;
}

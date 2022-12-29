
class BaseState
{
  BaseState() {
  }
  
  BaseState(StateMgr _stateMgr, int _duration, String _startFrame) {
    stateMgr = _stateMgr;
    duration = _duration;
    startFrame = _startFrame;
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
  String startFrame;
  
  StateMgr stateMgr;
}

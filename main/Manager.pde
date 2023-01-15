class StateMgr {
 
  BaseState[] states;
  
  int currentStateID;
  int stateStamp;
  
  int setState(int newState) {
    if (newState < 0 || newState >= states.length) {
      return -1;
    }
  
    if (newState != currentStateID) {
      currentStateID = newState;
      stateStamp = millis();
      println("switch to state " + currentStateID);
    }
    
    return currentStateID;
  }
  
  BaseState getCurrentState() {
    return getState(currentStateID);
  }

  int getCurrentStateID() {
    return currentStateID;
  }
  
  BaseState getState(int stateID) {
   if (stateID < 0 || stateID >= states.length)
      return null;
    
    return states[stateID]; 
  }
  
  int getTimeInState() {
    return millis() - stateStamp;
  }
  
  int addState(BaseState state) {
    if (states == null) {
      println("creating new states array");
      states = new BaseState[1];
      states[0] = state;
    } else {
      states = (BaseState[])append(states, state);
    }
    
    state.setID(states.length - 1);
    state.setup();
      
    //println("state " + state.getID() + " added");
    
    return state.getID();
  } 
  
  int updateStates() {
    // query current state for next state id
    return setState(getCurrentState().getNextStateID());
  }
  
  void amountStates() {
    println(states.length);
  }
  
  int nextStateID(int currentID) {
    if (currentID < states.length) {
      return currentStateID + 1;
    }
    return states.length;
  }

  
}

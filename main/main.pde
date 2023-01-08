StateMgr stateMgr;
TimeSplit timeSplit;

int GRASS;
int RAIN;
int STORM;
int SNOW;
int LEAVES;

void setup() {
  timeSplit = new TimeSplit();
  noStroke();
  
  /*
  Here method for splitting time randomly, for now fixed amounts
  */
  
  int[] splitDurations = timeSplit.splitInterval();
  int[] numbers = timeSplit.assignNumbers(splitDurations);

  // Print the duration and number of each split
  for (int i = 0; i < splitDurations.length; i++) {
      System.out.println("Split " + numbers[i] + ": " + splitDurations[i] + " milliseconds");
  }
 
  
  stateMgr = new StateMgr();
  /*
  GRASS = stateMgr.addState(new StateA(stateMgr));
  RAIN = stateMgr.addState(new StateB(stateMgr));
  STORM = stateMgr.addState(new StateC(stateMgr));
  
  stateMgr.setState(GRASS);
  */
  
}

void draw() {
  /*
  stateMgr.getCurrentState().draw();
  stateMgr.updateStates();
  
  // state transition from application:
  // switch from state B to state A or C after 2 seconds (randomly)
  if (stateMgr.getCurrentStateID() == STATEB && stateMgr.getTimeInState() > 2000) {
    if (int (random(2)) == 0)
      stateMgr.setState(STATEA);
    else
      stateMgr.setState(STATEC);
      
  }
  */
}
/*
void stateOrder(String[] methodNames, int[] order) {
  for (int i : order) {
    String methodName = methodNames[i];
    if (methodName.equals("methodA")) {
      methodA();
    } else if (methodName.equals("methodB")) {
      methodB();
    } else if (methodName.equals("methodC")) {
      methodC();
    }
  }
}



void keyPressed() {
 
  switch(key)
  {
    case '1':
      stateMgr.setState(STATEA);
      break;
    case '2':
      stateMgr.setState(STATEB);
      break;
    case '3':
      stateMgr.setState(STATEC);
      break;
  }
} 
*/

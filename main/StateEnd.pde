class End extends BaseState {
  
  End() {
    super();
  }
  
  End(StateMgr _stateMgr, int _duration) {
    super(_stateMgr, _duration); 
  }
  
  void draw() {
    background(0, 0, 0);    
    fill(255);

    textSize(60);
    text("Liminal Storm", width/2, wallHeight/2);
    
    textSize(18);
    text("Rita Hainzl, Jessica Studwell, Samuel Zühlke", width/2, wallHeight/2 + 50);
   
  }  
  
}

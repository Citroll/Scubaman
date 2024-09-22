public State state;
public StateManager stateManager;

void setup() {
  size(1000, 600);
  noCursor();
  stateManager = new StateManager();
  stateManager.newGame();
}

void draw() {
  state.update();
}

void keyPressed() {
  state.processKeyPressed(key);
}

void keyReleased() {
  state.processKeyReleased(key);
}

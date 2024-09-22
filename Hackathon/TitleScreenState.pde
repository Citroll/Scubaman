class TitleScreenState implements State {
  TitleScreenState() {
  }

  void update() {
    background(0);
    fill(255);
    textSize(64);
    textAlign(CENTER, CENTER);
    text("Scuba-Man The Game\nPress 1 To Play", width/2, height/2);
  }

  void processKeyPressed(char k) {
    switch (k) {
    case '1':
      stateManager.pushState(new GameState());
      break;
    }
  }

  void processKeyReleased(char k) {
  }
}

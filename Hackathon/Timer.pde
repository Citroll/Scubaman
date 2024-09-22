class Timer {
  boolean active;
  int start;
  int elapsed;
  int elapsedPrev;
  int elapsedNew;
  int add;
  int cooldown;
  int paused;

  Timer(int add_) {
    active = true;
    start = millis();
    add = add_;
    cooldown = elapsed+add;
  }

  void update() {
    if (active) {
      elapsed = (millis() - start) - paused + elapsedPrev;
    } else {
      elapsedPrev = elapsed;
      paused = millis() - start;
    }
  }

  void display() {
    fill(255);
    textAlign(CENTER, TOP);
    textSize(48);
    text(elapsed/100, width/2, 0);
  }
}

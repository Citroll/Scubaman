class GameEndState implements State {
  PImage img;
  boolean imgSaved;
  int x;
  int y;

  GameEndState() {
    img = createImage(width, height, RGB);
    imgSaved = false;
    x = width/2;
    y = height/2;
  }

  void update() {
    if (!imgSaved) {
      loadPixels();
      img.pixels = pixels;
      imgSaved = true;
    }
    background(img);
    fill(255, 0, 0);
    stroke(0);
    strokeWeight(1);
    text("You Win!", x, y);
  }

  void processKeyPressed(char k) {
    background(img);
  }

  void processKeyReleased(char k) {
  }
}

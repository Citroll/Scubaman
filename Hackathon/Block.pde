class Block {
  PImage img;
  String type;
  float x;
  float y;
  color col;
  final float size = 25;
  
  Block(String _type, float initial_x, float initial_y) {
    x = initial_x * size + size/2;
    y = initial_y * size + size/2;
    type = _type;
    switch (type) {
      case "WALL":
        col = color(92, 64, 51);
        img = loadImage("stone.jpg");
        break;
      case "CORAL":
        col = color(255, 127, 80);
        img = loadImage("coral.jpg");
        break;
      case "SEAMINE":
        col = color(255, 0, 0);
        img = loadImage("mine.png");
        break;
      case "EXIT":
        col = color(150, 128, 128);
        break;
      case "END":
        col = color(255);
        break;
    }
  }
  
  void display() {
    if (img != null) {
      imageMode(CENTER);
      image(img, x, y, size+1, size+1);
    } else {
      fill(col);
      rect(x,y,size+1,size+1);
    }
  }
}

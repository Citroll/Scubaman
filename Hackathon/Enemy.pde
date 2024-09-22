class Enemy {
  PImage img;
  int hp;
  int direction = 1;
  float x;
  float y;
  float starting_x;
  float starting_y;
  float distance_x;
  float distance_y;
  float angle;
  float velocity_x;
  float velocity_y;

  Player target;
  final float radius = 25;
  final float speed = 2;
  final float aggro_range = 150;
  final float damage_range = 10;

  Enemy(float _starting_x, float _starting_y, Player _target) {
    starting_x = _starting_x;
    starting_y = _starting_y;
    x = starting_x;
    y = starting_y;
    hp = 3;
    target = _target;
    img = loadImage("enemy.png");
    img.resize(50,50);
  }

  void display() {
    pushMatrix();
    translate(x - 25 * direction, y - 25);
    scale(direction, 1);
    imageMode(CORNER);
    image(img, 0, 0);
    popMatrix();
  }

  void update() {
    if (dist(x, y, target.x, target.y + height/2) > aggro_range) return;
    distance_x = target.x - x;
    distance_y = target.y + height/2 - y;
    angle = atan2(distance_y, distance_x);
    velocity_x = speed * cos(angle);
    velocity_y = speed * sin(angle);
  }

  void move() {
    if (dist(x, y, target.x, target.y + height/2) > aggro_range) return;
    if (x < target.x) {
      direction = 1;
    } else {
      direction = -1;
    }
    x += velocity_x;
    y += velocity_y;
  }
}

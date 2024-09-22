class Projectile {
  PImage img;
  float x;
  float y;
  float direction_x;
  float timer;
  boolean done = false;
  final float speed = 10;
  final float radius = 15;
  
  Projectile(float _x, float _y, float _direction_x) {
    x = _x;
    y = _y;
    direction_x = _direction_x;
    img = loadImage("spear.png");
  }
  
  void travel() {
    x += direction_x * speed;
    timer += 1;
    if (timer >= 30)
      done = true;
    fill(0, 255, 0);
    circle(x, y, radius);
    pushMatrix();
    translate(x, y);
    scale(direction_x * 0.1, 0.1);
    imageMode(CENTER);
    image(img, 0, 0);
    popMatrix();
  }
  
  void hit_enemies(ArrayList<Enemy> enemies) {
     for (int i = enemies.size() - 1; i >= 0; i--) {
      Enemy enemy = enemies.get(i);
      if (dist(x, y, enemy.x, enemy.y) < radius) {
        enemies.remove(i);
      }
    }
  }
}

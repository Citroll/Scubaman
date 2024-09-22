class Player {
  final float speed = 3;
  final float gravity = 1;
  final float radius = 25;
  final float cooldown = 15;
  PImage img;
  int hp;
  float x;
  float y;
  float direction_x;
  float direction_y;
  float velocity_x;
  float velocity_y;
  float last_direction = 1;
  float reload = cooldown;
  ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
  
  Player(float initial_x, float initial_y) {
    x = initial_x;
    y = initial_y;
    hp = 3;
    velocity_y = gravity;
    img = loadImage("suba.png");
    img.resize(50,50);
  }
  
  void display() {
    reload += 1;
    x += velocity_x;
    y += velocity_y;
    pushMatrix();
    translate(x - 25 * last_direction, height/2 - 25);
    scale(last_direction, 1);
    imageMode(CORNER);
    image(img, 0, 0);
    popMatrix();
  }
  
  void handle_input(char input, boolean pressed) {
    if (pressed) {
      switch (input) {
        case 'a':
          direction_x = -1;
          last_direction = -1;
          break;
        case 'd':
          direction_x = 1;
          last_direction = 1;
          break;
        case 'w':
          direction_y = -1;
          break;
        case ' ':
          if (reload >= cooldown) {
            projectiles.add(new Projectile(x, y + height/2, last_direction));
            reload = 0;
          }
          break;
      }
    } else {
      if (input == 'a' || input == 'd')
        direction_x = 0;
      if (input == 'w') {
        direction_y = 0;
      }
    }
    
  }
  
  void handle_movement() {
    velocity_x = direction_x * speed;
    velocity_y = direction_y * speed + gravity;
  }
  
  void handle_projectiles(ArrayList<Enemy> enemies) {
    for (int i = projectiles.size() - 1; i >= 0; i--) {
      Projectile projectile = projectiles.get(i);
      projectile.travel();
      projectile.hit_enemies(enemies);
      if (projectile.done) {
        projectiles.remove(i);
      }
    }
  }
}

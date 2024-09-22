class GameState implements State {
  Player player;
  PImage bg;
  ArrayList<Block> blocks = new ArrayList<Block>();
  ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  Timer score;
  
  GameState() {
    player = new Player(width/5, -250);
    //enemies.add(new Enemy(width/2, 450, player));
    //enemies.add(new Enemy(width/2, 750, player));
    //enemies.add(new Enemy(width/2, 1050, player));
    readLevel(levels[levelCount]);
    bg = loadImage("underwater.jpg");
    bg.resize(1000, 600);
    score = new Timer(0);
  }

  void update() {
    background(bg);
    pushMatrix();
    translate(0, -player.y);
    displayBlocks();
    for (Enemy enemy : enemies) {
      enemy.update();
      handle_enemy_collision(enemy);
      enemy.display();
    }
    player.handle_projectiles(enemies);
    popMatrix();
    player.handle_movement();
    handle_player_collision();
    player.display();
    score.update();
    score.display();
  }

  void readLevel(String[] level) {
    noStroke();
    for (int y=0; y<level.length; y++) {
      for (int x=0; x<level[y].length(); x++) {
        switch (level[y].charAt(x)) {
        case '#':
          blocks.add(new Block("WALL", x, y));
          break;
        case 'W':
          blocks.add(new Block("CORAL", x, y));
          break;
        case 'X':
          blocks.add(new Block("SEAMINE", x, y));
          break;
        case '@':
          blocks.add(new Block("EXIT", x, y));
          break;
        case 'E':
          enemies.add(new Enemy(x * 25, y * 25, player));
          break;
        case '*':
          blocks.add(new Block("END", x, y));
          break;
        }
      }
    }
  }

  void displayBlocks() {
    for (int i = 0; i<blocks.size(); i++) {
      blocks.get(i).display();
    }
  }

  void handle_player_collision() {
    for(int i = 0; i<blocks.size(); i++) {
      Block block = blocks.get(i);
      float halfSize = block.size / 2;
      if (player.x + player.velocity_x > (block.x - halfSize) && player.x + player.velocity_x < (block.x + halfSize)
          && player.y + height/2 >= (block.y - halfSize) && player.y + height/2 <= (block.y + halfSize)) {
        checkBlock(block, 'x', halfSize);
      }
      if (player.x >= (block.x - halfSize) && player.x <= (block.x + halfSize)
          && player.y + height/2 + player.velocity_y > (block.y - halfSize) && player.y + height/2 + player.velocity_y < (block.y + halfSize)) {
        checkBlock(block, 'y', halfSize);
      }
    }
  }

  void checkBlock(Block block, char position, float halfSize) {
    switch (block.type) {
    case "WALL":
      if (position == 'x') {
        player.velocity_x = 0;
      }
      if (position == 'y') {
        float direction_y = player.velocity_y / abs(player.velocity_y);
        player.y = block.y - (halfSize + 0.5) * (direction_y) - height/2;
        player.velocity_y = 0;
      }
      break;
    case "CORAL":
      reset();
      break;
    case "SEAMINE":
      reset();
      break;
    case "EXIT":
      levelCount++;
      blocks.clear();
      readLevel(levels[levelCount]);
      reset();
      break;
    case "END":
      stateManager.pushState(new GameEndState());
      break;
    }
  }

  void handle_enemy_collision(Enemy enemy) {
    for (Block block : blocks) {
      float halfSize = block.size / 2;
      if (enemy.x + enemy.velocity_x > (block.x - halfSize) && enemy.x + enemy.velocity_x < (block.x + halfSize)
        && enemy.y >= (block.y - halfSize) && enemy.y <= (block.y + halfSize)) {
        enemy.velocity_x = 0;
      }
      if (enemy.x > (block.x - halfSize) && enemy.x < (block.x + halfSize)
        && enemy.y + enemy.velocity_y >= (block.y - halfSize) && enemy.y + enemy.velocity_y <= (block.y + halfSize)) {
        enemy.velocity_y = 0;
      }
    }

    enemy.move();

    if (dist(enemy.x, enemy.y, enemy.target.x, enemy.target.y + height/2) > enemy.damage_range) return;
    reset();
  }

  void reset() {
    player.x = width/5;
    player.y = -250;
    for (Enemy enemy : enemies) {
      enemy.x = enemy.starting_x;
      enemy.y = enemy.starting_y;
    }
  }

  void processKeyPressed(char k) {
    player.handle_input(k, true);

    switch (k) {
    case 'r':
      reset();
      break;
    case 'q':
      stateManager.popState();
      break;
    }
  }

  void processKeyReleased(char k) {
    player.handle_input(k, false);
  }
}

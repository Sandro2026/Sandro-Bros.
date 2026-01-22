class FKoopa extends FGameObject {

  int direction = L;
  int speed = 50;
  int frame = 0;
  boolean inShell = false;
  boolean shellMoving = false;

  FKoopa(float x, float y) {
    super();
    setPosition(x, y);
    setName("koopa");
    setRotatable(false);
  }

  void act() {
    animate();
    collide();
    move();
  }

  void animate() {
    if (inShell) return;
    if (frame >= koopa.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(koopa[frame]);
      if (direction == L) attachImage(reverseImage(koopa[frame]));
      frame++;
    }
  }

  void collide() {
    if (isTouching("wall")) {
      direction *= -1;
      setPosition(getX() + direction, getY());
    }

    if (shellMoving) {
      if (itTouching(player.footSensor, "koopa")) {
        world.remove(this);
        enemies.remove(this);
        player.setVelocity(player.getVelocityX(), -300);
        return;
      } else if (isTouching("player")) {
        player.lives--;
        player.setPosition(0, 0);
        return;
      }
    }
    if (isTouching("player")) {
      if (itTouching(player.footSensor, "koopa")) {
        if (!inShell) {
          inShell = true;
          shellMoving = false;
          speed = 0;
          attachImage(shell);
          player.setVelocity(player.getVelocityX(), -300);
          return;
        }
        if (inShell && !shellMoving) {
          world.remove(this);
          enemies.remove(this);
          player.setVelocity(player.getVelocityX(), -300);
          return;
        }
      }
      if (inShell && !shellMoving) {
        shellMoving = true;
        direction = (player.getX() < getX()) ? R : L;
        speed = 300;
        return;
      }
      if (!inShell) {
        player.lives--;
        player.setPosition(player.spawnX, player.spawnY);
      }
    }
    if (shellMoving && isTouching("wall")) {
      direction *= -1;
    }
  }

  void move() {
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);
  }
}

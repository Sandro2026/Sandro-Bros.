class FShell extends FGameObject {

  int direction = 0;
  int speed = 300;
  boolean isMoving = false;

  FShell(float x, float y) {
    super();
    setPosition(x, y);
    setName("shell");
    setRotatable(false);
    attachImage(shell);
    setFriction(0);
    setRestitution(0);
  }

  void act() {
    move();
    collide();
  }

  void move() {
    if (isMoving) {
      setVelocity(speed * direction, getVelocityY());
    } else {
      setVelocity(0, getVelocityY());
    }
  }

  void collide() {
    if (isTouching("wall") || isTouching("stone") || isTouching("ice") || isTouching("bridge")) {
      if (isMoving) direction *= -1;
    }

    if (isTouching("goomba") || isTouching("koopa") || isTouching("hammerbro")) {
      for (int i = enemies.size()-1; i >= 0; i--) {
        FGameObject e = enemies.get(i);
        if (isTouching(e.getName())) {
          world.remove(e);
          world.remove(e);
        }

        if (isTouching("player")) {
          if (itTouching(player.footSensor, "shell")) {
            world.remove(this);
            enemies.remove(this);
            player.setVelocity(player.getVelocityX(), -300);
            return;
          } else if (isMoving) {
            player.lives--;
            player.setPosition(0, 0);
          } else {
            direction = (player.getX() < getX()) ? 1: -1;
            isMoving = true;
          }
        }
      }
    }
  }
}

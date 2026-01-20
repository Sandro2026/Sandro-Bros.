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
    
    //setStatic(false);
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

    if (isTouching("player")) {
      float px = player.getX();
      float pyBottom = player.getY() + gridSize/2;
      float shellTop = getY() - gridSize/2;

      if (pyBottom < shellTop + 5) {
        if (!isMoving) {
          direction = (px < getX()) ? 1 : -1;
          isMoving = true;
        }
        player.setVelocity(player.getVelocityX(), -300);
      }
      else {
        if (isMoving) {
          player.lives--;
          player.setPosition(0, 0);
        } else {
          direction = (px < getX()) ? 1 : -1;
          isMoving = true;
        }
      }
    }
  }
}

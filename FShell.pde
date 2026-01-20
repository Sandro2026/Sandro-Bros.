class FShell extends FGameObject {

  int direction = 0;     // -1 left, 1 right
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

    // Bounce off walls
    if (isTouching("wall") || isTouching("stone") || isTouching("ice") || isTouching("bridge")) {
      if (isMoving) direction *= -1;
    }

    // Player interaction
    if (isTouching("player")) {

      float px = player.getX();
      float pyBottom = player.getY() + gridSize/2;
      float shellTop = getY() - gridSize/2;

      // Player jumped on shell
      if (pyBottom < shellTop + 5) {

        // Kick shell if stationary
        if (!isMoving) {
          direction = (px < getX()) ? 1 : -1;
          isMoving = true;
        }

        // Bounce player
        player.setVelocity(player.getVelocityX(), -300);
      }

      // Player hit shell from side
      else {
        if (isMoving) {
          // Moving shell hurts player
          player.lives--;
          player.setPosition(0, 0);
        } else {
          // Stationary shell gets kicked
          direction = (px < getX()) ? 1 : -1;
          isMoving = true;
        }
      }
    }
  }
}

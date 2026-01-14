class FThwomp extends FGameObject {

  boolean activated = false;
  float triggerRange = gridSize / 2;
  float startX, startY;

  FThwomp(float x, float y) {
    super();
    startX = x;
    startY = y;

    setPosition(x, y);
    setName("thwomp");
    setStatic(true);
    attachImage(thwomp[0]);
  }

  void act() {
    animate();
    checkTrigger();
    checkReset();
    collide();
  }

  void animate() {
    if (activated) attachImage(thwomp[1]);
    else attachImage(thwomp[0]);
  }

  void checkTrigger() {
    if (activated) return;

    float px = player.getX();
    float py = player.getY();

    boolean under =
      abs(px - getX()) < triggerRange &&
      py > getY();

    if (under) {
      activated = true;
      setStatic(false); // fall
    }
  }

  void checkReset() {
    // player back at spawn?
    if (player.getX() == 0 && player.getY() == 0 && activated) {
      activated = false;
      setStatic(true);
      setVelocity(0, 0);
      setPosition(startX, startY);
    }
  }

  void collide() {
    if (isTouching("player")) {
      player.lives--;
      player.setPosition(0, 0);
    }
  }
}

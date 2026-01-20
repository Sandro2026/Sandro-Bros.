class FPlayer extends FGameObject {

  int frame;
  int direction;
  int lives;
  boolean touchground;

  boolean canShootIce = false;
  int iceTimer = 0;
  int iceCooldown = 20;
  int lastIceShot = -100;

  boolean canShootPlasma = false;
  int plasmaTimer = 0;
  int lastPlasmaShot = -100;
  int plasmaCooldown = 20;

  boolean invincible = false;
  int invincibleTimer = 0;
  int blinkFrequency = 5;
  boolean visible = true;


  FBox footSensor;
  FBox headSensor;

  FPlayer() {
    super();
    frame = 0;
    lives = 3;
    direction = R;
    setPosition(0, 0);
    setName("player");
    setRotatable(false);
    setFillColor(red);

    footSensor = new FBox(gridSize - 10, 10);
    footSensor.setStaticBody(false);
    footSensor.setSensor(true);
    footSensor.setName("footSensor");
    footSensor.setNoStroke();
    footSensor.setFill(255, 0);
    world.add(footSensor);

    headSensor = new FBox(gridSize - 10, 10);
    headSensor.setStaticBody(false);
    headSensor.setSensor(true);
    headSensor.setName("headSensor");
    headSensor.setNoStroke();
    headSensor.setFill(255, 0);
    world.add(headSensor);
  }

  void act() {
    input();
    collisions();
    animate();

    if (invincible) {
      if (frameCount > invincibleTimer) {
        invincible = false;
        visible = true;
      } else if (frameCount % blinkFrequency == 0) {
        visible = !visible;
      }
    }

    if (canShootIce && frameCount > iceTimer) {
      canShootIce = false;
    }

    if (canShootPlasma && frameCount > plasmaTimer) {
      canShootPlasma = false;
    }

    footSensor.setPosition(player.getX(), player.getY() + 12);
    footSensor.setVelocity(player.getVelocityX(), player.getVelocityY());

    headSensor.setPosition(player.getX(), player.getY()-14);
    headSensor.setVelocity(player.getVelocityX(), player.getVelocityY());

    touchground = false;
    if (itTouching(footSensor, "stone") || itTouching(footSensor, "ice") || itTouching(footSensor, "wall") || itTouching(footSensor, "bridge") || itTouching(footSensor, "spring") || itTouching(footSensor, "treetop")) {
      touchground = true;
    }
  }

  void animate() {
    if (frame >= action.length) frame = 0;
    if (invincible && (frameCount / 5) % 2 == 0) {
      return; 
    }
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(action[frame]);
      if (direction == L) attachImage(reverseImage(action[frame]));
      frame++;
    }
  }

  void input() {
    float vy = getVelocityY();
    float vx = getVelocityX();
    if (abs(vy) < 0.1) {
      action = idle;
    }
    if (akey) {
      setVelocity(-200, vy);
      action = run;
      direction = L;
    }
    if (dkey) {
      setVelocity(200, vy);
      action = run;
      direction = R;
    }
    if (wkey && touchground ) {
      setVelocity(vx, -550);
      touchground = false;
    }
    if (abs(vy) > 0.1)
      action = jump;

    if (canShootIce && spacekey && frameCount - lastIceShot >= iceCooldown) {
      lastIceShot = frameCount;
      spawnIceBall(getX(), getY(), direction);
    }
    if (canShootPlasma && qkey) {
      lastPlasmaShot = frameCount;
      spawnPlasmaBall(getX(), getY(), direction);
    }
  }


  void collisions() {
    if (itTouching(footSensor, "spike")) {
      lives--;
      setPosition (0, 0);
    }
    if (itTouching(footSensor, "lava")) {
      lives--;
      setPosition(0, 0);
    }
    for (int i = powerUps.size() - 1; i >= 0; i--) {
      FGameObject p = powerUps.get(i);

      if (itTouching(footSensor, p.getName()) || itTouching(headSensor, p.getName())) {

        if (p.getName().equals("powerUpIce")) {
          canShootIce = true;
          iceTimer = frameCount + 600;
          lastIceShot = frameCount - iceCooldown - 1;
        }
        if (p.getName().equals("pwrUpPlasma")) {
          canShootPlasma = true;
          plasmaTimer = frameCount + 600;
          lastPlasmaShot = frameCount - plasmaCooldown - 1;
        }
        if (p.getName().equals("mushroom")) {
          invincible = true;
          invincibleTimer = frameCount + 600;
        }
        world.remove(p);
        powerUps.remove(i);
      }
    }
  }
}

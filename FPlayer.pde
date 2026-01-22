class FPlayer extends FGameObject {

  float spawnX;
  float spawnY;
  float ogSpawnX;
  float ogSpawnY;
  int frame;
  int direction;
  int lives;
  boolean touchground;
  boolean canShootIce = false;
  int iceTimer = 0;
  int iceCooldown = 20;
  int lastIceShot = -100;
  int numberOfJumps;
  int maxJumps = 2;
  boolean wasWPressed = false;
  boolean canShootPlasma = false;
  int plasmaTimer = 0;
  int lastPlasmaShot = -100;
  int plasmaCooldown = 20;

  int portalCooldown = 0;


  FBox footSensor;
  FBox headSensor;

  FPlayer() {
    super(gridSize - 1, gridSize);
    frame = 0;
    lives = 3;
    direction = R;
    setPosition(32, 282);
    numberOfJumps = maxJumps;
    spawnX = getX();
    spawnY = getY();
    ogSpawnX = spawnX;
    ogSpawnY = spawnY;

    setName("player");
    setRotatable(false);
    setFillColor(red);

    footSensor = new FBox(gridSize-10, 10);
    footSensor.setStaticBody(false);
    footSensor.setSensor(true);
    footSensor.setName("footSensor");
    footSensor.setNoStroke();
    footSensor.setFill(255, 0);
    world.add(footSensor);

    headSensor = new FBox(gridSize-10, 10);
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


    if (canShootIce && frameCount > iceTimer) {
      canShootIce = false;
    }

    if (canShootPlasma && frameCount > plasmaTimer) {
      canShootPlasma = false;
    }

    if (portalCooldown > 0) portalCooldown--;


    footSensor.setPosition(player.getX(), player.getY()+12);
    footSensor.setVelocity(player.getVelocityX(), player.getVelocityY());

    headSensor.setPosition(player.getX(), player.getY()-14);
    headSensor.setVelocity(player.getVelocityX(), player.getVelocityY());

    touchground = false;
    if (itTouching(footSensor, "stone") || itTouching(footSensor, "ice") || itTouching(footSensor, "wall") || itTouching(footSensor, "bridge") || itTouching(footSensor, "spring") || itTouching(footSensor, "treetop") || itTouching(footSensor, "dirt")) {
      touchground = true;
    }
    if (touchground) {
      numberOfJumps = maxJumps;
    }
  }

  void animate() {
    if (frame >= action.length) frame = 0;
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
    if (wkey && numberOfJumps > 0) {
      setVelocity(vx, -550);
      numberOfJumps--;
    }
    wasWPressed = wkey;

    if (abs(vy) > 0.1)
      action = jump;

    if (canShootIce && spacekey && frameCount-lastIceShot >= iceCooldown) {
      lastIceShot = frameCount;
      spawnIceBall(getX(), getY(), direction);
    }

    if (canShootPlasma && qkey && frameCount-lastPlasmaShot >= plasmaCooldown) {
      lastPlasmaShot = frameCount;
      spawnPlasmaBall(getX(), getY(), direction);
    }
  }


  void collisions() {
    if (itTouching(footSensor, "shell")) {
      world.remove(this);
      enemies.remove(this);
      player.setVelocity(player.getVelocityX(), -300);
      return;
    }
    if (isTouching("flagPole")) {
      mode = GAMEWIN;
      return;
    }
    if (isTouching("hammer")) {
      player.lives--;
      player.setPosition(spawnX, spawnY);
    }
    if (itTouching(footSensor, "checkpoint")) {
      spawnX = getX();
      spawnY = getY();
    }
    if (itTouching(footSensor, "spike")) {
      lives--;
      setPosition (spawnX, spawnY);
    }
    if (itTouching(footSensor, "lava")) {
      lives--;
      setPosition(spawnX, spawnY);
    }
    for (int i = powerUps.size()-1; i >= 0; i--) {
      FGameObject p = powerUps.get(i);

      if (itTouching(footSensor, p.getName()) || itTouching(headSensor, p.getName())) {

        if (p.getName().equals("powerUpIce")) {
          canShootIce = true;
          iceTimer = frameCount+600;
          lastIceShot = frameCount-iceCooldown-1;
        }
        if (p.getName().equals("pwrUpPlasma")) {
          canShootPlasma = true;
          plasmaTimer = frameCount+600;
          lastPlasmaShot = frameCount-plasmaCooldown-1;
        }
        if (p.getName().equals("mushroom")) {
          lives++;
        }
        world.remove(p);
        powerUps.remove(i);
      }
    }
    if (itTouching(footSensor, "FPortals") && player.portalCooldown == 0) {
      player.setPosition(prtlE.getX(), prtlE.getY()-50);
      player.setVelocity(0, 0);
      player.portalCooldown = 500;
    }
    if (itTouching(footSensor, "FPortalE") && player.portalCooldown == 0) {
      player.setPosition(prtlI.getX(), prtlI.getY() -50);
      player.setVelocity(0, 0);
      player.portalCooldown = 500;
    }
  }
}

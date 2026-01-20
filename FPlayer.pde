class FPlayer extends FGameObject {

  int frame;
  int direction;
  int lives;
  boolean touchground;
  //int jumpC = 0;
  int maxJ = 2;

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
  }
}

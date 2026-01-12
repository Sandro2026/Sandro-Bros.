class FPlayer extends FGameObject {

  int frame;
  int direction;
  int lives;
  boolean touchground;
  

  FPlayer() {
    super();
    frame = 0;
    lives = 3;
    direction = R;
    setPosition(0, 0);
    setName("player");
    setRotatable(false);
    setFillColor(red);
  }

  void act() {
    input();
    collisions();
    animate();
    
    if (isTouching("stone") || isTouching("ice") || isTouching("wall") || isTouching("bridge") || isTouching("spring") || isTouching("treeIntersect") || isTouching("treeMiddle") || isTouching("treeEndEast") || isTouching("treeEndWest")) {
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
    if (isTouching("spike")) {
      setPosition (0, 0);
    }
  }
}

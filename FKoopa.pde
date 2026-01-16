class FKoopa extends FGameObject {

  int direction = L;
  int speed = 50;
  int frame = 0;

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
      setPosition(getX()+direction, getY());
    }
    if (isTouching("player")) {
      if (player.getY() < getY()-gridSize/2) {
        world.remove(this);
        enemies.remove(this);
        player.setVelocity(player.getVelocityX(), -300);
      } else {
        player.lives--;
        player.setPosition(0, 0);
      }
    }
  }

  void move() {
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);
  }
}

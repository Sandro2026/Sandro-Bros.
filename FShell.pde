//class FShell extends FGameObject {

//  boolean moving = false;
//  int direction = 0;
//  int speed = 250;

//  FShell(float x, float y) {
//    super();
//    setPosition(x, y);
//    setName("shell");
//    setStatic(false);
//    setFriction(0);
//    attachImage(shell);
//  }

//  void act() {
//    move();
//    collide();
//  }

//  void move() {
//    if (moving) {
//      setVelocity(speed * direction, getVelocityY());
//    }
//  }

//  void collide() {


//    if (isTouching("wall")) {
//      direction *= -1;
//    }


//    if (isTouching("player")) {

  
//      if (moving && player.getVelocityY() > 0 && player.getY() < getY()) {
//        world.remove(this);
//        enemies.remove(this);
//        return;
//      }

     
//      if (!moving) {
//        moving = true;
//        direction = random(1) < 0.5 ? L : R;
//      }

   
//      else {
//        player.lives--;
//        player.setPosition(0, 0);
//      }
//    }
//  }
//}

class FWater extends FGameObject {

  int frame = 0;
  int playerSpeed = 30;
  int delay;
  int lastUpdateTime;
  
  FWater(float x, float y) {
    super();
    setPosition(x, y);
    setName("water");
    setStatic(true);
    
    delay = int(random(20, 60));
    lastUpdateTime = frameCount;
  }

  void act() {
    animate();
  }

  void animate() {
    if (frameCount - lastUpdateTime >= delay) {
      attachImage(water[frame]);
      frame = (frame+1) % water.length;
      lastUpdateTime = frameCount;
    }
  }
}

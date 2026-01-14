class FLava extends FGameObject {

  int frame = 0;
  int delay;
  int lastUpdateTime;
  
  FLava(float x, float y) {
    super();
    setPosition(x, y);
    setName("lava");
    setStatic(true);
    
    delay = int(random(20, 60));
    lastUpdateTime = frameCount;
  }

  void act() {
    animate();
  }

  void animate() {
    if (frameCount - lastUpdateTime >= delay) {
      attachImage(lava[frame]);
      frame = (frame + 1) % lava.length;
      lastUpdateTime = frameCount;
    }
  }
}

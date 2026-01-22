class FCheckpoint extends FGameObject {

  FCheckpoint(float x, float y) {
    super(gridSize, gridSize);
    setPosition(x, y);
    setStatic(true);
    setSensor(true);
    setName("checkpoint");
    attachImage(savePB);
  }
}

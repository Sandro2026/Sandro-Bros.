class sensorBlock extends FGameObject {

  FBox invisibleBlock;

  sensorBlock() {
  invisibleBlock = new FBox(100, 100);
  invisibleBlock.setPosition(width/2, height/2);
  invisibleBlock.setDrawable(false); 
  world.add(invisibleBlock);
 }
}

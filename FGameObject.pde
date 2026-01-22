class FGameObject extends FBox {
  
  final int L = -1;
  final int R = 1;
    
  FGameObject() {
    super(gridSize, gridSize);
  }
  FGameObject(int w, int h) {
    super(w, h);
  }
  
  void act() {
    
  }
   boolean isTouching(String n) {
    ArrayList<FContact> contacts = getContacts();
    for (int i = 0; i < contacts.size(); i++) {
      FContact fc = contacts.get(i);
      if (fc.contains(n)) {
        return true;
      }
    }
    return false;
  }
  
  boolean itTouching(FBox s, String n) {
    ArrayList<FContact> cList = s.getContacts();
    for (FContact c : cList) {
      if (n.equals("floor")) {
        if (c.contains("stone") || c.contains("ice") ||  c.contains("wall") || c.contains("bridge") || c.contains("treetop") || c.contains("spring")) {
          return true;
        }
      } else if (c.contains(n)) {
        return true;
      }
    }
    return false;
  }
}

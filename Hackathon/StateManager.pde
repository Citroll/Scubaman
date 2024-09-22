class StateManager {
  private ArrayList<State> stack = new ArrayList();
  
  void newGame() {
    stack.clear();
    stack.add(new TitleScreenState());
    updateState();
  }
  
  private void updateState() {
    state = stack.get(topState());
  }
  
  private int topState() {
    return stack.size()-1;
  }
  
  void pushState(State s) {
    stack.add(s);
    updateState();
  }
  
  void popState() {
    stack.remove(topState());
    updateState();
  }
}

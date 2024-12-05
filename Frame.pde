class Frame {
  void draw() {
    displayBezel(10, 410, color(115, 109, 99));
    displayBezel(0, 400, color(20));
    controlsBezel(10, 430, 20, color(115, 109, 99));
    controlsBezel(0, 440, 30, color(20));
    knob();
  }

  void displayBezel(float xOffset, float yOffset, color colour) {
    fill(colour);
    beginShape();
    vertex(xStart-xOffset, panelHeight+xOffset);
    vertex(xStart-xOffset, yStart-yOffset);
    vertex(panelWidth+xOffset, yStart-yOffset);
    vertex(panelWidth+xOffset, panelHeight+xOffset);
    vertex(xStart-xOffset, panelHeight+xOffset);
    endShape();
    noFill();
  }

  void controlsBezel(float xOffset, float yOffset, float offset, color colour) {
    fill(colour);
    beginShape();
    vertex(xStart-xOffset, yStart-yOffset);
    vertex(xStart-xOffset, offset);
    vertex(panelWidth+xOffset, offset);
    vertex(panelWidth+xOffset, yStart-yOffset);
    vertex(xStart-xOffset, yStart-yOffset);
    endShape();
    noFill();
  }
  
  void knob(){
    float midPoint = dist(xStart, yStart-440, xStart, 30)/2;
    circle(panelWidth/2, midPoint+30, midPoint);
    line(panelWidth/2, midPoint+90, panelWidth/2, midPoint-30);
    line(panelWidth/2+60, midPoint+30, (panelWidth/2)-60, midPoint+30);
    // line(xStart, panelHeight-410, panelWidth, panelHeight-410);
  }
}

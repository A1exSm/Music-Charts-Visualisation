class Frame {
  float displayH = 400;
  Knob[] controls = {new Knob(0), new Knob(1), new Knob(2)};
  float[] controlsTheta = {(float) 360/24, (float) 360/12, (float) 360/15};


  void draw() {
    // draw display bezels
    drawBezel(10, yStart-(displayH+10), panelHeight+10, color(115, 109, 99));
    drawBezel(0, yStart-displayH, panelHeight, color(20));
    // draw controls bezels
    drawBezel(10, 20, yStart-(displayH+30), color(115, 109, 99)); // draws outer bezel
    drawBezel(0, 30, yStart-(displayH+40), color(20)); // draws inner bezel
    drawControls(0);
    drawControls(1);
    drawControls(2);
  }

  void drawControls(int index) {
    float[] pos = {0.25, 0.5, 0.75};
    pushMatrix();
    translate(xStart*pos[index]+panelWidth*pos[index], dist(xStart, yStart-400, xStart, 10)/2);
    controls[index].draw();
    popMatrix();
  }

  void drawBezel(float xOffset, float yOffset2, float yOffset1, color col) { // draws reactive bezels
    fill(col);
    beginShape();
    vertex(xStart-xOffset, yOffset1);
    vertex(xStart-xOffset, yOffset2);
    vertex(panelWidth+xOffset, yOffset2);
    vertex(panelWidth+xOffset, yOffset1);
    //vertex(xStart-xOffset, yOffset1);
    endShape(CLOSE); // using CLOSE automatically connects the last vertext to the first, :) you learn something new everyday
    noFill();
  }
}

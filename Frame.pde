class Frame {
  float displayH = 400;
  Knob one;

  Frame() {
    one = new Knob();
  }
  void draw() {
    // draw display bezels
    drawBezel(10, yStart-(displayH+10), panelHeight+10, color(115, 109, 99));
    drawBezel(0, yStart-displayH, panelHeight, color(20));
    // draw controls bezels
    drawBezel(10, 20, yStart-(displayH+30), color(115, 109, 99)); // draws outer bezel
    drawBezel(0, 30, yStart-(displayH+40), color(20)); // draws inner bezel
    pushMatrix();
    translate(xStart/2+panelWidth/2, dist(xStart, yStart-400, xStart, 10)/2);
    one.draw();
    turnKnob(one);
    popMatrix();
  }

  void turnKnob(Knob knob) {
    // x = radius * cos(theta)
    // y = radius * sin(theta)
    knob.theta +=2;
  }


  void drawBezel(float xOffset, float yOffset2, float yOffset1, color col) { // draws reactive bezels
    fill(col);
    beginShape();
    vertex(xStart-xOffset, yOffset1);
    vertex(xStart-xOffset, yOffset2);
    vertex(panelWidth+xOffset, yOffset2);
    vertex(panelWidth+xOffset, yOffset1);
    vertex(xStart-xOffset, yOffset1);
    endShape();
    noFill();
  }

  class Knob {
    //private float midPoint = dist(xStart, yStart-400, xStart, 10)/2;
    //private float x = xStart/2+panelWidth/2;
    private float diameter = 100; // I have noticed that this is not reactive due to using 100, but sometimes triage is required
    private float radius = diameter/2;
    public float theta = 0;

    public void draw() {
      float[][] line1 = {{0, radius+10}, {0, -(radius+10)}};
      float[][] line2 = {{radius+10, 0}, {-(radius+10), 0}};
      circle(0, 0, diameter);
      pushMatrix();
      rotate(radians(theta)); // Rotate around the center of the knob
      line(line1[0][0], line1[0][1], line1[1][0], line1[1][1]);
      line(line2[0][0], line2[0][1], line2[1][0], line2[1][1]);
      popMatrix();
    }
  }
}

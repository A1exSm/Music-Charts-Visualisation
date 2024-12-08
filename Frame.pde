class Frame {
  float displayH = 400;
  Knob[] controls = {new Knob(), new Knob(), new Knob()};


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

    controls[2].theta+=2;
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

  class Knob {
    private float diameter = 100; // I have noticed that this is not reactive due to using 100, but sometimes triage is required
    private float radius = diameter/2;
    public float theta = 0; // to make the circle align correctly a transformation of -5 degrees is needed
    protected float offset;
    float[][] line1 = {{0, radius+10}, {0, -(radius+10)}};
    float[][] line2 = {{radius+10, 0}, {-(radius+10), 0}};
    public void draw() {
      stroke(192, 192, 192);
      line(0, -(radius+10), 0, -(radius+20));
      noStroke();
      // drawing cirlce
      fill(105, 105, 105);
      circle(0, 0, diameter);
      noFill();
      // drawing hand of instrument
      pushMatrix();
      rotate(radians(theta));// Rotate around the center of the knob
      hand(110, 70, color(128, 128, 128));
      hand(100, 80, color(192, 192, 192));
      popMatrix();
    }

    void hand(int radian1, int radian2, color col) {
      beginShape();
      stroke(col);
      fill(col);
      // x = radius * cos(theta)
      // y = radius * sin(theta)
      vertex(0, -(radius-6));
      vertex(radius*cos(radians(radian1)), radius*sin(radians(radian1)));
      vertex(radius*cos(radians(radian2)), radius*sin(radians(radian2)));
      endShape(CLOSE);
      noStroke();
      noFill();
    }
  }
}

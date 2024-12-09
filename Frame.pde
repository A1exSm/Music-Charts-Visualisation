class Frame {
  float displayH = 400;
  Knob[] controls = {new Knob(0), new Knob(1), new Knob(2)};


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

  class Knob {
    private float diameter = 100; // I have noticed that this is not reactive due to using 100, but sometimes triage is required
    private float radius = diameter/2;
    public float theta = 0; // to make the circle align correctly a transformation of -5 degrees is needed
    protected float offset;
    float[][] line1 = {{0, radius+10}, {0, -(radius+10)}};
    float[][] line2 = {{radius+10, 0}, {-(radius+10), 0}};
    int KnobNumber;

    Knob(int KnobNumber) {
      this.KnobNumber = KnobNumber;
    }

    public void draw() {
      // drawing cirlce
      noStroke();
      fill(105, 105, 105);
      circle(0, 0, diameter);
      noFill();
      for (int i = 0; i < 360; i+=30) {
        stickMarker(i, KnobNumber);
      }
      // drawing hand of instrument
      pushMatrix();
      rotate(radians(theta));// Rotate around the center of the knob
      hand(110, 70, color(128, 128, 128)); // origin of radian is 90 degrees right of the point
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

    void stickMarker(int radian, int index) {
      // rotating angle by -90 degrees to make origin point at the top of circle
      // calculate x,y start point and x,y end point
      float x1 = (radius+10)*cos(radians(radian-90));
      float x2 = (radius+20)*cos(radians(radian-90));
      float y1 = (radius+10)*sin(radians(radian-90));
      float y2 = (radius+20)*sin(radians(radian-90));
      // drawing stick marker
      stroke(128, 128, 128);
      line(x1, y1, x2, y2);
      noStroke();
      if (index == 1) { // which knob this is
        // aggrogate allign logic
        if (radian > 0 || radian < 180) {
          textAlign(LEFT);
        } else if (radian > 180 || radian < 360) {
          textAlign(RIGHT);
        }
        if (radian == 0) {
          textAlign(CENTER);
          x2-=1;
          y2-=4;
        } else if (radian == 30 || radian == 60) {
          x2+=2;
          y2-=2;
        } else if (radian == 90) {
          x2+=4;
          y2+=4;
        } else if (radian == 120 || radian == 150) {
          x2+=2;
          y2+=5;
        } else if (radian == 180) {
          textAlign(CENTER);
          x2-=1;
          y2+=12;
        } else if (radian == 210 || radian == 240) {
          x2-=25;
          y2+=8;
        } else if (radian == 270) {
          x2-=25;
          y2+=3;
        } else if (radian == 300 || radian == 330) {
          x2-=25;
          y2-=3;
        }
        // drawing month names
        fill(192, 192, 192);
        text(monthArray[radian/30], x2, y2);
        noFill();
      }
    }
  }
}

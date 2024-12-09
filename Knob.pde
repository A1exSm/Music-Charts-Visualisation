class Knob {
  private float diameter = height*0.08; // kinda reactive to screen size
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
    for (int i = 0; i < 360; i+=body.controlsTheta[KnobNumber]) {
      stickMarker(i, KnobNumber);
    }
    // drawing hand of instrument
    pushMatrix();
    rotate(radians(theta));// Rotate around the center of the knob
    hand(110, 70, color(128, 128, 128)); // origin of theta is 90 degrees right of the point
    hand(100, 80, color(192, 192, 192));
    popMatrix();
  }

  void hand(float theta1, float theta2, color col) {
    beginShape();
    stroke(col);
    fill(col);
    // x = radius * cos(theta)
    // y = radius * sin(theta)
    vertex(0, -(radius-6));
    vertex(radius*cos(radians(theta1)), radius*sin(radians(theta1)));
    vertex(radius*cos(radians(theta2)), radius*sin(radians(theta2)));
    endShape(CLOSE);
    noStroke();
    noFill();
  }

  void stickMarker(float theta, int index) {
    // rotating angle by -90 degrees to make origin point at the top of circle
    // calculate x,y start point and x,y end point
    float x1 = (radius+10)*cos(radians(theta-90));
    float x2 = (radius+20)*cos(radians(theta-90));
    float y1 = (radius+10)*sin(radians(theta-90));
    float y2 = (radius+20)*sin(radians(theta-90));
    // drawing stick marker
    if (index == 0) { // the year dial needs extra attention since there are too many years
      if (theta % 45 == 0) { // checks if theta is a multiple of 45, since we are incrementing by 45 degrees.
        alignPrintYear(theta, x2, y2);
        stroke(255, 250, 250); // sub markers are darker and placed in else, main markers are lighter and more visible.
      } else {
        stroke(128, 128, 128);
      }
    } else {
      stroke(128, 128, 128);
    }
    line(x1, y1, x2, y2);
    noStroke();
    fill(192, 192, 192);
    if (index == 1) {
      alignPrintMonths(theta, x2, y2);
    } else if (index == 2) {
      alignPrintRank(theta, x2, y2);
    }
    // drawing month names
    noFill();
  }

  void alignPrintYear(float theta, float x2, float y2) {
    if (theta > 0 && theta < 180) {
      textAlign(LEFT);
      x2+=2;
      y2+=2;
    } else if (theta == 0 || theta == 180) {
      textAlign(CENTER);
      x2 -= 1;
    } else {
      textAlign(RIGHT);
      x2-=4;
      y2+=2;
    }
    if (theta == 0) {
      y2 -= 4;
    } else if (theta == 90 || theta == 270) {
      y2+=2;
    } else if (theta == 180) {
      y2+=10;
    }
    fill(255, 250, 250);
    text(int(1958 + 8*(theta/45)), x2, y2); // calculates year using formula which gets segment (theta/45)
    noFill();
  }

  void alignPrintMonths(float theta, float x2, float y2) {
    // aggrogate allign logic
    if (theta > 0 || theta < 180) {
      textAlign(LEFT);
    } else if (theta > 180 || theta < 360) {
      textAlign(RIGHT);
    }
    if (theta == 0) {
      textAlign(CENTER);
      x2-=1;
      y2-=4;
    } else if (theta == 30 || theta == 60) {
      x2+=2;
      y2-=2;
    } else if (theta == 90) {
      x2+=4;
      y2+=4;
    } else if (theta == 120 || theta == 150) {
      x2+=2;
      y2+=5;
    } else if (theta == 180) {
      textAlign(CENTER);
      x2-=1;
      y2+=12;
    } else if (theta == 210 || theta == 240) {
      x2-=25;
      y2+=8;
    } else if (theta == 270) {
      x2-=25;
      y2+=3;
    } else if (theta == 300 || theta == 330) {
      x2-=25;
      y2-=3;
    }
    text(monthArray[int(theta/30)], x2, y2);
  }

  void alignPrintRank(float theta, float x2, float y2) {
    // aggrogate allign
    if (theta > 0 && theta < 180) {
      textAlign(LEFT);
      x2 += 2;
    } else if (theta > 180 && theta < 360) {
      textAlign(RIGHT);
      x2-=3;
      y2-=2;
    } else {
      textAlign(CENTER);
      x2-=2;
      y2-=4;
    }
    if (theta > 72 && theta < 192) {
      x2 += 2;
      y2 += 5;
    } else if (theta > 168 && theta < 288) {
      y2 +=7;
    }
    text(int((theta+24)/24), x2, y2);
  }
}

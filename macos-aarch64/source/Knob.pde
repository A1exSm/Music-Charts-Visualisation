class Knob {
  private float diameter = height*0.08; // kinda reactive to screen size
  private float radius = diameter/2;
  private float theta = 0; // angle theta determines the angle of the knob
  private int KnobNumber;

  Knob(int KnobNumber) {
    this.KnobNumber = KnobNumber;
  }

  private void draw() {
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

  private void hand(float theta1, float theta2, color col) {
    beginShape();
    stroke(col);
    fill(col);
    vertex(0, -(radius-6));
    vertex(radius*cos(radians(theta1)), radius*sin(radians(theta1)));
    vertex(radius*cos(radians(theta2)), radius*sin(radians(theta2)));
    endShape(CLOSE);
    noStroke();
    noFill();
  }

  private void stickMarker(float theta, int index) {
    // rotating angle by -90 degrees to make origin point at the top of circle
    // calculate x,y start point and x,y end point
    float x1 = (radius+10)*cos(radians(theta-90));
    float x2 = (radius+20)*cos(radians(theta-90));
    float y1 = (radius+10)*sin(radians(theta-90));
    float y2 = (radius+20)*sin(radians(theta-90));
    // drawing stick marker
    if (index == 0 && theta % 45 == 0) {  // checks if this is year dial, theta should be a multiple of 45, since we are incrementing by 45 degrees. 
        alignPrintYear(theta, x2, y2); // the year dial needs extra attention since there are too many years
        stroke(255, 250, 250); // sub markers are darker and placed in else, main markers are lighter and more visible.
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

  private void alignPrintYear(float theta, float x2, float y2) {
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

  private void alignPrintMonths(float theta, float x2, float y2) {
    // aggrogate allign logic
    if (theta > 0 && theta < 180) {
      textAlign(LEFT);
      x2+=2;
    } else if (theta > 180 && theta < 360) {
      textAlign(RIGHT);
      x2-=3;
    } else {
      textAlign(CENTER);
      x2-=2;
      y2+=12;
    }
    // adjustments in aggrogate allignment
    if (theta == 0) {
      y2-=16;
    } else if ((theta > 90 && theta < 180) || (theta > 180 && theta < 270)) {
      y2+=9;
    } else if (theta == 90 || theta == 270) {
      y2+=3;
    }
    text(monthArray[int(theta/30)], x2, y2);
  }

  private void alignPrintRank(float theta, float x2, float y2) {
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

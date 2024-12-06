class Frame {
  void draw() {
    // init
    Display display = new Display();
    Controls controls = new Controls();
    Knob knob = new Knob();
    // method call
    display.draw();
    controls.draw();
    knob.draw();
  }

  class Display extends Frame {
    void draw() {
      drawBezel(10, 410, color(115, 109, 99));
      drawBezel(0, 400, color(20));
    }

    void drawBezel(float xOffset, float yOffset, color colour) {
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
  }

  class Controls extends Frame {
    void draw() {
      drawBezel(10, 430, 20, color(115, 109, 99)); // draws outer bezel
      drawBezel(0, 440, 30, color(20)); // draws inner bezel
    }
    void drawBezel(float xOffset, float yOffset, float offset, color colour) {
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
  }

  class Knob extends Controls {
    float midPoint = dist(xStart, yStart-400, xStart, 10)/2;
    float x = xStart/2+panelWidth/2;
    void draw() {
      circle(x, midPoint, midPoint);
      line(x, midPoint+60, x, midPoint-60);
      line(x+60, midPoint, x-60, midPoint);
      line(x + panelWidth/2, midPoint, panelWidth, midPoint);
    }
  }
}

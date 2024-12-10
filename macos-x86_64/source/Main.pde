// declaring fields
private String[] monthArray = {"JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};
private ArrayList<ArrayList<ArrayList<SongData>>> sortedSongs; // 3D ArrayList { Years { Months { Ranks } } }
private float panelWidth, panelHeight, xStart, yStart, phase;
private int[] position = {0, 0, 0}; // {year, month, rank} used to store the current position within the 3D ArrayList declared above.
private Wave currentWave;
private Frame body;

void setup() {
  fullScreen();
  phase = 0;
  body = new Frame();
  // method calls:
  initSetup(); // initialises variables
  loadData(); // onloads and sorts data from CSV file
}

void draw() {
  background(168, 158, 111);
  // using constrain to prevent incorrect input
  position[0] = constrain(position[0], 0, 63); // Years range from index 0 to 63, ensures no bad input
  position[1] = constrain(position[1], 0, 11); // Months range from index 0 to 11 (12 months)
  position[2] = constrain(position[2], 0, 14); // Ranks range from index 0 to 14, since there are 15 ranks
  // set wave to selected position
  SongData currentSong = sortedSongs.get(position[0]).get(position[1]).get(position[2]);
  body.draw();
  stroke(255, 50);
  line(xStart, panelHeight-410, panelWidth, panelHeight-410);
  noStroke();
  if (currentSong.date != null) {
    currentWave = new Wave(currentSong);
    currentWave.draw();
    body.controls[0].theta = ((float) 360/64) * position[0];
    body.controls[1].theta = body.controlsTheta[1] * position[1]; // if pos = 0. then 30 * 0 = 0, thus still at cirlce origin.
    body.controls[2].theta = body.controlsTheta[2] * position[2];
  } else {
    if (position[1] < 11) {
      position[1]++;
    } else {
      position[1]--;
    }
  }
}

void keyPressed() {
  // Year navigation
  if (keyCode == UP) {
    if (position[0] < 63) {
      position[0]++;
    } else {
      position[0] = 0;
    }
  } else if (keyCode == DOWN) {
    if (position[0] > 0) {
      position[0]--;
    } else {
      position[0] = 63;
    }
  }
  // Month navigation
  if (keyCode == RIGHT) {
    if (position[1] != 11) {
      position[1]++;
    } else {
      position[1] = 0;
    }
  } else if (keyCode == LEFT) {
    if (position[1] != 0) {
      position[1]--;
    } else {
      position[1] = 11;
    }
  }
  // Rank navigation
  if (key == ' ') {
    if (position[2] != 14) {
      position[2]++;
    } else {
      position[2] = 0;
    }
  } else if (key == 'r') {
    position[0] = 0;
    position[1] = 0;
    position[2] = 0;
  }
}

private void initSetup() { // handles variable initialisation for sketch setup
  panelWidth = (width/2 + 800)+100;
  if (panelWidth >= width) {
    panelWidth = (width/3 + 800);
  }
  panelHeight = (height/2 + 400)+100;
  xStart = width - panelWidth;
  yStart = panelHeight-400;
}

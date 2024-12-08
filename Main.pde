float panelWidth, panelHeight, xStart, yStart;
Frame body;
float phase = 0;
String[] monthArray = {
  "January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December"
};
int[] position = {1, 0, 0};// {year, month, rank}
ArrayList<SongData> songs;
ArrayList<ArrayList<ArrayList<SongData>>> sortedSongs; // year, month, rank
Wave currentWave;
void setup() {
  //size(800, 400); // 800 width, 400 height
  fullScreen();
  // method calls:
  body = new Frame();
  initSetup();
  loadData();
  sortData();
}

void draw() {
  // using constrain to prevent incorrect input
  position[0] = constrain(position[0], 0, 63); // Years range from index 0 to 63, ensures no bad input
  position[1] = constrain(position[1], 0, 11); // Months range from index 0 to 11 (12 months)
  position[2] = constrain(position[2], 0, 14); // Ranks range from index 0 to 14, since there are 15 ranks
  // set wave to selected position
  SongData currentSong = sortedSongs.get(position[0]).get(position[1]).get(position[2]);
  background(168, 158, 111);
  body.draw();
  stroke(255, 50);
  line(xStart, panelHeight-410, panelWidth, panelHeight-410);
  noFill();
  if (currentSong.date != null) {
    currentWave = new Wave(currentSong);
    currentWave.draw();
  } else {
    position[1]++;
  }
}

//void initSetup() { // handles variable initialisation for sketch setup
//  panelWidth = (width/2 + 800)+100;
//  if (panelWidth >= width) {
//    panelWidth = (width/3 + 800);
//  }
//  panelHeight = (height/2 + 400)+100;
//  xStart = width - panelWidth;
//  yStart = panelHeight-400;
//}

void initSetup() {
  panelWidth = width * 0.8;
  panelHeight = height * 0.8;
  xStart = width - panelWidth;
  yStart = panelHeight - 400;
}

void keyPressed() {
  // Year navigation (0 to 63)
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

  // Month navigation (0 to 11)
  if (keyCode == RIGHT && position[1] < 11) {
    position[1]++;
  } else if (keyCode == LEFT && position[1] > 0) {
    position[1]--;
  }

  // Rank navigation (0 to 14)
  if (key == ' ' && position[2] < 14) {
    position[2]++;
  } else if (key == BACKSPACE && position[2] > 0) {
    position[2]--;
  }
}

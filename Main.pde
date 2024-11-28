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
  size(800, 400);
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
  background(20);
  stroke(255, 50);
  line(0, height/2, width, height/2);
  noFill();
  if (currentSong.date != null) {
    currentWave = new Wave(currentSong);
    currentWave.draw();
  } else {
    position[1]++;
  }
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
// old method:
//void keyPressed() {
//  if (position[0] == 63 || position[1] == 11 || position[2] == 14) {
//    if (keyCode == RIGHT) {
//      if (position[0] == 0) {
//        position[1] = 7;
//      }
//      position[1] = 0;
//    } else if (keyCode == UP) {
//      position[0] = 0;
//    } else if (key == ' ') {
//      position[2] = 0;
//    }
//  } else if (position[0] == 1 || position[1] == 1) {
//    if (keyCode == RIGHT) {
//      position[1]++;
//    } else if (keyCode == LEFT) {
//      position[1]--;
//    } else if (keyCode == UP) {
//      position[0]++;
//    } else if (keyCode == DOWN) {
//      position[0]--;
//    } else if (key == ' ') {
//      position[2]++;
//    }
//  }
//}

class Wave {
  float amplitude;
  float waveLength;
  float cycles = 2;
  float phaseSpeed = 0.09;
  color colour;
  SongData song;

  Wave(SongData song) {
    updateWave(song);
  }

  color[] rankColours = {
    color(255, 0, 0), // Bright red
    color(255, 64, 0), // Bright orange
    color(255, 128, 0), // Orange
    color(255, 192, 0), // Yellow-orange
    color(255, 255, 0), // Yellow
    color(192, 255, 0), // Yellow-green
    color(128, 255, 0), // Greenish-yellow
    color(0, 255, 0), // Green
    color(0, 255, 128), // Light green
    color(0, 255, 192), // Turquoise
    color(0, 192, 255), // Cyan
    color(0, 128, 255), // Blue
    color(0, 64, 255), // Indigo
    color(128, 0, 255), // Purple
    color(64, 0, 128)     // Dark purple
  };

  void updateWave(SongData data) {
    this.song = data;
    // map (value, start1, stop1, start2, stop2);
    this.amplitude = map(data.song.length(), 0, 30, 100, height/2 - 50);
    //this.waveLength = map(data.month, 0, 11, width/4, width*2);
    this.waveLength = map(data.artist.length(), 0, 30, width/4, width*2);
    //this.cycles = map(data.year, 1958, 2021, 1, 5);
    this.cycles = map(data.month, 0, 11, 1, 50);
    this.colour = rankColours[data.rank];
    this.phaseSpeed = map(data.year, 1958, 2021, 0.1, 5.0);
  }

  void draw() {
    //println("Current phase: " + phase);
    beginShape();
    stroke(this.colour);
    for (float x = 0; x < width; x++) {
      float y = height/2 + this.amplitude * sin((x / this.waveLength) * 2 * PI * this.cycles + phase);
      vertex(x, y);
    }
    endShape();
    phase+=this.phaseSpeed;

    fill(255);
    textAlign(LEFT);
    textSize(16);
    text(this.song.song + " - " + song.artist, 10, height - 40);
    textSize(12);
    text(
      "Year: " + song.year +
      " | Month: " + monthArray[position[1]] +
      " | Day: " + song.day +
      " | Rank: " + (song.rank+1), 10, height - 20
      );

    textAlign(RIGHT);
    text("SPACE & BACKSPACE: Change rank | ↑↓: Change year | ←→: Change month", width - 10, height - 20);
    noFill();
  }
}

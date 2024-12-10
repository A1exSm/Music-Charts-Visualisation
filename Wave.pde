class Wave {
  private float amplitude, waveLength, cycles, phaseSpeed;
  private color colour;
  private SongData song;

  Wave(SongData song) {
    updateWave(song);
  }

  private color[] rankColours = {
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
    color(64, 0, 128) // Dark purple
  };

  private void updateWave(SongData data) {
    this.song = data;
    this.amplitude = map(data.song.length(), 0, 70, 0, 400);
    this.waveLength = map(data.artist.length(), 3, 30, 20, panelWidth/8);
    this.cycles = map(data.month, 0, 11, 1, 50);
    this.colour = rankColours[data.rank];
    this.phaseSpeed = map(data.year, 1958, 2021, 0.1, 5.0);
  }

  private void draw() {
    beginShape();
    stroke(this.colour);
    for (float x = xStart; x < panelWidth; x++) {
      float y = panelHeight-410 + this.amplitude * sin((x / this.waveLength) * 2 * PI * this.cycles + phase);
      vertex(x, y);
    }
    endShape();
    phase+=this.phaseSpeed;
    noStroke();
    fill(255);
    textAlign(LEFT);
    textSize(16);
    text(this.song.song + " - " + song.artist, xStart+10, panelHeight - 40);
    textSize(12);
    text("Year: " + song.year + " | Month: " + monthArray[position[1]] + " | Rank: " + (song.rank+1), xStart+10, panelHeight - 20);
    textAlign(RIGHT);
    text("SPACE: Rank | \u2191\u2193: Change year | \u2190\u2192: Change month | R: Reset", panelWidth - 10, panelHeight - 20); // arrows using unicode
    noFill();
  }
}

class SongData {
  // field declaration
  private String date, song, artist;
  private int year, rank, month;
  // sub class initialiser (classes in processing are all treated as sub classes of the main pde file)
  SongData(String date, String song, String artist, int rank) {
    this.date = date;
    this.song = song;
    this.artist = artist;
    this.rank = rank-1;
    this.year = Integer.parseInt(date.substring(6, 10)); // dd-mm-yyyy
    this.month = Integer.parseInt(date.substring(3, 5))-1;
  }
  SongData() {
    this.date=null;
  }
}

private void loadData() {
  setArrayLists(); // sets up sortedSongs ArrayList to be populated
  Table data = loadTable("charts.csv", "header"); // saves CSV information to data
  for (TableRow row : data.rows()) {
    SongData song = new SongData( // creating a new itteration of SongData
      row.getString("dates"),
      row.getString("song"),
      row.getString("artist"),
      row.getInt("rank")
      );
    // sortings song into the sortedSongs ArrayList
    int yearIndex = song.year - 1958; // i.e 1959 would be at index 1 and 1958 at index 0
    if (yearIndex >= 0 && yearIndex < sortedSongs.size()) {
      sortedSongs.get(yearIndex).get(song.month).set(song.rank, song);
    }
  }
}

private void setArrayLists() {
  // intialising ArrayLists
  sortedSongs = new ArrayList<>();
  // Array { Years { Months { Ranks } } }
  for (int numYears = 0; numYears < 64; numYears++) {
    ArrayList<ArrayList<SongData>> yearList = new ArrayList<>();
    for (int numMonths = 0; numMonths < 12; numMonths++) {
      ArrayList<SongData> monthList = new ArrayList<>();
      for (int numRanks = 0; numRanks < 15; numRanks++) {
        SongData emptySong = new SongData();
        monthList.add(emptySong);// added empty song object to month list
      }
      yearList.add(monthList);
    }
    sortedSongs.add(yearList);
  }
}

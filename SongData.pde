class SongData {
  String date;
  String song;
  String artist;
  int year;
  int day;
  int rank;
  int month;
  SongData(String date, String song, String artist, int rank) {
    this.date = date;
    this.song = song;
    this.artist = artist;
    this.rank = rank-1;
    this.year = Integer.parseInt(date.substring(6, 10)); // dd-mm-yyyy
    this.month = Integer.parseInt(date.substring(3, 5))-1;
    this.day = Integer.parseInt(date.substring(0, 2));
  }
  SongData() {
    this.date=null;
  }
}

void loadData() {
  Table data = loadTable("charts.csv", "header"); // saving table data to data
  songs = new ArrayList<SongData>(); // creating an array list of type SongData to store songs
  for (TableRow row : data.rows()) {
    //println(row.getString("date"));
    SongData song = new SongData( // creating a new itteration of SongData
      row.getString("dates"),
      row.getString("song"),
      row.getString("artist"),
      row.getInt("rank")
      );
    songs.add(song);
  }
}

// Array { Years { Months { Week { Ranks } } } }
void setArrayLists() {
  // intialising ArrayLists
  sortedSongs = new ArrayList<>();

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

void sortData() {
  setArrayLists();
  // Populating ArrayLists
  for (SongData song : songs) {
    int yearIndex = song.year - 1958; // i.e 1959 would be at index 1
    if (yearIndex >= 0 && yearIndex < sortedSongs.size()) {
      sortedSongs.get(yearIndex).get(song.month).set(song.rank, song);
    }
  }
}

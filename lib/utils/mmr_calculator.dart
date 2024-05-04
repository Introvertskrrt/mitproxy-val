class MMRCalculator {
  static Future<int> calculateMmr(String rankName, int currentRR) async {
    // Convert the rank name to lowercase for case-insensitive comparison
    String lowercaseRankName = rankName.toLowerCase();

    // Map of ranks to MMR values
    Map<String, int> rankMmrMap = {
      'unranked': 0,
      'iron 1': 100,
      'iron 2': 200,
      'iron 3': 300,
      'bronze 1': 400,
      'bronze 2': 500,
      'bronze 3': 600,
      'silver 1': 700,
      'silver 2': 800,
      'silver 3': 900,
      'gold 1': 1000,
      'gold 2': 1100,
      'gold 3': 1200,
      'platinum 1': 1300,
      'platinum 2': 1400,
      'platinum 3': 1500,
      'diamond 1': 1600,
      'diamond 2': 1700,
      'diamond 3': 1800,
      'ascendant 1': 1900,
      'ascendant 2': 2000,
      'ascendant 3': 2100,
      'immortal 1': 2200,
      'immortal 2': 2300,
      'immortal 3': 2400,
      'radiant': 2500,
    };

    // Get the base MMR from the map
    int baseMmr = rankMmrMap[lowercaseRankName] ?? 0;

    // Calculate the final MMR by adding the current Rank Rating
    int finalMmr = baseMmr + currentRR;

    // Return the final MMR value
    return finalMmr;
  }

}

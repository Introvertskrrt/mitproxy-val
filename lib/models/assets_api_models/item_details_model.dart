class ItemDetails {
  List<String> displayName = [];
  List<String> displayIcon = [];
  List<String> swatch = [];
  String finisher;

  ItemDetails ({
    required this.displayName,
    required this.displayIcon,
    required this.swatch,
    required this.finisher,
  });
}
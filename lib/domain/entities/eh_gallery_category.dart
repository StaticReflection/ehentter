enum EhGalleryCategory {
  doujinshi('Doujinshi'),
  manga('Manga'),
  artistCg('Artist CG'),
  gameCg('Game CG'),
  western('Western'),
  nonH('Non-H'),
  imageSet('Image Set'),
  cosplay('Cosplay'),
  asianPorn('Asian Porn'),
  misc('Misc');

  final String label;

  const EhGalleryCategory(this.label);

  static EhGalleryCategory fromString(String value) {
    return EhGalleryCategory.values.firstWhere((e) => e.label == value);
  }
}

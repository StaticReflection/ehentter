enum EhGalleryTagNamespaces {
  artist,
  character,
  cosplayer,
  female,
  group,
  language,
  location,
  male,
  mixed,
  other,
  parody,
  reclass,
  temp;

  static EhGalleryTagNamespaces fromString(String value) {
    return EhGalleryTagNamespaces.values.firstWhere(
      (e) => e.name == value,
      orElse: () => EhGalleryTagNamespaces.temp,
    );
  }
}

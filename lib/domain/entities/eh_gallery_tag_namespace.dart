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
  reclass;

  static EhGalleryTagNamespaces fromString(String value) {
    return EhGalleryTagNamespaces.values.firstWhere((e) => e.name == value);
  }
}

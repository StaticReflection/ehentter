class EhTorrent {
  final String hash;
  final DateTime added;
  final String name;
  final String tsize; // Torrent大小
  final String fsize; // 文件大小

  EhTorrent({
    required this.hash,
    required this.added,
    required this.name,
    required this.tsize,
    required this.fsize,
  });
}

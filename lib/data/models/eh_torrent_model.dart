import 'package:ehentter/domain/entities/eh_torrent.dart';

class EhTorrentModel extends EhTorrent {
  EhTorrentModel({
    required super.hash,
    required super.added,
    required super.name,
    required super.tsize,
    required super.fsize,
  });
}

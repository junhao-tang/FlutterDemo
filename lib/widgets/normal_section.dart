import 'package:flutter/material.dart';
import 'package:flutter_wheel/models/index.dart';

import 'playlists.dart';

class NormalSectionWidget extends StatelessWidget {
  final List<Playlist> playlists;

  const NormalSectionWidget(this.playlists, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Text(
            "Made for people like you",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        PlaylistsWidget(playlists),
      ],
    );
  }
}

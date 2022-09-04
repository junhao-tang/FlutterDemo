import 'package:flutter/material.dart';
import 'package:flutter_demo/models/index.dart';

import 'playlists.dart';

class RecentlyPlayedSectionWidget extends StatelessWidget {
  final List<Playlist> playlists;

  const RecentlyPlayedSectionWidget(this.playlists, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Text(
            "Recently Played",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        PlaylistsWidget(
          playlists,
          compressed: true,
        ),
      ],
    );
  }
}

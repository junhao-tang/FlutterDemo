import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wheel/models/index.dart';

import 'playlists.dart';

class MoreLikeSection extends StatelessWidget {
  final List<Playlist> playlists;
  final String title;
  final Artist artist;

  const MoreLikeSection(this.title, this.artist, this.playlists, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: _CategoryHeaderWidget(
            title,
            artist,
          ),
        ),
        PlaylistsWidget(playlists),
      ],
    );
  }
}

class _CategoryHeaderWidget extends StatelessWidget {
  final Artist data;
  final String title;

  const _CategoryHeaderWidget(
    this.title,
    this.data, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipOval(
          child: SizedBox.fromSize(
            size: const Size.fromRadius(30), // Image radius
            child: AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(
                imageUrl: data.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10), //padding
        Expanded(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Text(
                  data.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

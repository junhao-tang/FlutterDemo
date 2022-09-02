import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wheel/models/playlist.dart';
import 'package:flutter_wheel/route.dart';
import 'package:flutter_wheel/util/router.dart';

class PlaylistsWidget extends StatelessWidget {
  const PlaylistsWidget(
    this.data, {
    this.compressed = false,
    Key? key,
  }) : super(key: key);

  final List<Playlist> data;
  final bool compressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: compressed ? 150 : 200, //
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...data.map(
                      (e) => PlaylistWidget(
                        e,
                        compressed: compressed,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PlaylistWidget extends StatelessWidget {
  final Playlist data;
  final bool compressed;

  const PlaylistWidget(this.data, {Key? key, this.compressed = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => routerGoNamed(context, RouteNames.playlist,
          params: {"pid": "${data.id}"}),
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        child: compressed
            ? CompressedPlaylistWidget(data)
            : DetailedPlaylistWidget(data),
      ),
    );
  }
}

class DetailedPlaylistWidget extends StatelessWidget {
  const DetailedPlaylistWidget(this.data, {Key? key}) : super(key: key);

  final Playlist data;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 150 / 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: data.imageUrl != null
                ? CachedNetworkImage(
                    imageUrl: data.imageUrl!,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  )
                : Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 69, 1, 255),
                          Colors.white,
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.favorite,
                    ),
                  ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (data.title != "")
                Text(
                  data.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              Text(
                data.description,
                maxLines: data.title == "" ? 2 : 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CompressedPlaylistWidget extends StatelessWidget {
  const CompressedPlaylistWidget(this.data, {Key? key}) : super(key: key);

  final Playlist data;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 120 / 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: data.imageUrl != null
                ? CachedNetworkImage(
                    imageUrl: data.imageUrl!,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  )
                : Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 69, 1, 255),
                        Colors.white,
                      ],
                    )),
                    child: const Icon(
                      Icons.favorite,
                      size: 15,
                    ),
                  ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Text(
              data.title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          )
        ],
      ),
    );
  }
}

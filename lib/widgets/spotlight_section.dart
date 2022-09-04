import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/models/index.dart';
import 'package:flutter_demo/route.dart';
import 'package:flutter_demo/util/router.dart';

class SpotlightSectionWidget extends StatelessWidget {
  final Playlist playlist;
  final String title;

  const SpotlightSectionWidget(this.title, this.playlist, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        _SpotlightedPlaylistWidget(playlist),
      ],
    );
  }
}

class _SpotlightedPlaylistWidget extends StatelessWidget {
  const _SpotlightedPlaylistWidget(this.data, {Key? key}) : super(key: key);
  final Playlist data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => routerGoNamed(context, RouteNames.playlist,
          params: {"pid": "${data.id}"}),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 150,
              decoration: ShapeDecoration(
                color: const Color.fromARGB(45, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: CachedNetworkImage(
                      imageUrl: data.imageUrl!,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            data.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Expanded(
                            child: Text(
                              data.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Icon(
                                Icons.favorite,
                              ),
                              Icon(
                                Icons.play_circle,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wheel/models/playlist.dart';
import 'package:flutter_wheel/route.dart';
import 'package:flutter_wheel/util/router.dart';

// TODO: try tileslayout?
class TilePlaylistsSectionWidget extends StatelessWidget {
  const TilePlaylistsSectionWidget(
    this._data,
    this._dataPerRow, {
    Key? key,
  }) : super(key: key);

  final List<Playlist> _data;
  final int _dataPerRow;

  @override
  Widget build(BuildContext context) {
    // why not gridview, gridview height is hard to calculate (only has aspect ratio)
    List<Row> rows = [];
    for (int i = 0; i < (_data.length / _dataPerRow).ceil(); i++) {
      List<Widget> children = [];
      for (int j = 0; j < _dataPerRow; j++) {
        if (i * _dataPerRow + j >= _data.length) break;
        if (j > 0 && j < _dataPerRow) {
          children.add(const SizedBox(width: 10));
        }
        children.add(
          Expanded(child: _HighlightButtonWidget(_data[i * _dataPerRow + j])),
        );
      }
      rows.add(
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: (i == 0 ? 0 : 5)),
                child: Row(children: children),
              ),
            ),
          ],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }
}

class _HighlightButtonWidget extends StatelessWidget {
  const _HighlightButtonWidget(
    this.data, {
    Key? key,
  }) : super(key: key);

  final Playlist data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => routerGoNamed(
        context,
        RouteNames.playlist,
        params: {"pid": "${data.id}"},
      ),
      child: Container(
        decoration: ShapeDecoration(
          color: const Color.fromARGB(45, 255, 255, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        height: 65,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            data.imageUrl != null
                ? CachedNetworkImage(
                    imageUrl: data.imageUrl!,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    width: 65,
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
                    width: 65,
                    child: const Icon(
                      Icons.favorite,
                    ),
                  ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Row(children: [
                  Expanded(
                    child: Text(
                      data.title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

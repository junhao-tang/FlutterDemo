import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_demo/models/user.dart';
import 'package:flutter_demo/route.dart';
import 'package:flutter_demo/util/router.dart';
import 'package:provider/provider.dart';

class TopNavWidget extends StatelessWidget {
  const TopNavWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppLocalizations.of(context).goodMorning(user.name),
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
        ),
        const IconWithNotification(Icons.notifications),
        const IconWithNotification(Icons.history),
        const IconWithNotification(Icons.settings),
      ],
    );
  }
}

class IconWithNotification extends StatefulWidget {
  const IconWithNotification(
    this.iconData, {
    this.notification = 0,
    Key? key,
  }) : super(key: key);

  final IconData iconData;
  final int notification;

  @override
  State<StatefulWidget> createState() => _IconWithNotification();
}

class _IconWithNotification extends State<IconWithNotification> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        width: 35,
        height: 35,
        child: Center(
          child: IconButton(
            icon: Icon(
              widget.iconData,
              size: 24,
              semanticLabel: 'todo',
            ),
            onPressed: () {
              setState(() {
                routerGoNamed(context, RouteNames.settings);
              });
            },
          ),
        ),
      ),
      if (widget.notification > 0)
        Positioned(
          left: 5,
          top: 5,
          child: Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: const BoxConstraints(
              minWidth: 8,
              minHeight: 8,
            ),
          ),
        )
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../providers/data.dart';

class NotifsListView extends StatelessWidget {
  const NotifsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifs = Provider.of<Data>(context, listen: false).notifs;

    print('https://admin.rain-app.com/storage/outlooks/${notifs[0].media}');
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: notifs.length,
      itemBuilder: (context, index) => ListTile(
          title: Text(notifs[index].content, maxLines: 1),
          subtitle: Text(notifs[index].date),
          trailing: CachedNetworkImage(
              fit: BoxFit.fill,
              height: 42,
              width: 42,
              imageUrl:
                  'https://admin.rain-app.com/storage/notifications/${notifs[index].media}')),
    );
  }
}

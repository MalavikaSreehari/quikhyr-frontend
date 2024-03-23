import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quikhyr/common/constants/app_asset_links.dart';
import 'package:quikhyr/common/constants/app_colors.dart';
import 'package:quikhyr/common/constants/app_theme.dart';
import 'package:quikhyr/models/worker_model.dart';

class UserItem extends StatefulWidget {
  const UserItem({super.key, required this.worker});

  final WorkerModel worker;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        alignment: Alignment.center,
        height: 64,
        width: 64,
        child: Stack(
          children: [
            const Positioned.fill(
                child: CircleAvatar(
              backgroundImage: NetworkImage(
                AppAssetLinks.placeholderImage,
              ),
            )),
            // if (state.workers[index].isVerified)
            Positioned(
              top: 0,
              right: 0,
              child: SvgPicture.asset(
                AppAssetLinks.verifiedBlueSvg,
              ),
            ),
            Positioned(
                bottom: 0,
                left: 4,
                child: SvgPicture.asset(AppAssetLinks.chatGreenBubbleSvg)),
          ],
        ),
      ),
      title: Text(widget.worker.name,
          style: Theme.of(context).textTheme.headlineSmall),
      subtitle: const Text("Will meet you tomorrow.", style: chatSubTitle),
      trailing: const Text(
        "7:04 pm",
        style: chatTrailingActive,
      ),
      onTap: () {},
    );
  }
}

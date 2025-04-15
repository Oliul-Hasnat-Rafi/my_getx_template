import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_process_button_widget/on_process_button_widget.dart';
import 'package:photos/components.dart';
import 'package:photos/src/view/widget/button_3.dart';

import '../../controller/screen_controller/home_screen_controller.dart';
import '../../model/response_model/photo_screen_response_model.dart';
import '../widget/loading_bar.dart';

class FullScreenImageView extends StatelessWidget {
  final PhotoScreenResponseModel? photo;

   FullScreenImageView({super.key, required this.photo});
  final HomeScreenController _controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Full Mode",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              )),
      centerTitle: true,
      actions: [
         Button3(
          onTap: () => _controller.getPhotoDownload(photo?.urls?.regular ?? ""),
          child: const Icon(Icons.file_download_outlined),
        ),
          Button3(
          onTap: () => _controller.shareImage(photo?.urls?.regular ?? ""),
          child: const Icon(Icons.share),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                  child: Image.network(
                    photo?.urls?.regular ?? "",
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const CustomLinearProgressBar.small(show: true);
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Text(
              photo?.description ?? "No Description",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

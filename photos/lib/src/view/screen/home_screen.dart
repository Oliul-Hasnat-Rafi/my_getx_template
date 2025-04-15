import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:photos/src/view/screen/full_screen.dart';
import '../../../components.dart';
import '../../controller/screen_controller/home_screen_controller.dart';
import '../../model/response_model/photo_screen_response_model.dart';
import '../widget/loading_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeScreenController _controller = Get.put(HomeScreenController());
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _setupScrollController();
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  void _setupScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        _controller.fetchPhotos(loadMore: true);
      }
    });
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Photo Gallery',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              )),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return Obx(() {
      if (_controller.isLoading.value) {
        return CustomLinearProgressBar.small(
          show: _controller.isLoading.value,
        );
      }

      return RefreshIndicator(
        onRefresh: _controller.refreshPhotos,
        child: GridView.builder(
          controller: _scrollController,
          padding: EdgeInsets.all(defaultPadding),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: _controller.response.length + 1,
          itemBuilder: (context, index) {
            if (index == _controller.response.length) {
              return _buildLoadMoreIndicator();
            }
            return _buildPhotoCard(context, _controller.response[index]);
          },
        ),
      );
    });
  }

  Widget _buildPhotoCard(BuildContext context, PhotoScreenResponseModel? photo) {
    return GestureDetector(
      onTap: () => _showFullScreenImage(context, photo),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                photo?.urls?.thumb ?? "",
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const CustomLinearProgressBar.small(show: true);
                },
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: 
                   Container(
                    padding: EdgeInsets.all(defaultPadding / 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                    ),
                    child: Text(
                      photo?.user?.name ?? "N/A",
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFullScreenImage(BuildContext context, PhotoScreenResponseModel? photo) {
    Get.to(
      () => FullScreenImageView(photo: photo),
      transition: Transition.fadeIn,
      duration: defaultDuration,
    );
  }

  Widget _buildLoadMoreIndicator() {
    return Obx(() {
      if (_controller.isLoadingMore.value) {
        return CustomLinearProgressBar.small(
          show: _controller.isLoadingMore.value,
        );
      }
      if (!_controller.hasMoreData.value) {
        return Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Center(
            child: Text(
              'End of Gallery',
              style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(Get.context!).colorScheme.inversePrimary,
                  ),
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}

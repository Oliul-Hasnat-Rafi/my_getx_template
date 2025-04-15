import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photos/src/controller/data_controller/data_controller.dart';
import 'package:photos/src/controller/service/functions/dev_print.dart';
import 'package:photos/src/controller/service/user_message/snackbar.dart';
import 'package:share_plus/share_plus.dart';
import '../../model/response_model/photo_screen_response_model.dart';

class HomeScreenController extends GetxController {
  final dataController = Get.find<DataController>();
  final RxList<PhotoScreenResponseModel?> response = <PhotoScreenResponseModel?>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isLoadingMore = false.obs;
  final int itemsPerPage = 20;
  final RxInt currentPage = 1.obs;
  final RxBool hasMoreData = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await dataController.initApp();
    await fetchPhotos();
  }

  Future<void> fetchPhotos({bool loadMore = false}) async {
    try {
      if (loadMore) {
        if (!hasMoreData.value || isLoadingMore.value) return;
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
        currentPage.value = 1;
        response.clear();
      }

      final newPhotos = await dataController.getPhotos(
        perPage: itemsPerPage,
        currentPage: currentPage.value,
      );

      if (newPhotos.isEmpty) {
        hasMoreData.value = false;
      } else {
        response.addAll(newPhotos);
        currentPage.value++;
      }
    } catch (e) {
      devPrint(e);
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<void> refreshPhotos() async {
    hasMoreData.value = true;
    await fetchPhotos();
  }

  Future<File?>? getPhotoDownload(String imageUrl) async {
    if (imageUrl.isEmpty) return null;
    try {
      final res = await dataController.photoDownload(imageUrl);
      if (res != null) {
        final saveRes = _saveImage(res);
        if (saveRes != null) {
          showSnackBar(title: "Saved!", message: "Image saved successfully");
        }
        return saveRes;
      } else {
        showSnackBar(title: "Opes!", message: "Failed to save image");
        return null;
      }
    } catch (e) {
      devPrint(e);
      return null;
    }
  }

  Future<void> shareImage(String imageUrl) async {
    if (imageUrl.isEmpty) return;

    try {
      showSnackBar(
        title: 'Processing',
        message: 'Preparing image for sharing...',
      );
      final imagePath = await getPhotoDownload(imageUrl);
      if (imagePath == null) {
        showSnackBar(
          title: 'Error',
          message: 'Failed to download image',
        );
        return;
      }
      await Share.shareXFiles([
        XFile(imagePath.path)
      ], text: 'Sharing');

      await imagePath.delete();
    } catch (e) {
      devPrint(e);
      showSnackBar(
        title: 'Error',
        message: 'Failed to share image: ${e.toString()}',
      );
    }
  }

  Future<File?>? _saveImage(Uint8List res) async {
    final directory = await getDownloadsDirectory();
    final filePath = '${directory!.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    final file = File(filePath);
    await file.writeAsBytes(res);

    if (file.existsSync()) {
      return file;
    } else {
      return null;
    }
  }
}

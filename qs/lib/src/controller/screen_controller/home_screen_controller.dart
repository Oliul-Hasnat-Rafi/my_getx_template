import 'package:get/get.dart';
import 'package:photos/src/controller/data_controller/data_controller.dart';

import '../../model/response_model/product_response_model.dart';

class HomeScreenController extends GetxController {
  final isLoading = false.obs;
  final DataController dataController = Get.find<DataController>();
  final RxList<Product?> product = RxList<Product?>([]);

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    isLoading.value = true;
    try {
      final res = await dataController.getProduct();

      product.value = res;
    } finally {
      isLoading.value = false;
    }
  }
}

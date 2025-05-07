import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:photos/src/controller/data_controller/data_controller.dart';

import '../../model/response_model/product_response_model.dart';

class HomeScreenController extends GetxController {
  final isLoading = false.obs;
  final DataController dataController;
  final RxList<Product?> product = RxList<Product?>([]);

  HomeScreenController({
    DataController? dataController,
  }) : dataController = dataController ??GetIt.instance<DataController>();
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

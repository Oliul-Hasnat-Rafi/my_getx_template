extension MapExtension on Map<String, dynamic> {
  bool customOkay<T>(String parameterName) {
    if (this[parameterName] == null) return false;

    return this[parameterName] is T;
  }

  List<Map<String, dynamic>> customToMapList(String parameterName) {
    if (!customOkay<List>(parameterName)) return [];

    List<Map<String, dynamic>> res = [];
    for (Map<String, dynamic> i in this[parameterName]) {
      res.add(i);
    }

    return res;
  }

  List<T> customToList<T>(String parameterName) {
    if (!customOkay<List>(parameterName)) return [];

    List<T> res = [];
    for (T i in this[parameterName]) {
      res.add(i);
    }

    return res;
  }
}

class TypesHelper {
  static int toInt(num val) {
    try {
      if (val == null) {
        return 0;
      }
      if (val is int) {
        return val;
      } else {
        return val.toInt();
      }
    } catch (error) {
      print('Error');
      return 0;
    }
  }
}

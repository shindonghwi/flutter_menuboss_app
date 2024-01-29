class CollectionUtil{

  static bool isNullEmptyFromString(String? data){
    if (data == null || data.isEmpty || data == "null") {
      return true;
    }
    return false;
  }

  static bool isNullorEmpty(List<dynamic>? items){
    if (items == null || items.isEmpty) {
      return true;
    }
    return false;
  }

  static bool isEqualLowerCase(String str1, String str2){
    return str1.toLowerCase() == str2.toLowerCase();
  }


}
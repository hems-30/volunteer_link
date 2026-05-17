class Validators {
  static String? requiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  static String? minLength(String? value, String fieldName, int minLength) {
    if (value == null || value.trim().length < minLength) {
      return "$fieldName must be at least $minLength characters";
    }
    return null;
  }

  static String? requiredDropdown(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "Please select $fieldName";
    }
    return null;
  }

  static String? description(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Description is required";
    }
    if (value.trim().length < 10) {
      return "Description must be at least 10 characters";
    }
    return null;
  }

  static String? title(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Title is required";
    }
    if (value.trim().length < 3) {
      return "Title must be at least 3 characters";
    }
    return null;
  }
}
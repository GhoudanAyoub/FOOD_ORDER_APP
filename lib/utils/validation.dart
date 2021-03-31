class Validations {
  static String validateName(String value) {
    if (value.isEmpty) return 'Username is Required.';
    final RegExp nameExp = new RegExp(r'^[A-za-zğüşöçİĞÜŞÖÇ ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }

  static String validateEmail(String value, [bool isRequried = true]) {
    if (value.isEmpty && isRequried) return 'Email is required.';
    final RegExp nameExp = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (!nameExp.hasMatch(value) && isRequried) return 'Invalid email address';
    return null;
  }

  static String validatePassword(String value) {
    if (value.isEmpty || value.length < 8)
      return 'Password length Should be < 8';
    return null;
  }

  static String validatePassword2(String value, String v2) {
    if (value.isEmpty || value.length < 8)
      return 'Password length Should be < 8';
    else if (!value.contains(v2)) return 'Password not Correct';
    return null;
  }
}

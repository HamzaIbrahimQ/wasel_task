
/// This class for all text fields types validators
class Validators {
  static final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  static final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*\W).{8,}$');

  static String? validateEmail(String? v) {
    if (v == null || v.isEmpty) return 'Email required';
    if (!emailRegex.hasMatch(v)) return 'Enter a valid email';
    return null;
  }

  static String? validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Password required';
    if (!passwordRegex.hasMatch(v)) {
      return 'Min 8 chars, 1 uppercase, 1 number & 1 symbol';
    }
    return null;
  }
}

class Validators {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    
    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    
    return null;
  }

  static String? validateNoteContent(String? content) {
    if (content == null || content.trim().isEmpty) {
      return 'Note content cannot be empty';
    }
    
    if (content.trim().length < 3) {
      return 'Note must be at least 3 characters long';
    }
    
    return null;
  }
}
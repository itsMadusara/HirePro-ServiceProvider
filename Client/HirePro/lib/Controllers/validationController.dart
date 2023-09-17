class ValidationController {
  String? nameValidator(String? name) {
    if (name!.isEmpty) {
      return "Name can't be empty";
    }

    if (!RegExp(r"^[A-Za-z]+(?: [A-Za-z]+)*$").hasMatch(name)) {
      return "Please enter a valid name";
    }
    return null;
  }

  String? phoneValidator(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'This field is required';
    }

    if (!RegExp(r"^[0]{1}[7]{1}[01245678]{1}[0-9]{7}$").hasMatch(phone)) {
      return "Please enter a valid phone number";
    }
    if (phone.length != 10) {
      return "Phone number is not valid";
    }
    return null;
  }

  String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return 'This field is required';
    }

    // using regular expression
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(email)) {
      return "Please enter a valid email address";
    }

    // the email is valid
    return null; // Return null when there are no errors
  }

  String? passwordValidator(String? password) {
    if (password == null) {
      return "Password can't be empty";
    }
    if (password.length < 8) {
      return "Password must be at least 8 characters long.";
    }

    bool hasDigit = false;
    bool hasSpecialChar = false;

    for (int i = 0; i < password.length; i++) {
      if (password[i].contains(RegExp(r'[0-9]'))) {
        hasDigit = true;
      } else if (password[i].contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        hasSpecialChar = true;
      }

      if (hasDigit && hasSpecialChar) {
        return null;
      }
    }

    if (!hasDigit) {
      return "Password must contain at least one digit.";
    }

    if (!hasSpecialChar) {
      return "Password must contain at least one special character.";
    }

    return null;
  }

  String? nicValidator(String? nic) {
    int minVal = 10;
    if (nic == null || nic.isEmpty) {
      return 'This field is required';
    }else if(nic.length < minVal){
      return 'NIC number is less than $minVal digits';
    }else if(nic.length == 10 || nic.length == 12){
      if (!RegExp(r'^(?:19|20)?\d{2}[0-9]{10}|[0-9]{9}[x|X|v|V]$').hasMatch(nic))
        return 'Enter Valid NIC';
      else
        return null;
    }else{
      return 'Invalid value';
    }
  }
}

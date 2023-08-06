class Validator {
  static const String PHONE_REGEX =
      r'^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$';

  static const String AGE_REGEX = r'/^100|[1-9]?\d$/';

  static String? age(String? age) {
    if (age == null) return 'Age cannot be empty';

    if (age.isEmpty ||
        age.length >= 100 ||
        !age.contains(RegExp(r'^[0-9]+$'))) {
      return 'Age must be in the right format';
    }

    return null;
  }

  static String? username(String? uname) {
    if (uname == null) {
      return 'field cannot be null';
    }
    if (uname.isEmpty) {
      return 'field cannot be null';
    }

    return null;
  }

  static String? phone(String? phone) {
    if (phone == null) return 'Phone number cannot be empty';
    if (phone.length != 10) {
      return 'Phone number must be 10 digit number';
    }
    if (!RegExp(PHONE_REGEX).hasMatch(phone)) {
      return 'Phone number must be in the right format';
    }
    return null;
  }

  static String? amount(String? amount) {
    if (amount == null) return 'Amount cannot be empty';
    if (amount.isEmpty) {
      return 'Amount cannot be empty';
    }
    if (amount.toString().length > 7) {
      return 'Amount cannot be greater than 7 digit';
    }

    return null;
  }
}

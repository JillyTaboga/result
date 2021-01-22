import 'package:flutter/services.dart';

DateTime dateFromDateInput(String dateInput) {
  if (dateInput.length > 9) {
    int day = int.tryParse(dateInput.substring(0, 2));
    int month = int.tryParse(dateInput.substring(3, 5));
    int year = int.tryParse(dateInput.substring(6, 10));
    return DateTime(year, day, month);
  } else {
    return null;
  }
}

class CepInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText;
    String newReplaced = newValue.text.replaceAll(RegExp("[^0-9]"), '');
    if (newReplaced.length == 0) {
      newText = '';
    } else if (newReplaced.length < 6) {
      newText = newReplaced;
    } else if (newReplaced.length < 9) {
      newText = newReplaced.substring(0, 5) +
          '-' +
          newReplaced.substring(5, newReplaced.length);
    } else {
      newText = newReplaced.substring(0, 5) + '-' + newReplaced.substring(5, 8);
    }
    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

class PhoneInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText;
    String newReplaced;
    if (newValue.text.contains('(') && !newValue.text.contains(')')) {
      newReplaced = newValue.text.substring(1, newValue.text.length - 1);
    } else {
      newReplaced = newValue.text;
    }
    newReplaced = newReplaced.replaceAll(RegExp("[^0-9]"), '');
    String ddd;
    String first;
    String last;

    if (newReplaced.length == 0) {
      newText = '';
    }
    if (newReplaced.length > 0) {
      int sub = newReplaced.length < 2 ? newReplaced.length : 2;
      ddd = '(' + newReplaced.substring(0, sub) + ')';
      newText = ddd;
    }
    if (newReplaced.length > 2 && newReplaced.length < 11) {
      int sub = newReplaced.length < 7 ? newReplaced.length : 6;
      first = ' ' + newReplaced.substring(2, sub);
      newText = ddd + first;
    }
    if (newReplaced.length > 6 && newReplaced.length < 11) {
      int sub = newReplaced.length < 11 ? newReplaced.length : 10;
      last = '-' + newReplaced.substring(6, sub);
      newText = ddd + first + last;
    }
    if (newReplaced.length > 2 && newReplaced.length > 10) {
      int sub = newReplaced.length < 8 ? newReplaced.length : 7;
      first = ' ' + newReplaced.substring(2, sub);
      newText = ddd + first;
    }
    if (newReplaced.length > 7 && newReplaced.length > 10) {
      int sub = newReplaced.length < 12 ? newReplaced.length : 11;
      last = '-' + newReplaced.substring(7, sub);
      newText = ddd + first + last;
    }

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

class CnpjInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newReplaced = newValue.text.replaceAll(RegExp("[^0-9]"), '');
    String newText;

    String first2;
    String second3;
    String third3;
    String mil4;
    String dv2;

    if (newReplaced.length == 0) {
      newText = '';
    }
    if (newReplaced.length > 0) {
      int sub = newReplaced.length < 2 ? newReplaced.length : 2;
      first2 = newReplaced.substring(0, sub);
      newText = first2;
    }
    if (newReplaced.length > 2) {
      int sub = newReplaced.length < 5 ? newReplaced.length : 5;
      second3 = '.' + newReplaced.substring(2, sub);
      newText = first2 + second3;
    }
    if (newReplaced.length > 5) {
      int sub = newReplaced.length < 8 ? newReplaced.length : 8;
      third3 = '.' + newReplaced.substring(5, sub);
      newText = first2 + second3 + third3;
    }
    if (newReplaced.length > 8) {
      int sub = newReplaced.length < 12 ? newReplaced.length : 12;
      mil4 = '/' + newReplaced.substring(8, sub);
      newText = first2 + second3 + third3 + mil4;
    }
    if (newReplaced.length > 12) {
      int sub = newReplaced.length < 14 ? newReplaced.length : 14;
      dv2 = '-' + newReplaced.substring(12, sub);
      newText = first2 + second3 + third3 + mil4 + dv2;
    }

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

class CpfInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newReplaced = newValue.text.replaceAll(RegExp("[^0-9]"), '');
    String newText;

    String first3;
    String second3;
    String third3;
    String dv2;

    if (newReplaced.length == 0) {
      newText = '';
    }
    if (newReplaced.length > 0) {
      int sub = newReplaced.length < 3 ? newReplaced.length : 3;
      first3 = newReplaced.substring(0, sub);
      newText = first3;
    }
    if (newReplaced.length > 3) {
      int sub = newReplaced.length < 5 ? newReplaced.length : 6;
      second3 = '.' + newReplaced.substring(3, sub);
      newText = first3 + second3;
    }
    if (newReplaced.length > 6) {
      int sub = newReplaced.length < 9 ? newReplaced.length : 9;
      third3 = '.' + newReplaced.substring(6, sub);
      newText = first3 + second3 + third3;
    }
    if (newReplaced.length > 9) {
      int sub = newReplaced.length < 11 ? newReplaced.length : 11;
      dv2 = '-' + newReplaced.substring(9, sub);
      newText = first3 + second3 + third3 + dv2;
    }

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

class DateInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newReplaced = newValue.text.replaceAll(RegExp("[^0-9]"), '');
    String newText;

    String first2;
    String second2;
    String third4;

    if (newReplaced.length == 0) {
      newText = '';
    }
    if (newReplaced.length > 0) {
      int sub = newReplaced.length < 2 ? newReplaced.length : 2;
      first2 = newReplaced.substring(0, sub);
      newText = first2;
    }
    if (newReplaced.length > 2) {
      int sub = newReplaced.length < 4 ? newReplaced.length : 4;
      second2 = '/' + newReplaced.substring(2, sub);
      newText = first2 + second2;
    }
    if (newReplaced.length > 4) {
      int sub = newReplaced.length < 8 ? newReplaced.length : 8;
      third4 = '/' + newReplaced.substring(4, sub);
      newText = first2 + second2 + third4;
    }

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

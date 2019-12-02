import 'dart:async';

class Validators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (email.contains('@') && email.contains('.')) {
        sink.add(email);
      } else if (email.length > 0) {
        sink.addError('Enter a valid email');
      }
  });
  final validatePwd = StreamTransformer<String, String>.fromHandlers(
    handleData: (pwd, sink) {
      if (pwd.length > 6) {
        sink.add(pwd);
      } else {
        sink.addError('Password needs to be at least 6 characters');
      }
  });
}
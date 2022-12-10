// 이메일 유효성 검사
String? emailValidate(String? value) {
      RegExp reg = RegExp(r'^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
      bool isEmailValidate =
          (value == null || value.isEmpty || !reg.hasMatch(value));

      if (isEmailValidate) return '알맞은 이메일 정보를 입력해주세요';

      return null;
    }

//비밀번호 유효성 검사
String? passwordValidate(String? value) {
  RegExp reg = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$');
  bool isEmailValidate =
      (value == null || value.isEmpty || !reg.hasMatch(value));

  if (isEmailValidate) return '8-15자리 영대소문자, 특수문자,숫자 조합으로 입력해주세요';

  return null;
}

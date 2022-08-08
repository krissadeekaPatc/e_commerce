class TextFieldModel {
  const TextFieldModel(
      {this.text = "",
      this.errorMessage = "",
      this.isValidate = true,
      this.title = "",
      this.code = "",
      this.isSecureText = true});

  final String title;
  final String text;
  final String code;
  final bool isValidate;
  final String errorMessage;
  final bool isSecureText;
}

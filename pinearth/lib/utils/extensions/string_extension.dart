extension StringExtension on String {
  String get addRemotePath => "http://res.cloudinary.com/dkykwpryb/$this";
  String get svg => "assets/svgs/$this.svg";
  String get png => "assets/images/$this.png";
  String get addCountryCode {
    String num = this;
    if (num.startsWith("0")) {
      num = num.substring(1, num.length);
    }
    return '+234$num';
  }
  String capitalizeFirst() {
    if (isEmpty) return this;
    if (length == 1) return toUpperCase();
    return "${this[0].toUpperCase()}${substring(1, length)}";
  }
  String addHttp() {
    if (isEmpty) return this;
    if (startsWith("http")) return this;
    return "http://$this";
  }
}
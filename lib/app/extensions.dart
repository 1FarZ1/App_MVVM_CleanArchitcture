extension TestEXTENSION on String? {
  String orEmpty() {
    if(this == null) return "";
    return this!;
  }
}
extension  IntTEST on int? {
  int orZero() {
    if(this == null) return 0;
    return this!;
  }
}
DateTime dateConvert(String date) {
  return DateTime(
    int.parse(date.split('-')[2]),
    int.parse(date.split('-')[1]),
    int.parse(date.split('-')[0]),
  );
}

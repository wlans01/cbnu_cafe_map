String rentalPeriod(String rentalDate) {
  final List<String> dataSplit = rentalDate.split('T');
  final List<String> dateStr = dataSplit[0].split('-');
  final List<String> timeStr = dataSplit[1].split(':');

  final now = DateTime.now();
  final returnDate = DateTime.parse(rentalDate).add(Duration(days: 3));
  final dataDifference = returnDate.difference(now);
  return '$dataDifference';
}

String rentalDateFormatter(String rentalDate) {
  final List<String> dataSplit = rentalDate.split('T');
  final List<String> dateStr = dataSplit[0].split('-');
  final List<String> timeStr = dataSplit[1].split(':');
  return '${dateStr[1]}월 ${dateStr[2]}일 ${timeStr[0]}:${timeStr[1]}';
}

class OrderHistory {
  final String orderId;
  final String residentName;
  final String location;
  final String date;
  final String time;
  final String status;

  const OrderHistory({
    required this.orderId,
    required this.residentName,
    required this.location,
    required this.date,
    required this.time,
    required this.status,
  });
}

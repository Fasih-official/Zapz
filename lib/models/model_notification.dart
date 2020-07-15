class NotificationModel {
  final String title;
  final String subtitle;
  final String deviceId;

  NotificationModel(this.title, this.subtitle, this.deviceId);

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      json['title'] as String,
      json['subtitle'] as String,
      json['deviceId'] as String,
    );
  }
}

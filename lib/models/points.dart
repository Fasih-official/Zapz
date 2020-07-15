class Points {

  final int id;
  final String type;
  final String title;
  final String subtitle;
  final String image;
  final String offer_one;
  final String offer_two;
  final String video_link;
  final String status;
  final String description;
  final String address;
  final String phone;
  final double lat;
  final double long;
  final String service;
  final int category_id;
  final bool favorite;
  final String date;

  Points({this.id, this.type, this.title, this.subtitle,this.image, this.offer_one,
      this.offer_two, this.video_link, this.status, this.description,
      this.address, this.phone, this.lat, this.long, this.service,
      this.category_id, this.favorite, this.date});

  factory Points.fromJson(Map<String, dynamic> parsedJson){

    return Points(
      id: parsedJson['id'] as int ?? -1,
      type: parsedJson['type'] as String ?? 'General',
      title: parsedJson['title'] as String ?? 'General Point',
      subtitle: parsedJson['subtitle'] as String ?? 'General Point Description',
      image: parsedJson['image'] as String ?? '',
      offer_one: parsedJson['offer_one'] as String ?? '',
      offer_two: parsedJson['offer_two'] as String ?? '',
      video_link: parsedJson['video_link'] as String ?? '',
      status: parsedJson['status'] as String ?? '',
      description: parsedJson['description'] as String ?? '',
      address: parsedJson['address'] as String ?? 'No address associated with this point of sale',
      phone: parsedJson['phone'] as String ?? 'No contact info available',
      lat: parsedJson['lat'] as double ?? 0,
      long: parsedJson['long'] as double ?? 0,
      service: parsedJson['service'] as String ?? '',
      category_id: parsedJson['category_id'] as int ?? -1,
      favorite: parsedJson['favorite'] as bool ?? false,
      date: parsedJson['date'] as String ?? '',
    );
  }
}
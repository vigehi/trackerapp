class Activity {
  final String key;
  final String name;
  final String type;
  final double accessibility;
  final int participants;
  final double price;

  Activity({
    required this.key,
    required this.name,
    required this.type,
    required this.accessibility,
    required this.participants,
    required this.price,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      key: json['key'],
      name: json['activity'],
      type: json['type'],
      accessibility: json['accessibility'].toDouble(),
      participants: json['participants'],
      price: json['price'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'activity': name,
      'type': type,
      'accessibility': accessibility,
      'participants': participants,
      'price': price,
    };
  }
}

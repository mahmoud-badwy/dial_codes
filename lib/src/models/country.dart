/// Model class representing a country with its details
class Country {
  /// The full name of the country
  final String name;

  /// The ISO 3166-1 alpha-2 country code
  final String code;

  /// The emoji flag representation of the country
  final String emoji;

  /// The unicode representation of the country flag
  final String unicode;

  /// The international dialing code(s) for the country
  final String dialCode;

  /// The URL to the country's flag image
  final String image;

  const Country({
    required this.name,
    required this.code,
    required this.emoji,
    required this.unicode,
    required this.dialCode,
    required this.image,
  });

  /// Creates a Country instance from a JSON map
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] as String,
      code: json['code'] as String,
      emoji: json['emoji'] as String,
      unicode: json['unicode'] as String,
      dialCode: json['dial_code'] as String,
      image: json['image'] as String,
    );
  }

  /// Converts the Country instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'emoji': emoji,
      'unicode': unicode,
      'dial_code': dialCode,
      'image': image,
    };
  }

  @override
  String toString() {
    return 'Country(name: $name, code: $code, dialCode: $dialCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Country &&
        other.name == name &&
        other.code == code &&
        other.emoji == emoji &&
        other.unicode == unicode &&
        other.dialCode == dialCode &&
        other.image == image;
  }

  @override
  int get hashCode {
    return Object.hash(
      name,
      code,
      emoji,
      unicode,
      dialCode,
      image,
    );
  }

  /// Creates a copy of this Country with the given fields replaced
  Country copyWith({
    String? name,
    String? code,
    String? emoji,
    String? unicode,
    String? dialCode,
    String? image,
  }) {
    return Country(
      name: name ?? this.name,
      code: code ?? this.code,
      emoji: emoji ?? this.emoji,
      unicode: unicode ?? this.unicode,
      dialCode: dialCode ?? this.dialCode,
      image: image ?? this.image,
    );
  }
}

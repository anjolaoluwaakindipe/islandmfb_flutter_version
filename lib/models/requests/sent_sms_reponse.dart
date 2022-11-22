// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SentSmsResponse {
  bool sentOK;

  SentSmsResponse({
    required this.sentOK,
  });

  SentSmsResponse copyWith({
    bool? sentOK,
  }) {
    return SentSmsResponse(
      sentOK: sentOK ?? this.sentOK,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sentOK': sentOK,
    };
  }

  factory SentSmsResponse.fromMap(Map<String, dynamic> map) {
    return SentSmsResponse(
      sentOK: map['sentOK'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory SentSmsResponse.fromJson(String source) =>
      SentSmsResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SentSmsResponse(sentOK: $sentOK)';

  @override
  bool operator ==(covariant SentSmsResponse other) {
    if (identical(this, other)) return true;

    return other.sentOK == sentOK;
  }

  @override
  int get hashCode => sentOK.hashCode;
}

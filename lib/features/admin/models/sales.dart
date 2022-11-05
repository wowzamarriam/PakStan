// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Sales {
  final String label;
  final int earning;

  Sales(this.label, this.earning);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'label': label,
      'earning': earning,
    };
  }

  factory Sales.fromMap(Map<String, dynamic> map) {
    return Sales(
      map['label'] as String,
      map['earning'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Sales.fromJson(String source) => Sales.fromMap(json.decode(source) as Map<String, dynamic>);
}

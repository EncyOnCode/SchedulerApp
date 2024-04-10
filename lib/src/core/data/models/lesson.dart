import 'package:flutter/foundation.dart';

@immutable
base class Lesson {

  factory Lesson.fromJson(Map<String, Object?> map) {
    return Lesson(
      name: map['name']! as String,
      teachers: (map['teachers']! as List).map((e) => e as String).toList(),
      startTime: Duration(seconds: map['startTime']! as int),
      endTime: Duration(seconds: map['endTime']! as int),
      notes: map['notes'] as String?,
      room: map['room'] as String?,
    );
  }
  const Lesson({
    required this.name,
    this.teachers = const [],
    required this.startTime,
    required this.endTime,
    this.notes,
    this.room,
  });

  final String name;

  final List<String> teachers;

  final Duration startTime;

  final Duration endTime;

  final String? notes;

  final String? room;

  Lesson copyWith({
    String? name,
    List<String>? teachers,
    Duration? startTime,
    Duration? endTime,
    String? notes,
    String? room,
  }) =>
      Lesson(
        name: name ?? this.name,
        teachers: teachers ?? this.teachers,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        notes: notes ?? this.notes,
        room: room ?? this.room,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Lesson &&
              name == other.name &&
              teachers == other.teachers &&
              startTime == other.startTime &&
              endTime == other.endTime &&
              notes == other.notes &&
              room == other.room;

  @override
  int get hashCode =>
      name.hashCode ^ teachers.hashCode ^ startTime.hashCode ^ endTime.hashCode ^ notes.hashCode ^ room.hashCode;

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'teachers': teachers,
      'startTime': startTime.inSeconds,
      'endTime': endTime.inSeconds,
      'notes': notes,
      'room': room,
    };
  }
}
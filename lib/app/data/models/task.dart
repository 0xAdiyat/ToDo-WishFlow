import 'dart:convert';
import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final int icon;
  final String color;
  final List<dynamic>? todos;

  const Task(
      {required this.title,
      required this.icon,
      required this.color,
      this.todos});

  /// bcz of using [const] keyword on [Task] class, we can't change it.
  /// There for in order to edit it `later on`
  /// we are using another method called [copyWith] to create a new `instance`
  /// so that we could replace the `existing task`

  Task copyWith({
    String? title,
    int? icon,
    String? color,
    List<dynamic>? todos,
  }) // returning new task
      =>
      Task(
        title: title ?? this.title,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        todos: todos ?? this.todos,
      );

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        title: json['title'],
        icon: json['icon'],
        color: json['color'],
        todos: json['todos'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'icon': icon,
        'color': color,
        'todos': todos,
      };
      
        @override
        // TODO: implement props
        List<Object?> get props => [title, icon, color];
}

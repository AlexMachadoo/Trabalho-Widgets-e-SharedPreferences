class Task {
  String? title;
  String? description;
  bool isDone;
  String priority;

  Task({
    this.title,
    this.description,
    this.isDone = false,
    this.priority = 'Baixa',
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'] as String?,
      description: json['description'] as String?,
      isDone: json['isDone'] as bool? ?? false,
      priority: json['priority'] as String? ?? 'Baixa',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
      'priority': priority,
    };
  }
}

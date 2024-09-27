class TrainingModel {
  final String id;
  final String title;
  final String description;
  final int duration; // Duração em horas ou minutos
  final bool isCompleted;
  final double progress;

  TrainingModel({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.isCompleted,
    required this.progress,
  });

  // Converte o modelo para um mapa (usado ao salvar no Firebase)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'duration': duration,
      'isCompleted': isCompleted,
      'progress': progress,
    };
  }

  // Cria um modelo a partir de um mapa do Firebase
  factory TrainingModel.fromMap(Map<String, dynamic> map) {
    return TrainingModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      duration: map['duration'] ?? 0,
      isCompleted: map['isCompleted'] ?? false,
      progress: map['progress']?.toDouble() ?? 0.0,
    );
  }
}

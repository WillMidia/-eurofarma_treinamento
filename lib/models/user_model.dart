class UserModel {
  final String id;
  final String name;
  final String email;
  final String role; // Exemplo: 'Funcionário' ou 'RH'
  final bool isAuthorized;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.isAuthorized,
  });

  // Converte o modelo para um mapa (usado ao salvar no Firebase)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'isAuthorized': isAuthorized,
    };
  }

  // Cria um modelo a partir de um mapa do Firebase
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? '',
      isAuthorized: map['isAuthorized'] ?? false,
    );
  }
}

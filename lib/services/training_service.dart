import 'package:cloud_firestore/cloud_firestore.dart';

class TrainingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Adicionar um módulo de treinamento
  Future<void> addTrainingModule(String title, String description, String cargo) async {
    try {
      await _firestore.collection('trainings').add({
        'title': title,
        'description': description,
        'cargo': cargo,
      });
    } catch (e) {
      print('Erro ao adicionar módulo de treinamento: $e');
    }
  }

  // Listar módulos de treinamento para um cargo específico
  Stream<QuerySnapshot> getTrainingsForCargo(String cargo) {
    return _firestore
        .collection('trainings')
        .where('cargo', isEqualTo: cargo)
        .snapshots();
  }

  // Atualizar progresso de treinamento para o colaborador
  Future<void> updateTrainingProgress(String userId, String trainingId, double progress) async {
    try {
      await _firestore
          .collection('userTrainings')
          .doc(userId)
          .collection('trainings')
          .doc(trainingId)
          .set({'progress': progress});
    } catch (e) {
      print('Erro ao atualizar progresso do treinamento: $e');
    }
  }

  // Obter o progresso do treinamento
  Stream<DocumentSnapshot> getTrainingProgress(String userId, String trainingId) {
    return _firestore
        .collection('userTrainings')
        .doc(userId)
        .collection('trainings')
        .doc(trainingId)
        .snapshots();
  }
}

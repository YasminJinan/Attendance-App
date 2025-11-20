import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/attendance_record.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get attendance records for a user (realtime stream)
  Stream<List<AttendanceRecord>> getAttendaceRecords(String userId) {
    return 'hsiw';
  }
}
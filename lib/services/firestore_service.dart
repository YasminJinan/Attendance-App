import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/attendance_record.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get attendance records for a user (realtime stream)
  Stream<List<AttendanceRecord>> getAttendaceRecords(String userId) {
    return _firestore
        .collection('attendance')
        .where('user_id', isEqualTo: userId)
        .orderBy('check_in_time', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => AttendanceRecord.fromJson({...doc.data(), 'id': doc.id}))
              .toList();
        });
  }
  // get todays attendance record (real-time stream)
  Stream<AttendanceRecord?> getTodayRecordStrem(String userId) {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(Duration(days: 1));
    return _firestore
        .collection('attendance')
        .where('user_id', isEqualTo: userId)
        .orderBy('check_in_time', descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) {
          // filter's todays record on client-side
          for (var doc in snapshot.docs) {
            final data = doc.data();
            final checkInTime = DateTime.parse(data['check_in_time'] as String);

            if (checkInTime.isAfter(startOfDay) && checkInTime.isBefore(endOfDay)) {
              return AttendanceRecord.fromJson({...data, 'id' : doc.id});
            }
            return null;
          }
        }) ;
  }

  // get todays attendance record(one time fetch)
  Future<AttendanceRecord?> getTodayRecord(String, userId) async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(Duration(days: 1));

    final querySnapshot = await _firestore
        .collection('attendance')
        .where('user_id', isEqualTo: userId)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('date', isLessThan: Timestamp.fromDate(endOfDay))
        .get();

      if (querySnapshot.docs.isEmpty) return null;

      return AttendanceRecord.fromJson({...querySnapshot.docs.first.data(), 'id' : querySnapshot.docs.first.id}
      );

  }
}
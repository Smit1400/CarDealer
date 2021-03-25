import 'package:car_dealer/models/car_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:car_dealer/services/firebase_auth.dart';
import 'package:intl/intl.dart';


class FirebaseMethods {
  static final firestore = FirebaseFirestore.instance;
FirebaseServices _firebaseServices = FirebaseServices();
  Stream<List<CarDetails>> getAllCars() {
    print("[INFO] Getting all the cars from the database.");
    String path = "Cars/";
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        snapshot.docs.map((doc) => CarDetails.fromMap(doc.data())).toList());
  }

  Future<void> addCarDetailsToDb(CarDetails carDetails) async {
    try {
      print("[INFO] Storing new car details");
      await firestore
          .collection("Cars")
          .doc(carDetails.carId)
          .set(carDetails.toMap());
      print("[INFO] Stored new car details");
    } on FirebaseException catch (e) {
      print("[ERROR] ${e.message}");
      throw FirebaseException(
        message: e.message,
        plugin: e.plugin,
        code: e.code,
      );
    } catch (e) {
      print("[ERROR] ${e.toString()}");
      throw e.toString();
    }
  }
    Future<void> addCarToWishlist(String CarId) async {
    try {
      print("[INFO] Storing car id to wishlist");
         final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);
          await _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Wishlist")
        .doc(CarId)
        .set({"date": formatted});
      print("[INFO] Stored car id in wishlist");
    } on FirebaseException catch (e) {
      print("[ERROR] ${e.message}");
      throw FirebaseException(
        message: e.message,
        plugin: e.plugin,
        code: e.code,
      );
    } catch (e) {
      print("[ERROR] ${e.toString()}");
      throw e.toString();
    }
  }

  Future<void> getACarDetail(String carId) async {
    try {
      print("[INFO] Fetching car details for carId $carId");
      String path = "Cars/$carId";
      final data = await firestore.doc(path).get().then((value) {
        print("[INFO] Car Data = ${value.data()}");
        return CarDetails.fromMap(value.data());
      });
      return data;
    } on FirebaseException catch (e) {
      print("[ERROR] Erro while fetching ${e.code}");
      throw FirebaseException(
          plugin: e.plugin, code: e.code, message: e.message);
    } catch (e) {
      print("[ERROR] Erro while fetching ${e.toString()}");
      throw e.toString();
    }
  }

  Future<void> updateCarDetails(CarDetails carDetails) async {
    try {
      print("[INFO] Updating car with id = ${carDetails.carId}");
      String path = "Cars/${carDetails.carId}";
      print("[INFO] Updated car data = ${carDetails.toMap()}");
      await FirebaseFirestore.instance.doc(path).update(carDetails.toMap());
    } on FirebaseException catch (e) {
      print("[ERROR] Erro while updating ${e.code}");
      throw FirebaseException(
          plugin: e.plugin, code: e.code, message: e.message);
    } catch (e) {
      print("[ERROR] Erro while updating ${e.toString()}");
      throw e.toString();
    }
  }

  Future<void> deleteCar(String carId) async {
    try {
      print("[INFO] Car id = $carId");
      String path = "Cars/$carId/";
      await FirebaseFirestore.instance.doc(path).delete();
    } on FirebaseException catch (e) {
      print("[ERROR] Erro while deleting ${e.code}");
      throw FirebaseException(
          plugin: e.plugin,
          code: e.code,
          message: "Some error occurred while updating group try again later");
    } catch (e) {
      print("[ERROR] Erro while deleting ${e.toString()}");
      throw e.toString();
    }
  }

  
}

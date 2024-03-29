import 'package:car_dealer/models/car_details.dart';
import 'package:car_dealer/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:car_dealer/services/firebase_auth.dart';
import 'package:intl/intl.dart';

class FirebaseMethods {
  static final firestore = FirebaseFirestore.instance;

  FirebaseServices _firebaseServices = FirebaseServices();
  String getUserId() {
    return _firebaseServices.getUserId();
  }

  Stream<List<CarDetails>> getAllCars() {
    print("[INFO] Getting all the cars from the database.");
    String path = "Cars/";
    final reference = firestore.collection(path).where(
          "isSold",
          isEqualTo: false,
        );
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        snapshot.docs.map((doc) => CarDetails.fromMap(doc.data())).toList());
  }

  Future<List<CarDetails>> getAllSoldCars() {
    print("[INFO] Getting all the cars from the database.");
    String path = "Cars/";
    final reference = firestore.collection(path).where(
          "isSold",
          isEqualTo: true,
        );
    final snapshots = reference.snapshots();
    return snapshots
        .map((snapshot) =>
            snapshot.docs.map((doc) => CarDetails.fromMap(doc.data())).toList())
        .first;
  }

  Future<List<CarDetails>> getCars() async {
    print("[INFO] Getting all the cars from the database.");
    String path = "Cars/";
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return await snapshots
        .map((snapshot) =>
            snapshot.docs.map((doc) => CarDetails.fromMap(doc.data())).toList())
        .first;
  }

  Future<List<User>> getUsers() async {
    print("[INFO] Getting all the users from the database.");
    String path = "Users/";
    final reference = FirebaseFirestore.instance.collection(path);
    final data = await reference.get();
    final finalData = data.docs.map((doc) => User.fromMap(doc.data())).toList();
    return finalData;
    // final snapshots = reference.snapshots();
    // return await snapshots
    //     .map((snapshot) =>
    //         snapshot.docs.map((doc) => User.fromMap(doc.data())).toList())
    //     .first;
  }

  Stream<List<CarDetails>> getAllFilteredCars(
      {int minPrice,
      int maxPrice,
      List brands,
      String ownerType,
      String transmissionType,
      String fuelType}) {
    print("[INFO] Getting all the filtered cars from the database.");
    String path = "Cars/";
    CollectionReference col = firestore.collection(path);
    print("minprice:" + minPrice.toString());
    print("maxprice:" + maxPrice.toString());
    Query query1 = col
        .where("isSold", isEqualTo: false)
        .where("approved", isEqualTo: true)
        .where("price", isGreaterThanOrEqualTo: minPrice.toDouble())
        .where("price", isLessThanOrEqualTo: maxPrice.toDouble());
    if (ownerType != "") {
      query1 = query1.where("owner_type", isEqualTo: ownerType);
    }
    if (transmissionType != "") {
      query1 = query1.where("transmissionType", isEqualTo: transmissionType);
    }
    if (fuelType != "") {
      query1 = query1.where("fuel_type", isEqualTo: fuelType);
    }
    if (brands.isNotEmpty) {
      query1 = query1.where("brand", whereIn: brands);
    }
    query1 = query1.orderBy("price");
    final snapshots1 = query1.snapshots();
    return snapshots1.map((snapshot) =>
        snapshot.docs.map((doc) => CarDetails.fromMap(doc.data())).toList());
  }

  Future<void> addCarDetailsToDb(
      CarDetails carDetails, List carList) async {
    try {
      print("[INFO] Storing new car details");
      await firestore
          .collection("Cars")
          .doc(carDetails.carId)
          .set(carDetails.toMap());
      print('---------------------');
      print(carDetails.userId);
      print(carList);
      print('------------------------');
      await firestore
          .collection("Users")
          .doc(carDetails.userId)
          .update({'car_list': carList}).then((a) {
        print("[INFO] User details updated.");
      });
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
      await firestore.doc(path).update(carDetails.toMap());
    } on FirebaseException catch (e) {
      print("[ERROR] Erro while updating ${e.code}");
      throw FirebaseException(
          plugin: e.plugin, code: e.code, message: e.message);
    } catch (e) {
      print("[ERROR] Erro while updating ${e.toString()}");
      throw e.toString();
    }
  }

  Future<void> carSold(String carId) async {
    try {
      print("[INFO] Updating car with id = $carId}");
      String path = "Cars/$carId";
      print(path);
      // print("[INFO] Updated car data = ${carDetails.toMap()}");
      await firestore
          .doc(path)
          .update({"isSold": true, "dateSold": DateTime.now().toString()});
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
      await firestore.doc(path).delete();
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

  //Wislist operations
  getAllCarsWishlist() {
    print("[INFO] Getting all the cars of wishlist from the database.");
    String path = "Users/";
    final reference = firestore
        .collection(path)
        .doc(_firebaseServices.getUserId())
        .collection("Wishlist");
    final snapshots = reference.snapshots();
    // return snapshots.toList();
    return snapshots
        .map((snapshot) => snapshot.docs.map((doc) => (doc.data)).toList());
  }

  Future<void> deleteCarFromWishlist(String carId) async {
    try {
      print("[INFO] Deleting car id from wishlist");
      print("[INFO] Car id = $carId");
      String userId = _firebaseServices.getUserId();
      print("[INFO] User id = $userId");
      String path = "Users/$userId/Wishlist/$carId/";
      print("[INFO] Path = $path");
      await firestore.doc(path).delete();
    } on FirebaseException catch (e) {
      print("[ERROR] Erro while deleting ${e.code}");
      throw FirebaseException(
          plugin: e.plugin,
          code: e.code,
          message: "Some error occurred while deleting try again later");
    } catch (e) {
      print("[ERROR] Erro while deleting ${e.toString()}");
      throw e.toString();
    }
  }

  Future<void> addCarToWishlist(String carId) async {
    try {
      print("[INFO] Storing car id to wishlist");
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String formatted = formatter.format(now);
      await _firebaseServices.usersRef
          .doc(_firebaseServices.getUserId())
          .collection("Wishlist")
          .doc(carId)
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

  Stream<List<CarDetails>> getSoldCarsUser() {
    print("[INFO] Getting all the cars from the database for particular user.");
    String path = "Cars/";
    String userId = _firebaseServices.getUserId();
    final reference = firestore
        .collection(path)
        .where(
          "userId",
          isEqualTo: userId,
        )
        .where(
          "isSold",
          isEqualTo: true,
        );
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        snapshot.docs.map((doc) => CarDetails.fromMap(doc.data())).toList());
  }

  Stream<List<CarDetails>> getSellCarsUser() {
    print("[INFO] Getting all the cars from the database for particular user.");
    String path = "Cars/";
    String userId = _firebaseServices.getUserId();
    final reference = firestore
        .collection(path)
        .where(
          "userId",
          isEqualTo: userId,
        )
        .where(
          "isSold",
          isEqualTo: false,
        );
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        snapshot.docs.map((doc) => CarDetails.fromMap(doc.data())).toList());
  }
}

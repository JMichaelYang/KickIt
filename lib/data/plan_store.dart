import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kickit/data/test_data/test_plans.dart';
import 'package:kickit/database/plan_package.dart';

/// A collection of methods that handle the loading and saving of [Plan]s to
/// and from Firebase.
abstract class IPlanStore {
  /// Loads the plan with the given [id], returns null if no such plan is
  /// found.
  Future<PlanPackage> loadPlan(String id);

  /// Saves the given [PlanPackage] to the database.
  Future<Null> savePlan(PlanPackage plan);

  /// Deletes the plan with the given [id], or does nothing if no such plan
  /// exists.
  Future<Null> deletePlan(String id);
}

/// Performs [IPlanStore] obligations with real remote data.
class PlanStore implements IPlanStore {
  // Database reference and key to access the correct collection.
  final Firestore firestore = Firestore.instance;
  static const String plansKey = "plans";

  @override
  Future<PlanPackage> loadPlan(String id) async {
    DocumentSnapshot snapshot;

    try {
      snapshot = await firestore.collection(plansKey).document(id).get();
    } catch (e) {
      return null;
    }

    // If the data couldn't be loaded, the given uid doesn't exist.
    if (snapshot == null || snapshot.data == null) {
      return null;
    }

    return new PlanPackage.fromMap(snapshot.data);
  }

  @override
  Future<Null> savePlan(PlanPackage plan) async {
    firestore.collection(plansKey).add(plan.toMap()).then((ref) async {
      PlanPackage idPlan = plan.copyWith(id: ref.documentID);
      await ref.setData(idPlan.toMap());
    });

    return null;
  }

  @override
  Future<Null> deletePlan(String id) {
    firestore.collection(plansKey).document(id).delete();
    return null;
  }
}

/// Performs [IPlanStore] obligations with local test data.
class MockPlanStore implements IPlanStore {
  @override
  Future<PlanPackage> loadPlan(String id) async {
    for (PlanPackage package in testPlans) {
      if (package.id == id) {
        return package;
      }
    }

    return null;
  }

  @override
  Future<Null> savePlan(PlanPackage plan) async {
    if (!testPlans.contains(plan)) {
      testPlans.add(plan);
    }
    return null;
  }

  @override
  Future<Null> deletePlan(String id) {
    for (int i = 0; i < testPlans.length; i++) {
      if (testPlans[i].id == id) {
        testPlans.removeAt(i);
        return null;
      }
    }

    return null;
  }
}

import 'package:expense_tracker/classes/mock.dart';
import 'package:expense_tracker/views/authentication.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test/test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

// For unit test purposes, the corresponding Firebase Auth Mocks and FirebasFirestoneMock has been used used to creates insatnces of both to check the functionality of the aurntication methods such as signin,signout,addTxtoDb.

void main() async {
  setupFirebaseAuthMocks();
  await Firebase.initializeApp();

  test('Returns no user if not signed in', () async {
    final auth = MockFirebaseAuth();
    final user = auth.currentUser;
    expect(user, isNull);
  });

  // testing the signin functionality
  test('testing signIn feature of authentication class with email and password',
      () async {
    final auth = MockFirebaseAuth();
    final instance = FakeFirebaseFirestore();
    final authenticator = Authenticator(auth, instance);
    final String res =
        await authenticator.signIn('some email', 'some password');
    expect(res, "Signed In");
  });

  test('testing signout function of authentication class', () async {
    final instance = FakeFirebaseFirestore();
    final auth = MockFirebaseAuth();
    final authenticator = Authenticator(auth, instance);

    final String res = await authenticator.signOut();
    expect(res, 'Signed out');
  });

  test(
      'checking addTxtoDb function of authentication class by upload data to firebase',
      () async {
    final instance = FakeFirebaseFirestore();
    final auth = MockFirebaseAuth();

    final authenticator = Authenticator(auth, instance);

    final String res =
        await authenticator.addTxtoDB('food', 'lunch', 123, DateTime.now());

    expect(res, 'Successful');
  });
}

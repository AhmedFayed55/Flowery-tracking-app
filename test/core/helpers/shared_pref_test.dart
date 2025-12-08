import 'package:flowery_tracking_app/core/helpers/shared_pref.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_pref_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late SharedPrefHelper sharedPrefHelper;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    sharedPrefHelper = SharedPrefHelper(mockSharedPreferences);
  });

  group('SharedPrefHelper Tests', () {
    test('saveData should call setInt when value is int', () async {
      when(
        mockSharedPreferences.setInt('age', 25),
      ).thenAnswer((_) async => true);

      final result = await sharedPrefHelper.saveData(key: 'age', val: 25);

      verify(mockSharedPreferences.setInt('age', 25)).called(1);
      expect(result, true);
    });

    test('saveData should call setDouble when value is double', () async {
      when(
        mockSharedPreferences.setDouble('height', 1.85),
      ).thenAnswer((_) async => true);

      final result = await sharedPrefHelper.saveData(key: 'height', val: 1.85);

      verify(mockSharedPreferences.setDouble('height', 1.85)).called(1);
      expect(result, true);
    });

    test('saveData should call setString when value is String', () async {
      when(
        mockSharedPreferences.setString('name', 'Ahmed'),
      ).thenAnswer((_) async => true);

      final result = await sharedPrefHelper.saveData(key: 'name', val: 'Ahmed');

      verify(mockSharedPreferences.setString('name', 'Ahmed')).called(1);
      expect(result, true);
    });

    test('saveData should call setBool when value is bool', () async {
      when(
        mockSharedPreferences.setBool('isLoggedIn', true),
      ).thenAnswer((_) async => true);

      final result = await sharedPrefHelper.saveData(
        key: 'isLoggedIn',
        val: true,
      );

      verify(mockSharedPreferences.setBool('isLoggedIn', true)).called(1);
      expect(result, true);
    });

    test('getData should return correct value', () {
      when(mockSharedPreferences.get('token')).thenReturn('abc123');

      final result = sharedPrefHelper.getData(key: 'token');

      verify(mockSharedPreferences.get('token')).called(1);
      expect(result, 'abc123');
    });

    test('removeData should call remove', () async {
      when(mockSharedPreferences.remove('token')).thenAnswer((_) async => true);

      final result = await sharedPrefHelper.removeData(key: 'token');

      verify(mockSharedPreferences.remove('token')).called(1);
      expect(result, true);
    });
  });
}

import 'dart:io';

class TestFixtures {
  TestFixtures._();
  static String read(String filename) =>
      File("test/test_fixtures/$filename").readAsStringSync();
}

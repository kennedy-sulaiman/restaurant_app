import 'dart:io';

String readFixtures(String name) =>
    File('test/fixtures/$name').readAsStringSync();

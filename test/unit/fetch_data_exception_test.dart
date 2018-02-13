import 'package:kickit/data/loader.dart';
import 'package:test/test.dart';

void main() {
  test("FetchDataException ToString Test", () {
    FetchDataException exception = new  FetchDataException("test");
    expect(exception.toString(), "Exception when fetching data: test");
  });
}
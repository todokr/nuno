import 'package:nuno/tabler/pull_request_plus.dart';
import 'package:test/test.dart';

void main() {
  group('weekNumberOf function',(){
    test('should start with Monday, and the first week should contain the first Thursday', () {
      expect(DateTime(2017, 1, 1).weekday, 7); //Sun
      expect(PullRequestPlus.weekNumberOf(DateTime(2017, 1, 1)), 0);
      expect(PullRequestPlus.weekNumberOf(DateTime(2017, 1, 4)), 1);
      expect(DateTime(2018, 1, 1).weekday, 1); //Mon
      expect(PullRequestPlus.weekNumberOf(DateTime(2018, 1, 1)), 1);
      expect(PullRequestPlus.weekNumberOf(DateTime(2018, 1, 4)), 1);
      expect(DateTime(2019, 1, 1).weekday, 2); //Tue
      expect(PullRequestPlus.weekNumberOf(DateTime(2019, 1, 1)), 1);
      expect(PullRequestPlus.weekNumberOf(DateTime(2019, 1, 4)), 1);
      expect(DateTime(2020, 1, 1).weekday, 3); //Wed
      expect(PullRequestPlus.weekNumberOf(DateTime(2020, 1, 1)), 1);
      expect(PullRequestPlus.weekNumberOf(DateTime(2020, 1, 4)), 1);
      expect(DateTime(2021, 1, 1).weekday, 5); //Fri
      expect(PullRequestPlus.weekNumberOf(DateTime(2021, 1, 1)), 0);
      expect(PullRequestPlus.weekNumberOf(DateTime(2021, 1, 4)), 1);
      expect(DateTime(2022, 1, 1).weekday, 6); //Sat
      expect(PullRequestPlus.weekNumberOf(DateTime(2022, 1, 1)), 0);
      expect(PullRequestPlus.weekNumberOf(DateTime(2022, 1, 4)), 1);
    });
  });

  group('prNumberOf function',(){
    test('should extract a number from hrmony-prf', () {
      expect(PullRequestPlus.prNumberOf('https://github.com/bizreach-inc/hrmony-prf/pull/5107'), 5107);
      expect(PullRequestPlus.prNumberOf('https://github.com/bizreach-inc/hrmony-prf/pull/510789'), 510789);

    });
    test('should extract a number from other repositories', () {
      expect(PullRequestPlus.prNumberOf('https://github.com/todokr/nuno/pull/5107'), 5107);
    });
  });

  group('calcDuration function',(){
    test('should calculate diff in minutes', () {
      var s = DateTime(2021, 11, 22);
      var e = DateTime(2021, 11, 23);
      expect(PullRequestPlus.calcDuration(s, e), 1440);

      s = DateTime(2021, 11, 22, 11, 22);
      e = DateTime(2021, 11, 22, 11, 24);
      expect(PullRequestPlus.calcDuration(s, e), 2);

      s = DateTime(2021, 11, 22, 11, 22, 33);
      e = DateTime(2021, 11, 22, 11, 22, 44);
      expect(PullRequestPlus.calcDuration(s, e), 0);

      s = DateTime(2021, 11, 22, 11, 22, 33);
      e = DateTime(2021, 11, 22, 11, 24, 44);
      expect(PullRequestPlus.calcDuration(s, e), 2);

      s = DateTime(2021, 11, 22, 11, 24);
      e = DateTime(2021, 11, 22, 11, 22);
      expect(PullRequestPlus.calcDuration(s, e), -2);
    });
  });
}


import 'package:floor/floor.dart';

@entity
class Day {

  @PrimaryKey(autoGenerate: true)
  int? id;

  int dayBeginTimestamp;

  Day(this.id, this.dayBeginTimestamp);

  @override
  String toString() {
    return 'Day{id: $id, dayBeginTimestamp: $dayBeginTimestamp}';
  }

}
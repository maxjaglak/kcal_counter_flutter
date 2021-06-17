// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppDatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  DayDao? _dayDaoInstance;

  ConsumptionDao? _consumptionDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Day` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `dayBeginTimestamp` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Consumption` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `dayId` INTEGER NOT NULL, `name` TEXT NOT NULL, `amount` INTEGER NOT NULL, `calculationUnit` TEXT NOT NULL, `kcals` INTEGER NOT NULL, `carbs` REAL NOT NULL, `fat` REAL NOT NULL, `protein` REAL NOT NULL, `addTimestampMillis` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DayDao get dayDao {
    return _dayDaoInstance ??= _$DayDao(database, changeListener);
  }

  @override
  ConsumptionDao get consumptionDao {
    return _consumptionDaoInstance ??=
        _$ConsumptionDao(database, changeListener);
  }
}

class _$DayDao extends DayDao {
  _$DayDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _dayInsertionAdapter = InsertionAdapter(
            database,
            'Day',
            (Day item) => <String, Object?>{
                  'id': item.id,
                  'dayBeginTimestamp': item.dayBeginTimestamp
                }),
        _dayUpdateAdapter = UpdateAdapter(
            database,
            'Day',
            ['id'],
            (Day item) => <String, Object?>{
                  'id': item.id,
                  'dayBeginTimestamp': item.dayBeginTimestamp
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Day> _dayInsertionAdapter;

  final UpdateAdapter<Day> _dayUpdateAdapter;

  @override
  Future<Day?> getLastDay() async {
    return _queryAdapter.query('SELECT * FROM Day ORDER BY id DESC LIMIT 1',
        mapper: (Map<String, Object?> row) =>
            Day(row['id'] as int?, row['dayBeginTimestamp'] as int));
  }

  @override
  Future<List<Day>> getDays() async {
    return _queryAdapter.queryList('SELECT * FROM Day ORDER BY id DESC',
        mapper: (Map<String, Object?> row) =>
            Day(row['id'] as int?, row['dayBeginTimestamp'] as int));
  }

  @override
  Future<void> insert(Day day) async {
    await _dayInsertionAdapter.insert(day, OnConflictStrategy.abort);
  }

  @override
  Future<void> update(Day day) async {
    await _dayUpdateAdapter.update(day, OnConflictStrategy.abort);
  }
}

class _$ConsumptionDao extends ConsumptionDao {
  _$ConsumptionDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _consumptionInsertionAdapter = InsertionAdapter(
            database,
            'Consumption',
            (Consumption item) => <String, Object?>{
                  'id': item.id,
                  'dayId': item.dayId,
                  'name': item.name,
                  'amount': item.amount,
                  'calculationUnit': item.calculationUnit,
                  'kcals': item.kcals,
                  'carbs': item.carbs,
                  'fat': item.fat,
                  'protein': item.protein,
                  'addTimestampMillis': item.addTimestampMillis
                }),
        _consumptionUpdateAdapter = UpdateAdapter(
            database,
            'Consumption',
            ['id'],
            (Consumption item) => <String, Object?>{
                  'id': item.id,
                  'dayId': item.dayId,
                  'name': item.name,
                  'amount': item.amount,
                  'calculationUnit': item.calculationUnit,
                  'kcals': item.kcals,
                  'carbs': item.carbs,
                  'fat': item.fat,
                  'protein': item.protein,
                  'addTimestampMillis': item.addTimestampMillis
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Consumption> _consumptionInsertionAdapter;

  final UpdateAdapter<Consumption> _consumptionUpdateAdapter;

  @override
  Future<List<Consumption>> getConsumptionByDay(int dayId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Consumption WHERE dayId = ?1 ORDER BY addTimestampMillis DESC',
        mapper: (Map<String, Object?> row) => Consumption(row['id'] as int?, row['dayId'] as int, row['name'] as String, row['amount'] as int, row['calculationUnit'] as String, row['kcals'] as int, row['carbs'] as double, row['fat'] as double, row['protein'] as double, row['addTimestampMillis'] as int),
        arguments: [dayId]);
  }

  @override
  Future<void> insert(Consumption consumption) async {
    await _consumptionInsertionAdapter.insert(
        consumption, OnConflictStrategy.abort);
  }

  @override
  Future<void> update(Consumption consumption) async {
    await _consumptionUpdateAdapter.update(
        consumption, OnConflictStrategy.abort);
  }
}

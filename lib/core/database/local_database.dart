import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

part 'local_database.g.dart';

class SupportedCurrencyTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get exchangeId => integer().named('exchange_id')();
  // TextColumn get title => text().withLength(min: 6, max: 32)();
  TextColumn get currencyCode => text().named('currency_code')();
  TextColumn get currencyName => text().nullable().named('currency_name')();
  TextColumn get countryCode => text().nullable().named('country_code')();
  TextColumn get countryName => text().nullable().named('country_name')();
  DateTimeColumn get createdAt => dateTime().nullable()();
}

// class CurrencyItems extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   // TextColumn get title => text().withLength(min: 6, max: 32)();
//   TextColumn get code => text().named('code')();
//   TextColumn get currencyName => text().named('currency_name')();
//   TextColumn get countryCode => text().named('country_code')();
//   TextColumn get countryName => text().named('country_name')();
//   DateTimeColumn get createdAt => dateTime().nullable()();
// }

class HistoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get exchangeId => integer().named('exchange_id')();
  TextColumn get currencyCodeFrom => text()();
  TextColumn get currencyNameFrom => text().nullable()();
  TextColumn get currencyCodeTo => text().nullable()();
  TextColumn get currencyNameTo => text().nullable()();
  TextColumn get exchangeTitle => text().nullable().named('exchange_title')();
  RealColumn get value => real().nullable()();
  BlobColumn get result => blob().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
}

// @injectable
@LazySingleton()
@DriftDatabase(tables: [
  HistoryTable,
  SupportedCurrencyTable,
])
class LocalDatabase extends _$LocalDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion =>
      2; // need to update after every changing strcuture!!!!!

  // @override
  // int get schemaVersion => 2; // New schema version

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          // Here you can handle custom migrations, like adding new columns, etc.
          if (from == 1 && to == 2) {
            // Perform actions for version upgrade from 1 to 2, if needed
            print('Upgrading from version 1 to 2...');
          }
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(
        name: 'currency_database',
        native: const DriftNativeOptions(
          // By default, `driftDatabase` from `package:drift_flutter` stores the
          // database files in `getApplicationDocumentsDirectory()`.
          databaseDirectory: getApplicationSupportDirectory,
        ),
        web: DriftWebOptions(
          sqlite3Wasm: Uri.parse('sqlite3.wasm'),
          driftWorker: Uri.parse('drift_worker.js'),
        ));
  }

  // LazyDatabase _openConnection() {
  //   return LazyDatabase(() async {
  //     // put the database file, called db.sqlite here, into the documents folder
  //     // for our app.
  //     final dbFolder = await getApplicationSupportDirectory();
  //     // setup the db file's path
  //     final file = File(p.join(dbFolder.path, 'book.db'));
  //     return NativeDatabase.createInBackground(file);
  //   });
  // }
}

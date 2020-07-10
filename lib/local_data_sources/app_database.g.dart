// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Plant extends DataClass implements Insertable<Plant> {
  final int id;
  final String name;
  final Uint8List image;
  final Uint8List thumbnail;
  Plant({@required this.id, @required this.name, this.image, this.thumbnail});
  factory Plant.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Plant(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      image: $PlantsTable.$converter0.mapToDart(
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image'])),
      thumbnail: $PlantsTable.$converter1.mapToDart(stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}thumbnail'])),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || image != null) {
      final converter = $PlantsTable.$converter0;
      map['image'] = Variable<String>(converter.mapToSql(image));
    }
    if (!nullToAbsent || thumbnail != null) {
      final converter = $PlantsTable.$converter1;
      map['thumbnail'] = Variable<String>(converter.mapToSql(thumbnail));
    }
    return map;
  }

  PlantsCompanion toCompanion(bool nullToAbsent) {
    return PlantsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      thumbnail: thumbnail == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnail),
    );
  }

  factory Plant.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Plant(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      image: serializer.fromJson<Uint8List>(json['image']),
      thumbnail: serializer.fromJson<Uint8List>(json['thumbnail']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'image': serializer.toJson<Uint8List>(image),
      'thumbnail': serializer.toJson<Uint8List>(thumbnail),
    };
  }

  Plant copyWith({int id, String name, Uint8List image, Uint8List thumbnail}) =>
      Plant(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        thumbnail: thumbnail ?? this.thumbnail,
      );
  @override
  String toString() {
    return (StringBuffer('Plant(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('thumbnail: $thumbnail')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(image.hashCode, thumbnail.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Plant &&
          other.id == this.id &&
          other.name == this.name &&
          other.image == this.image &&
          other.thumbnail == this.thumbnail);
}

class PlantsCompanion extends UpdateCompanion<Plant> {
  final Value<int> id;
  final Value<String> name;
  final Value<Uint8List> image;
  final Value<Uint8List> thumbnail;
  const PlantsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.image = const Value.absent(),
    this.thumbnail = const Value.absent(),
  });
  PlantsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    this.image = const Value.absent(),
    this.thumbnail = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Plant> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> image,
    Expression<String> thumbnail,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (image != null) 'image': image,
      if (thumbnail != null) 'thumbnail': thumbnail,
    });
  }

  PlantsCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<Uint8List> image,
      Value<Uint8List> thumbnail}) {
    return PlantsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (image.present) {
      final converter = $PlantsTable.$converter0;
      map['image'] = Variable<String>(converter.mapToSql(image.value));
    }
    if (thumbnail.present) {
      final converter = $PlantsTable.$converter1;
      map['thumbnail'] = Variable<String>(converter.mapToSql(thumbnail.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlantsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('thumbnail: $thumbnail')
          ..write(')'))
        .toString();
  }
}

class $PlantsTable extends Plants with TableInfo<$PlantsTable, Plant> {
  final GeneratedDatabase _db;
  final String _alias;
  $PlantsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  GeneratedTextColumn _image;
  @override
  GeneratedTextColumn get image => _image ??= _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      true,
    );
  }

  final VerificationMeta _thumbnailMeta = const VerificationMeta('thumbnail');
  GeneratedTextColumn _thumbnail;
  @override
  GeneratedTextColumn get thumbnail => _thumbnail ??= _constructThumbnail();
  GeneratedTextColumn _constructThumbnail() {
    return GeneratedTextColumn(
      'thumbnail',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, image, thumbnail];
  @override
  $PlantsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'plants';
  @override
  final String actualTableName = 'plants';
  @override
  VerificationContext validateIntegrity(Insertable<Plant> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    context.handle(_imageMeta, const VerificationResult.success());
    context.handle(_thumbnailMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Plant map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Plant.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $PlantsTable createAlias(String alias) {
    return $PlantsTable(_db, alias);
  }

  static TypeConverter<Uint8List, String> $converter0 = const ImageConverter();
  static TypeConverter<Uint8List, String> $converter1 = const ImageConverter();
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $PlantsTable _plants;
  $PlantsTable get plants => _plants ??= $PlantsTable(this);
  PlantsDao _plantsDao;
  PlantsDao get plantsDao => _plantsDao ??= PlantsDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [plants];
}

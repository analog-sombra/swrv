// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favoritebrand.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetFavoriteBrandCollection on Isar {
  IsarCollection<FavoriteBrand> get favoriteBrands => this.collection();
}

const FavoriteBrandSchema = CollectionSchema(
  name: r'FavoriteBrand',
  id: 5237580935648464505,
  properties: {
    r'brandid': PropertySchema(
      id: 0,
      name: r'brandid',
      type: IsarType.string,
    ),
    r'img': PropertySchema(
      id: 1,
      name: r'img',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _favoriteBrandEstimateSize,
  serialize: _favoriteBrandSerialize,
  deserialize: _favoriteBrandDeserialize,
  deserializeProp: _favoriteBrandDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'img': IndexSchema(
      id: -7830553291031444120,
      name: r'img',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'img',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'brandid': IndexSchema(
      id: 8896887162467868892,
      name: r'brandid',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'brandid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _favoriteBrandGetId,
  getLinks: _favoriteBrandGetLinks,
  attach: _favoriteBrandAttach,
  version: '3.0.5',
);

int _favoriteBrandEstimateSize(
  FavoriteBrand object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.brandid;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.img;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _favoriteBrandSerialize(
  FavoriteBrand object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.brandid);
  writer.writeString(offsets[1], object.img);
  writer.writeString(offsets[2], object.name);
}

FavoriteBrand _favoriteBrandDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FavoriteBrand();
  object.brandid = reader.readStringOrNull(offsets[0]);
  object.id = id;
  object.img = reader.readStringOrNull(offsets[1]);
  object.name = reader.readStringOrNull(offsets[2]);
  return object;
}

P _favoriteBrandDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _favoriteBrandGetId(FavoriteBrand object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _favoriteBrandGetLinks(FavoriteBrand object) {
  return [];
}

void _favoriteBrandAttach(
    IsarCollection<dynamic> col, Id id, FavoriteBrand object) {
  object.id = id;
}

extension FavoriteBrandQueryWhereSort
    on QueryBuilder<FavoriteBrand, FavoriteBrand, QWhere> {
  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FavoriteBrandQueryWhere
    on QueryBuilder<FavoriteBrand, FavoriteBrand, QWhereClause> {
  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterWhereClause> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [null],
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterWhereClause>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterWhereClause> nameEqualTo(
      String? name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterWhereClause> nameNotEqualTo(
      String? name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterWhereClause> imgIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'img',
        value: [null],
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterWhereClause> imgIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'img',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterWhereClause> imgEqualTo(
      String? img) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'img',
        value: [img],
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterWhereClause> imgNotEqualTo(
      String? img) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'img',
              lower: [],
              upper: [img],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'img',
              lower: [img],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'img',
              lower: [img],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'img',
              lower: [],
              upper: [img],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterWhereClause>
      brandidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'brandid',
        value: [null],
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterWhereClause>
      brandidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'brandid',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterWhereClause> brandidEqualTo(
      String? brandid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'brandid',
        value: [brandid],
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterWhereClause>
      brandidNotEqualTo(String? brandid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'brandid',
              lower: [],
              upper: [brandid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'brandid',
              lower: [brandid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'brandid',
              lower: [brandid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'brandid',
              lower: [],
              upper: [brandid],
              includeUpper: false,
            ));
      }
    });
  }
}

extension FavoriteBrandQueryFilter
    on QueryBuilder<FavoriteBrand, FavoriteBrand, QFilterCondition> {
  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      brandidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'brandid',
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      brandidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'brandid',
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      brandidEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'brandid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      brandidGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'brandid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      brandidLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'brandid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      brandidBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'brandid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      brandidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'brandid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      brandidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'brandid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      brandidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'brandid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      brandidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'brandid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      brandidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'brandid',
        value: '',
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      brandidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'brandid',
        value: '',
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      imgIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'img',
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      imgIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'img',
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition> imgEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'img',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      imgGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'img',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition> imgLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'img',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition> imgBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'img',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      imgStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'img',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition> imgEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'img',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition> imgContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'img',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition> imgMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'img',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      imgIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'img',
        value: '',
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      imgIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'img',
        value: '',
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension FavoriteBrandQueryObject
    on QueryBuilder<FavoriteBrand, FavoriteBrand, QFilterCondition> {}

extension FavoriteBrandQueryLinks
    on QueryBuilder<FavoriteBrand, FavoriteBrand, QFilterCondition> {}

extension FavoriteBrandQuerySortBy
    on QueryBuilder<FavoriteBrand, FavoriteBrand, QSortBy> {
  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterSortBy> sortByBrandid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brandid', Sort.asc);
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterSortBy> sortByBrandidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brandid', Sort.desc);
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterSortBy> sortByImg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'img', Sort.asc);
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterSortBy> sortByImgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'img', Sort.desc);
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension FavoriteBrandQuerySortThenBy
    on QueryBuilder<FavoriteBrand, FavoriteBrand, QSortThenBy> {
  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterSortBy> thenByBrandid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brandid', Sort.asc);
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterSortBy> thenByBrandidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'brandid', Sort.desc);
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterSortBy> thenByImg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'img', Sort.asc);
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterSortBy> thenByImgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'img', Sort.desc);
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension FavoriteBrandQueryWhereDistinct
    on QueryBuilder<FavoriteBrand, FavoriteBrand, QDistinct> {
  QueryBuilder<FavoriteBrand, FavoriteBrand, QDistinct> distinctByBrandid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'brandid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QDistinct> distinctByImg(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'img', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FavoriteBrand, FavoriteBrand, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension FavoriteBrandQueryProperty
    on QueryBuilder<FavoriteBrand, FavoriteBrand, QQueryProperty> {
  QueryBuilder<FavoriteBrand, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FavoriteBrand, String?, QQueryOperations> brandidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'brandid');
    });
  }

  QueryBuilder<FavoriteBrand, String?, QQueryOperations> imgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'img');
    });
  }

  QueryBuilder<FavoriteBrand, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}

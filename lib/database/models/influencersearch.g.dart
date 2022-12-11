// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'influencersearch.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetInfluencerSearchCollection on Isar {
  IsarCollection<InfluencerSearch> get influencerSearchs => this.collection();
}

const InfluencerSearchSchema = CollectionSchema(
  name: r'InfluencerSearch',
  id: 4891740242816921212,
  properties: {
    r'category': PropertySchema(
      id: 0,
      name: r'category',
      type: IsarType.string,
    ),
    r'city': PropertySchema(
      id: 1,
      name: r'city',
      type: IsarType.string,
    ),
    r'isActive': PropertySchema(
      id: 2,
      name: r'isActive',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'platforms': PropertySchema(
      id: 4,
      name: r'platforms',
      type: IsarType.string,
    )
  },
  estimateSize: _influencerSearchEstimateSize,
  serialize: _influencerSearchSerialize,
  deserialize: _influencerSearchDeserialize,
  deserializeProp: _influencerSearchDeserializeProp,
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
    r'category': IndexSchema(
      id: -7560358558326323820,
      name: r'category',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'category',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'platforms': IndexSchema(
      id: 3391183237084153684,
      name: r'platforms',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'platforms',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'city': IndexSchema(
      id: 2121973393509345332,
      name: r'city',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'city',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'isActive': IndexSchema(
      id: 8092228061260947457,
      name: r'isActive',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isActive',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _influencerSearchGetId,
  getLinks: _influencerSearchGetLinks,
  attach: _influencerSearchAttach,
  version: '3.0.5',
);

int _influencerSearchEstimateSize(
  InfluencerSearch object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.category;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.city;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.isActive;
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
  {
    final value = object.platforms;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _influencerSearchSerialize(
  InfluencerSearch object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.category);
  writer.writeString(offsets[1], object.city);
  writer.writeString(offsets[2], object.isActive);
  writer.writeString(offsets[3], object.name);
  writer.writeString(offsets[4], object.platforms);
}

InfluencerSearch _influencerSearchDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = InfluencerSearch();
  object.category = reader.readStringOrNull(offsets[0]);
  object.city = reader.readStringOrNull(offsets[1]);
  object.id = id;
  object.isActive = reader.readStringOrNull(offsets[2]);
  object.name = reader.readStringOrNull(offsets[3]);
  object.platforms = reader.readStringOrNull(offsets[4]);
  return object;
}

P _influencerSearchDeserializeProp<P>(
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
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _influencerSearchGetId(InfluencerSearch object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _influencerSearchGetLinks(InfluencerSearch object) {
  return [];
}

void _influencerSearchAttach(
    IsarCollection<dynamic> col, Id id, InfluencerSearch object) {
  object.id = id;
}

extension InfluencerSearchQueryWhereSort
    on QueryBuilder<InfluencerSearch, InfluencerSearch, QWhere> {
  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension InfluencerSearchQueryWhere
    on QueryBuilder<InfluencerSearch, InfluencerSearch, QWhereClause> {
  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause> idBetween(
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

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause>
      nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [null],
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause>
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

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause>
      nameEqualTo(String? name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause>
      nameNotEqualTo(String? name) {
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

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause>
      categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'category',
        value: [null],
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause>
      categoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'category',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause>
      categoryEqualTo(String? category) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'category',
        value: [category],
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause>
      categoryNotEqualTo(String? category) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'category',
              lower: [],
              upper: [category],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'category',
              lower: [category],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'category',
              lower: [category],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'category',
              lower: [],
              upper: [category],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause>
      platformsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'platforms',
        value: [null],
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause>
      platformsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'platforms',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause>
      platformsEqualTo(String? platforms) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'platforms',
        value: [platforms],
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause>
      platformsNotEqualTo(String? platforms) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'platforms',
              lower: [],
              upper: [platforms],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'platforms',
              lower: [platforms],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'platforms',
              lower: [platforms],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'platforms',
              lower: [],
              upper: [platforms],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause>
      cityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'city',
        value: [null],
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause>
      cityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'city',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause>
      cityEqualTo(String? city) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'city',
        value: [city],
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause>
      cityNotEqualTo(String? city) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'city',
              lower: [],
              upper: [city],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'city',
              lower: [city],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'city',
              lower: [city],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'city',
              lower: [],
              upper: [city],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause>
      isActiveIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isActive',
        value: [null],
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause>
      isActiveIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'isActive',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause>
      isActiveEqualTo(String? isActive) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isActive',
        value: [isActive],
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterWhereClause>
      isActiveNotEqualTo(String? isActive) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isActive',
              lower: [],
              upper: [isActive],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isActive',
              lower: [isActive],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isActive',
              lower: [isActive],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isActive',
              lower: [],
              upper: [isActive],
              includeUpper: false,
            ));
      }
    });
  }
}

extension InfluencerSearchQueryFilter
    on QueryBuilder<InfluencerSearch, InfluencerSearch, QFilterCondition> {
  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      categoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      categoryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      categoryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      categoryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      categoryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      cityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'city',
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      cityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'city',
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      cityEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      cityGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      cityLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      cityBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'city',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      cityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      cityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      cityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      cityMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'city',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      cityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'city',
        value: '',
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      cityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'city',
        value: '',
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
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

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      isActiveIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isActive',
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      isActiveIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isActive',
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      isActiveEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      isActiveGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isActive',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      isActiveLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isActive',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      isActiveBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isActive',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      isActiveStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'isActive',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      isActiveEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'isActive',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      isActiveContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'isActive',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      isActiveMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'isActive',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      isActiveIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isActive',
        value: '',
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      isActiveIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'isActive',
        value: '',
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      nameEqualTo(
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

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
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

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
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

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      nameBetween(
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

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
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

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
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

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      platformsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'platforms',
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      platformsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'platforms',
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      platformsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'platforms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      platformsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'platforms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      platformsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'platforms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      platformsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'platforms',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      platformsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'platforms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      platformsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'platforms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      platformsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'platforms',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      platformsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'platforms',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      platformsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'platforms',
        value: '',
      ));
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterFilterCondition>
      platformsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'platforms',
        value: '',
      ));
    });
  }
}

extension InfluencerSearchQueryObject
    on QueryBuilder<InfluencerSearch, InfluencerSearch, QFilterCondition> {}

extension InfluencerSearchQueryLinks
    on QueryBuilder<InfluencerSearch, InfluencerSearch, QFilterCondition> {}

extension InfluencerSearchQuerySortBy
    on QueryBuilder<InfluencerSearch, InfluencerSearch, QSortBy> {
  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterSortBy>
      sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterSortBy>
      sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterSortBy> sortByCity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.asc);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterSortBy>
      sortByCityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.desc);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterSortBy>
      sortByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterSortBy>
      sortByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterSortBy>
      sortByPlatforms() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'platforms', Sort.asc);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterSortBy>
      sortByPlatformsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'platforms', Sort.desc);
    });
  }
}

extension InfluencerSearchQuerySortThenBy
    on QueryBuilder<InfluencerSearch, InfluencerSearch, QSortThenBy> {
  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterSortBy>
      thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterSortBy>
      thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterSortBy> thenByCity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.asc);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterSortBy>
      thenByCityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.desc);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterSortBy>
      thenByIsActive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.asc);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterSortBy>
      thenByIsActiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isActive', Sort.desc);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterSortBy>
      thenByPlatforms() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'platforms', Sort.asc);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QAfterSortBy>
      thenByPlatformsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'platforms', Sort.desc);
    });
  }
}

extension InfluencerSearchQueryWhereDistinct
    on QueryBuilder<InfluencerSearch, InfluencerSearch, QDistinct> {
  QueryBuilder<InfluencerSearch, InfluencerSearch, QDistinct>
      distinctByCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QDistinct> distinctByCity(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'city', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QDistinct>
      distinctByIsActive({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isActive', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InfluencerSearch, InfluencerSearch, QDistinct>
      distinctByPlatforms({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'platforms', caseSensitive: caseSensitive);
    });
  }
}

extension InfluencerSearchQueryProperty
    on QueryBuilder<InfluencerSearch, InfluencerSearch, QQueryProperty> {
  QueryBuilder<InfluencerSearch, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<InfluencerSearch, String?, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<InfluencerSearch, String?, QQueryOperations> cityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'city');
    });
  }

  QueryBuilder<InfluencerSearch, String?, QQueryOperations> isActiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isActive');
    });
  }

  QueryBuilder<InfluencerSearch, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<InfluencerSearch, String?, QQueryOperations>
      platformsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'platforms');
    });
  }
}

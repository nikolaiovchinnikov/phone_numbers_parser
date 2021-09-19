import 'package:phone_numbers_parser/src/utils/_metadata_finder.dart';

import '../../phone_numbers_parser.dart';

class PhoneNumber {
  /// National significant number in its internanational form
  final String nsn;

  /// country alpha2 code example: 'FR', 'US', ...
  final String isoCode;

  /// territory numerical code that precedes a phone number. Example 33 for france
  String get countryCode =>
      MetadataFinder.getMetadataForIsoCode(isoCode).countryCode;

  @Deprecated('use countryCode, dialCode was semantically incorrect')
  String get dialCode => countryCode;

  /// international version of phone number
  String get international => '+' + countryCode + nsn;

  const PhoneNumber({
    required this.isoCode,
    required this.nsn,
  });

  @override
  String toString() => 'PhoneNumber(nsn: $nsn, isoCode: $isoCode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhoneNumber && other.nsn == nsn && other.isoCode == isoCode;
  }

  @override
  int get hashCode => nsn.hashCode ^ isoCode.hashCode;

  /// Returns true if this phone number is numerically greater
  /// than [other]
  bool operator >(PhoneNumber other) {
    var self = BigInt.parse(international);
    var _other = BigInt.parse(other.international);

    return (self - _other).toInt() > 0;
  }

  /// Returns true if this phone number is numerically greater
  /// than or equal to [other]
  bool operator >=(PhoneNumber other) {
    return this == other || this > other;
  }

  /// Returns true if this phone number is numerically less
  /// than [other]
  bool operator <(PhoneNumber rhs) {
    return !(this >= rhs);
  }

  /// Returns true if this phone number is numerically less
  /// than or equal to [other]
  bool operator <=(PhoneNumber rhs) {
    return this < rhs || (this == rhs);
  }

  /// We consider the PhoneNumber to be adjacent to the this PhoneNumber if it is one less or one greater than this
  ///  phone number.
  bool isAdjacentTo(PhoneNumber other) {
    return ((this + 1) == other) || ((this - 1) == other);
  }

  /// Returns true if [nextNumber] is the next number (numerically) after this number
  /// ```dart
  /// PhoneParser.parseRaw('61383208100').isSequentialTo( PhoneParser.parseRaw('61383208101')) == true;
  /// ```
  bool isSequentialTo(PhoneNumber nextNumber) {
    return ((this + 1) == nextNumber);
  }

  ///  numerically add [operand] to this phone number
  /// e.g.
  /// ```dart
  /// PhoneParser.parseRaw('61383208100') + 1 == PhoneParser.parseRaw('61383208101');
  /// ```
  PhoneNumber operator +(int operand) {
    var phone = BigInt.parse(international);
    var result = phone + (BigInt.from(operand));

    return PhoneParser().parseRaw(result.toString());
  }

  /// numerically subtract [operand] from this phone number
  /// e.g.
  /// ```dart
  /// PhoneParser.parseRaw('61383208100') - 1 == PhoneParser.parseRaw('61383208099');
  /// ```
  PhoneNumber operator -(int operand) {
    var phone = BigInt.parse(international);
    var result = phone - BigInt.from(operand);

    return PhoneParser().parseRaw(result.toString());
  }
}

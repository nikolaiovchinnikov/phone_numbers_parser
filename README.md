# Phone Numbers Parser

Dart library for parsing phone numbers. Inspired by Google's libphonenumber and PhoneNumberKit for ios.

The advantage of this lib instead of libphonenumber is that it instantly supports all platforms (no need for channeling).


## Features

 - Find phone numbers in a text
 - Validate a phone number
 - Find the country of a phone number (Geocoding available as separate package)
 - A light parser for size aware applications
 - Phone ranges
 - Supports easthern arabic digits
 - Uses best-in-class metadata from Google's libPhoneNumber project. 



## Parsers
There are two parsers: LightPhoneParser and Phone Parser

LightPhoneParser:
  - smaller size footprint (more will be tree shaken)
  - uses mainly length information for validation
  - fast

PhoneParser:
  - more accurate
  - bigger size footprint
  - more computationally intensive
  - uses pattern matching

### Usage PhoneParser

```dart
  final parser = PhoneParser(); // alternatively LightPhoneParser
  // creation
  final frPhone = parser.parseRaw('+33 655 5705 76');
  final frPhone1 = parser.parseWithIsoCode('fr', '655 5705 76');
  final frPhone2 = parser.parseWithDialCode('33', '655 5705 76');
  final frPhone3 = parser.parseWithIsoCode('fr', '0655 5705 76');
  final allSame =
      frPhone == frPhone1 && frPhone == frPhone2 && frPhone == frPhone3;
  print(allSame); // true

  // validation
  print(parser.validate(frPhone1)); // true
  print(parser.validate(frPhone1, PhoneNumberType.mobile)); // true
  print(parser.validate(frPhone1, PhoneNumberType.fixedLine)); // false

  // changing the country
  final esPhone = parser.copyWithIsoCode(frPhone, 'ES');
  print(esPhone.dialCode); // 34
  print(esPhone.isoCode); // ES
  print(esPhone.international); // '+34655570576'

  // utils
  final text = 'hey my phone number is: +33 939 876 218';
  final found = parser.findPotentialPhoneNumbers(text);
  print(text.substring(found.first.start, found.first.end)); 
```


## Demo

The phone number input packages has a demo that uses this parser: https://cedvdb.github.io/phone_form_field/

import 'dart:convert';

class DataUtils{
  static String plainToBase64(String plain){
    Codec<String,String> stringToBase64 = utf8.fuse(base64);

    String encoded = stringToBase64.encode(plain);

    return encoded;
  }

  static String base64toPlain(String plain){
    Codec<String,String> stringToPlain = utf8.fuse(base64);

    String decoded = stringToPlain.decode(plain);

    return decoded;
  }
}
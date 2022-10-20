import 'dart:math';
String generate(){
  const length = 15;
  const low = 'abcdefghijklmnopqrstuvwxyz';
  const high = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const num = '0123456789';
  const special = '!@#%^&*()_+={}[]|;';
  String chars = '';
  chars += '$low$high';
  chars += num;
  chars += special;
  return List.generate (length,(index){
    final indexRandom = Random.secure().nextInt(chars.length);
    return chars[indexRandom];
  }).join() ; // List.generate
}
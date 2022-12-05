class Brew {
  String name;
  final String sugars;
  final int strength;

  Brew({required this.name, required this.sugars, required this.strength});

  @override
  String toString() {
    return 'Brew{name: $name, sugars: $sugars, strength: $strength}';
  }
}

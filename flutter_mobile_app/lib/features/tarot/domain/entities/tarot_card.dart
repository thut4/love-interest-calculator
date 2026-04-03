class TarotCard {
  const TarotCard({
    required this.id,
    required this.number,
    required this.name,
    required this.imageUrl,
    this.isReversed = false,
  });

  final String id;
  final int number;
  final String name;
  final String imageUrl;
  final bool isReversed;

  TarotCard copyWith({bool? isReversed}) {
    return TarotCard(
      id: id,
      number: number,
      name: name,
      imageUrl: imageUrl,
      isReversed: isReversed ?? this.isReversed,
    );
  }
}

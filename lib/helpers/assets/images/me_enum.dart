enum MeEnum {
  ai('ai.webp'),
  aiHand('ai_hand.png'),
  casual('casual.png'),
  humanHand('human_hand.png'),
  software('software.webp');

  const MeEnum(this.fileName);

  final String fileName;
  String get path => 'assets/images/me/$fileName';
}

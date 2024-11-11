List<String> soundTypeToFileName(SfxType type) {
  switch (type) {
    case SfxType.coin:
      return const [
        'coin_1.mp3',
        'coin_2.mp3',
        'coin_3.mp3',
        'coin_4.mp3',
      ];

    case SfxType.levelComplete:
      return const [
        'level_complete.mp3'
      ];

    case SfxType.lockSuccessful:
      return const [
        'lock_successful.mp3'
      ]; 

    case SfxType.lockUnsuccessful:
      return const [
        'lock_unsuccessful.mp3'
      ];

    case SfxType.tick:
      return const [
        'tick.mp3'
      ];   

    case SfxType.wordFoundWoosh:
      return const [
        'word_found_woosh.mp3'
      ];   

    case SfxType.flip:
      return const [
        'flip_1.mp3',
        'flip_2.mp3',
        'flip_3.mp3',
        'flip_4.mp3',
      ];

    case SfxType.charge:
      return const [
        'charge.mp3'
      ];                                  
  }

}


enum SfxType {
  coin,
  levelComplete,
  lockSuccessful,
  lockUnsuccessful,
  tick,
  wordFoundWoosh,
  flip,
  charge,
}
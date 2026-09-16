enum ProjectEnum {
  ledPanel,
  gymFlow,
  textArt;

  String get image =>
      'assets/images/projects/${name.toLowerCase().replaceAll(' ', '_')}.png';

  String get name {
    switch (this) {
      case ProjectEnum.ledPanel:
        return 'Led Panel';
      case ProjectEnum.gymFlow:
        return 'GymFlow';
      case ProjectEnum.textArt:
        return 'Text art';
    }
  }

  String get description {
    switch (this) {
      case ProjectEnum.ledPanel:
        return 'LED displays to life with playful marquee-style animations and customizable.';
      case ProjectEnum.gymFlow:
        return 'A smart fitness app that analyzes body joints in real time to automatically detect movements and count exercise repetitions.';
      case ProjectEnum.textArt:
        return 'Upload a picture and watch it transform into detailed text art.';
    }
  }

  List<String> get technologies {
    switch (this) {
      case ProjectEnum.ledPanel:
        return ['Flutter'];
      case ProjectEnum.gymFlow:
        return ['Flutter', 'TensorFlow Lite'];
      case ProjectEnum.textArt:
        return ['Python', 'FastAPI', 'OpenCV'];
    }
  }

  String get link {
    switch (this) {
      case ProjectEnum.ledPanel:
        return 'https://github.com/aleax888/led_panel';
      case ProjectEnum.gymFlow:
        return 'https://www.google.com/search?q=comming+soon&oq=comming+soon';
      case ProjectEnum.textArt:
        return 'https://github.com/aleax888/img_to_text_art';
    }
  }
}

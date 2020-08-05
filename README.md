# im_animations

![Pub Version (including pre-releases)](https://img.shields.io/pub/v/im_animations?include_prereleases)
![GitHub issues](https://img.shields.io/github/issues-raw/imujtaba8488/im_animations)
![GitHub closed issues](https://img.shields.io/github/issues-closed-raw/imujtaba8488/im_animations)
![GitHub last commit](https://img.shields.io/github/last-commit/imujtaba8488/im_animations)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/imujtaba8488/im_animations)

## About

A growing collection of cool, elegant, efficient and performance-optimized
animation widgets.

## List of Animations

* __Fade:__ Fades its child in or out.

* __HeartBeat:__ Applies a heartbeat effect to its child.

* __Rotate:__ Rotates its child clockwise or anti-clockwise.

* __Sonar:__ Shows sonar wave pattern around its child.

### Usage Notes

Simply import `package:im_animations/im_animations.dart` and use any animation.

## Feedback

For any feedback please file an issue
__[here](https://github.com/imujtaba8488/im_animations/issues).__
Also, don't forget to hit the like button.

## Properties (Attributes)

| Animation | Property           | Description                                                 | Default  Value              |
|-----------|--------------------|-------------------------------------------------------------|-----------------------------|
| Fade      | duration           | The duration of the fade effect.                            | 1000 milliseconds           |
|           | fadeEffect         | Whether to fade-in or fade-out                              | FadeEffect.fadeIn           |
|           | child              | The item to fade.                                           |              -              |
|           |                    |                                                             |                             |
| HeartBeat | beatsPerMinute     | The number of times the child should beat per minute.       | 70 times.                   |
|           | child              | The item to apply the heartbeat effect to.                  |              -              |
|           |                    |                                                             |                             |
| Rotate    | rotationsPerMinute | The number of times the child should rotate per minute.     | 70 times.                   |
|           | repeat             | Whether to loop rotation or not                             | false                       |
|           | rotationDirection  | The direction in which to rotate the child                  | RotationDirection.clockwise |
|           | child              | The item to rotate.                                         |                             |
|           |                    |                                                             |                             |
| Sonar     | radius             | The radius of the sonar widget, including its waves         | 24.0                        |
|           | waveThickness      | The thickness of the sonar waves.                           | 0.5                         |
|           | waveColor          | Color of the sonar waves                                    | Blue                        |
|           | duration           | Determines how fast or slow the sonar waves should transmit | 1 second                    |
|           | wavesDisabled      | Whether to disable the sonar waves or not                   | false                       |
|           | insets             | Padding round the child widget.                             | 0.0                         |
|           | child              | The item to be placed inside the sonar waves                |              -              |

## Screenshots

![fade_01](https://github.com/imujtaba8488/showcase/blob/master/fade_01.gif)
![heartbeat_01](https://github.com/imujtaba8488/showcase/blob/master/heartbeat_01.gif)
![rotate_01](https://github.com/imujtaba8488/showcase/blob/master/rotate_01.gif)
![sonar_01](https://github.com/imujtaba8488/showcase/blob/master/sonar_01.gif)

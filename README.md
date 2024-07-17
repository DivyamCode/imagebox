# ImageBox

[![Pub Version](https://img.shields.io/pub/v/catched_image)](https://pub.dev/packages/catched_image)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)


ImageBox is a simple and efficient image caching package for Flutter applications. It provides an easy way to manage and display images, with automatic caching to improve performance and user experience. The package allows for seamless integration and includes features like customizable base URL for loading images and easy initialization and configuration. With ImageBox, you can enhance your app's image handling capabilities effortlessly.


## Features

- **Easy Initialization and Configuration**: Quickly set up the `ImageBoxService` with minimal code. The initialization process is straightforward, allowing you to start using the package in no time.
- **Seamless Integration with `Image.asset`**: Replace `Image.asset` with `CachedImage` effortlessly. This ensures that your existing code can be easily adapted to use the caching functionality without significant changes.
- **Automatic Image Caching**: Images are automatically cached on the device, reducing load times and improving performance. This is particularly useful for applications that display many images or where network speed is a concern.
- **Customizable Base URL for Image Loading**: Configure a base URL to simplify loading images from a specific domain. This feature is handy for applications that fetch images from a consistent source, allowing you to manage and change the base URL easily if needed.
- **Flexible and Scalable**: Designed to handle various use cases, from small personal projects to large-scale applications, `ImageBox` provides a robust solution for image caching needs.
- **Error Handling**: Built-in mechanisms to handle image loading errors gracefully, ensuring a smooth user experience even when network issues occur.


# Getting Started

## Initialization

Initialize the `ImageBoxService` at the beginning of your app:

```dart
await ImageBoxService.initialize();
ImageBoxService.setBaseUrl('https://via.placeholder.com/150/92c952');
```



## Displaying Cached Images

To display a cached image, use `CachedImage` instead of `Image.asset`:

```dart
import 'package:catched_image/catched_image.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catched Image Example'),
      ),
      body: Center(
        child:CachedImage(imageName:'/150/92c952',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
```


## Configuration

You can set a custom base URL for loading images:

```dart
ImageBoxService.setBaseUrl('https://my.custom.base.url');
```


## Example

Check out the complete example [here](#).

## Contributions

Contributions are welcome! Please read our [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


## Acknowledgements

- [Placeholder.com](https://placeholder.com) for placeholder images
- [Flutter](https://flutter.dev) for providing an amazing framework

## Support

If you find this package helpful, please give it a ⭐ on [GitHub](https://github.com).

Happy coding! 😊
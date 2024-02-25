import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:283466351178:ios:11f94d8546d09dc5939cb3',
        apiKey: 'AIzaSyDZMrO_9KcpEJc8yMiIL4oYEi9a5gFOzHI',
        projectId: 'ecommerce-shopme',
        messagingSenderId: '511896442526	',
        iosBundleId: 'com.example.shopme',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:511896442526:android:28317a124c57d801600d8f',
        apiKey: 'AIzaSyCZVhhs10VK6MNcEhzRMyp44wMsbQlPuxM',
        projectId: 'ecommerce-shopme',
        messagingSenderId: '511896442526',
      );
    }
  }
}

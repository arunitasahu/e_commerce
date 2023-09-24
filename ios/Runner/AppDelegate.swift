import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
   -> Bool {

       GeneratedPluginRegistrant.register(with: self)
       GMSServices.provideAPIKey("AIzaSyCfqWdXEQjOvKkOqDEbnxClyP3uf_52BRw")
       return super.application(application, didFinishLaunchingWithOptions: launchOptions)
     }
   }

  }
}

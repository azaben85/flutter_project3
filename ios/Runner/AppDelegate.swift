import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
   // TODO: Add your Google Maps API key
    GMSServices.provideAPIKey("AIzaSyATTTRus76dMNsf_X6zD0kPhTZWQ1fA0pY")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

//
//  AppDelegate.swift
//  MoodToday
//
//  Created by 이창화 on 2022/05/28.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    //AgreementViewController(viewModel: AppDIContainer.shared.userLocationDependencies())
    let mainVC = AgreementViewController(viewModel: AppDIContainer.shared.userLocationDependencies())//TodayWeatherContainerViewController(viewModel: AppDIContainer.shared.todayWeatherDependencies())
    window = UIWindow(frame: UIScreen.main.bounds)
    guard let window = window else { return false }
    window.rootViewController = mainVC
    window.overrideUserInterfaceStyle = .light
    window.makeKeyAndVisible()
    return true
  }
}


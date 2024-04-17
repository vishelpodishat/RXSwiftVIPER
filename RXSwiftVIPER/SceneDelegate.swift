//
//  SceneDelegate.swift
//  RXSwiftVIPER
//
//  Created by Alisher Saideshov on 09.04.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene

        let startController = MVVMViewController()
        let navigationController = UINavigationController(rootViewController: startController)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}


//
//  CleanSwiftRouter.swift
//  RXSwiftVIPER
//
//  Created by Alisher Saideshov on 15.04.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol CleanSwiftRoutingLogic {
    func routeToDetailedViewController()
}

protocol CleanSwiftDataPassing {
    var dataStore: CleanSwiftDataStore? { get }
}

class CleanSwiftRouter: NSObject, CleanSwiftRoutingLogic, CleanSwiftDataPassing {
    weak var viewController: CleanSwiftViewController?
    var dataStore: CleanSwiftDataStore?

    // MARK: Routing

    func routeToDetailedViewController() {
        // получаем конечный Вью Контроллер, куда нам необходимо переходить
        let destinationVC = DetailedViewController()

        // получаем хранилище данных
        var destinationDS = destinationVC.router!.dataStore!
        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
        navigateToSomewhere(source: viewController!, destination: destinationVC)

        // PS - никогда не используйте force unwrap!
        // здесь он используется для облегчеия моей работы :)
    }

    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}

    // MARK: Navigation

    func navigateToSomewhere(
        source: CleanSwiftViewController,
        destination: DetailedViewController) {
            // настраиваем переход
            source.show(destination, sender: nil)
        }

    //func navigateToSomewhere(source: CleanSwiftViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}

    // MARK: Passing data

    func passDataToSomewhere(source: CleanSwiftDataStore, destination: inout DetailedDataStore)
    {
      destination.character = source.chosenCharacter
    }
}

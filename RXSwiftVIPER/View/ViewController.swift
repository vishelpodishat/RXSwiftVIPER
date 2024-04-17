//
//  ViewController.swift
//  RXSwiftVIPER
//
//  Created by Alisher Saideshov on 09.04.2024.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        self.disposeBag = DisposeBag()

        let scheduler = SerialDispatchQueueScheduler(qos: .default)
        let subscription = Observable<Int>.interval(.milliseconds(300), scheduler: scheduler)
            .observe(on: MainScheduler.instance)
            .subscribe { event in
                print(event)
            }
        Thread.sleep(forTimeInterval: 2)

        subscription.dispose()
    }
}


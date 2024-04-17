//
//  MVVMViewModel.swift
//  RXSwiftVIPER
//
//  Created by Alisher Saideshov on 17.04.2024.
//

import UIKit
import RxSwift
import RxCocoa

protocol MVVMViewModelProtocols: AnyObject {
    func rxInput()
    func rxOutput()
}

class MVVMViewModel {

    // MARK: - Input
    let username = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")

    // MARK: - Output
    let messageLabel = BehaviorRelay<String?>(value: nil)
    let userEntered = PublishSubject<Void>()
    let goToProfileViewController = PublishSubject<Void>()
    let triggerAlert = PublishSubject<Void>()

    // MARK: - Model
    let userData = User()

    func validation() {
        if username.value.isEmpty && password.value.isEmpty {
            messageLabel.accept("Enter Email and Password")
        } else if password.value.isEmpty {
            messageLabel.accept("Enter Password")
        } else if username.value.isEmpty {
            messageLabel.accept("Enter Login")
        } else {
            if username.value == userData.name && password.value == userData.password {
                goToProfileViewController.onNext(())
            } else {
                triggerAlert.onNext(())
            }
        }
    }
}

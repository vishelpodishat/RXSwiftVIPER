//
//  MVVMViewController.swift
//  RXSwiftVIPER
//
//  Created by Alisher Saideshov on 17.04.2024.
//

import UIKit
import RxSwift
import RxCocoa

final class MVVMViewController: UIViewController {

    private let label: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .extraLargeTitle)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.placeholder = "useranm"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.placeholder = "password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftViewMode = .always
        return textField
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Продолжить", for: .normal)
        button.addTarget(self, action: #selector(touchUp), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let disposeBag = DisposeBag()
    private let viewModel = MVVMViewModel()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        setupRX()
    }

    // MARK: - RX
    func setupRX() {
        rxInput()
        rxOutput()
    }
}

// MARK: - Setup
extension MVVMViewController {
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        [label, usernameTextField, passwordTextField, button].forEach(view.addSubview)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            passwordTextField.centerYAnchor.constraint(equalTo: usernameTextField.centerYAnchor, constant: 30),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            button.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor, constant: 30),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }

    @objc func touchUp() {
        UIView.animate(withDuration: 0.5) {
            self.button.alpha = 1.0
            self.button.setTitle("Log in", for: .normal)
        }
    }
}


// MARK: - Input Outputs
extension MVVMViewController: MVVMViewModelProtocols {
    func rxInput() {
        usernameTextField.rx.text.orEmpty.bind(to: viewModel.username).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: disposeBag)
        button.rx.tap.bind {
            self.viewModel.validation()
        }.disposed(by: disposeBag)
    }

    func rxOutput() {
        viewModel.messageLabel.bind(to: label.rx.text)
            .disposed(by: disposeBag)

        viewModel.goToProfileViewController
            .subscribe(onNext: { [weak self] in
                let profileVC = ViewController()
                self?.navigationController?.pushViewController(profileVC, animated: true)
            })
            .disposed(by: disposeBag)

        viewModel.triggerAlert
            .subscribe(onNext: { [weak self] in
                let alertController = UIAlertController(title: "Error",
                                                        message: "message",
                                                        preferredStyle: .alert)
                let action = UIAlertAction(title: "ok", style: .destructive, handler: nil)
                alertController.addAction(action)
                self?.present(alertController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}

//
//  LoginView.swift
//  PeetMee
//
//  Created by Carlos Rodriguez Guerrero on 04/03/20.
//  Copyright © 2020 Carlos Rodriguez Guerrero. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIViewController {

    // MARK: Properties
    var presenter: LoginPresenterProtocol?
    let emailTextfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "email"
        tf.backgroundColor = UIColor(white: 1, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    let passwordTextfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "password"
        tf.backgroundColor = UIColor(white: 1, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(loginButtonPress), for: .touchUpInside)
        return button
    }()
    let logoContainerView: UIView = {
        let view = UIView()
//        let logoImageView = UIImageView(image: UIImage(named: "Instagram_logo_white"))
//        logoImageView.contentMode = .scaleAspectFill
//        view.addSubview(logoImageView)
//        logoImageView.anchor(top: nil,
//                             left: nil,
//                             bottom: nil,
//                             right: nil,
//                             paddingTop: 0,
//                             paddingLeft: 0,
//                             paddingBottom: 0,
//                             paddingRight: 0,
//                             width: 200,
//                             height: 50)
//        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.backgroundColor = UIColor.PeetMeeBaseColors.RedBase
        return view
    }()

    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ",
                                                        attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                                                                     NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Sign Up",
                                                  attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
                                                               NSAttributedString.Key.foregroundColor: UIColor(red: 17/255, green: 154/255,
                                                                                                               blue: 237/255, alpha: 1)]))
        button.addTarget(self, action: #selector(signUpButtonPress), for: .touchUpInside)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUIViewElements()
    }

    func setupUIViewElements() {
        view.addSubview(logoContainerView)
               logoContainerView.anchor(top: view.topAnchor,
                                        left: view.leftAnchor,
                                        bottom: nil,
                                        right: view.rightAnchor,
                                        paddingTop: 0,
                                        paddingLeft: 0,
                                        paddingBottom: 0,
                                        paddingRight: 0,
                                        width: 0,
                                        height: 150)
        let stack = UIStackView(arrangedSubviews: [emailTextfield, passwordTextfield, loginButton])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.anchor(top: logoContainerView.bottomAnchor,
                     left: view.leftAnchor,
                     bottom: nil,
                     right: view.rightAnchor,
                     paddingTop: 40,
                     paddingLeft: 40,
                     paddingBottom: 0,
                     paddingRight: 40,
                     width: 0,
                     height: 140)
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(top: nil,
                                     left: view.leftAnchor,
                                     bottom: view.bottomAnchor,
                                     right: view.rightAnchor,
                                     paddingTop: 0,
                                     paddingLeft: 0,
                                     paddingBottom: 0,
                                     paddingRight: 0,
                                     width: 0,
                                     height: 50)

    }

    @objc func formValidation() {
        presenter?.updateFormInformation(with: self.emailTextfield.text ?? "",
                                         password: self.passwordTextfield.text ?? "")
    }

    @objc func loginButtonPress() {
        guard let password = self.passwordTextfield.text else {
            return
        }
        presenter?.loginButtonPress(with: password)
    }

    @objc func signUpButtonPress() {
        presenter?.presentSignUp(controller: self)
    }
}

extension LoginView: LoginViewProtocol {
    func showLoader() {
    }

    func hiddeLoader() {

    }

    func enableSignUpButton() {
        loginButton.isEnabled = true
        loginButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
    }

    func dissableSignUpButton() {
        loginButton.isEnabled = false
        loginButton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
    }

}

//
//  SignUpView.swift
//  PeetMee
//
//  Created by Carlos Rodriguez lGuerrero on 05/03/20.
//  Copyright © 2020 Carlos Rodriguez Guerrero. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class SignUpView: UIViewController {
    let localizables = PeetMeeLocalizables()
    let hud = MBProgressHUD()
     let plusPhotoBtn: UIButton = {
         let button = UIButton(type: .system)
         button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
         button.addTarget(self, action: #selector(handleSelectProfilePhoto), for: .touchUpInside)
         return button
     }()

     let emailTextField: UITextField = {
         let tf = UITextField()
         tf.placeholder = "Email"
         tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
         tf.borderStyle = .roundedRect
         tf.font = UIFont.systemFont(ofSize: 14)
         tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
         return tf
     }()

     let passwordTextField: UITextField = {
         let tf = UITextField()
         tf.placeholder = "Password"
         tf.isSecureTextEntry = true
         tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
         tf.borderStyle = .roundedRect
         tf.font = UIFont.systemFont(ofSize: 14)
         tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
         return tf
     }()

     let fullNameTextField: UITextField = {
         let tf = UITextField()
         tf.placeholder = "Full Name"
         tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
         tf.borderStyle = .roundedRect
         tf.font = UIFont.systemFont(ofSize: 14)
         tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
         return tf
     }()

     let usernameTextField: UITextField = {
         let tf = UITextField()
         tf.placeholder = "Username"
         tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
         tf.borderStyle = .roundedRect
         tf.font = UIFont.systemFont(ofSize: 14)
         tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
         return tf
     }()

     let signUpButton: UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("Sign Up", for: .normal)
         button.setTitleColor(.white, for: .normal)
         button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
         button.layer.cornerRadius = 5
         button.isEnabled = false
         button.addTarget(self, action: #selector(signUpButtonPress), for: .touchUpInside)
         return button
     }()

     let alreadyHaveAccountButton: UIButton = {
         let button = UIButton(type: .system)
         let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ",
                                                         attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                                                                      NSAttributedString.Key.foregroundColor: UIColor.lightGray])
         attributedTitle.append(NSAttributedString(string: "Sign In",
                                                   attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
                                                                NSAttributedString.Key.foregroundColor: UIColor(red: 17/255,
                                                                                                                green: 154/255,
                                                                                                                blue: 237/255,
                                                                                                                alpha: 1)]))
         button.addTarget(self, action: #selector(backToLogin), for: .touchUpInside)
         button.setAttributedTitle(attributedTitle, for: .normal)
         return button
     }()
    // MARK: Properties
    var presenter: SignUpPresenterProtocol?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        configureViewComponents()
    }
    func configureViewComponents() {
        view.backgroundColor = .white
        view.addSubview(plusPhotoBtn)
        plusPhotoBtn.anchor(top: view.topAnchor,
                            left: nil,
                            bottom: nil,
                            right: nil,
                            paddingTop: 40,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 140,
                            height: 140)
        plusPhotoBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        let stackView = UIStackView(arrangedSubviews: [emailTextField, fullNameTextField, usernameTextField, passwordTextField, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.anchor(top: plusPhotoBtn.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: nil,
                         right: view.rightAnchor,
                         paddingTop: 24,
                         paddingLeft: 40,
                         paddingBottom: 0,
                         paddingRight: 40,
                         width: 0,
                         height: 240)
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(top: nil,
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

    // MARK: Actions
    @objc func backToLogin() {
        presenter?.backButtonPress()
    }
    @objc func signUpButtonPress() {
        guard let password = self.passwordTextField.text else {
            return
        }
        presenter?.signUpButtonPress(with: password)
    }

    @objc func handleSelectProfilePhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    @objc func formValidation() {
        presenter?.updateFormInformation(with: self.emailTextField.text ?? "",
                                         password: self.passwordTextField.text ?? "",
                                         fullName: self.fullNameTextField.text ?? "",
                                         userName: self.usernameTextField.text ?? "")
    }
}

extension SignUpView: UINavigationControllerDelegate {

}

extension SignUpView: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else {
            return
        }
        plusPhotoBtn.layer.cornerRadius = plusPhotoBtn.frame.width / 2
        plusPhotoBtn.layer.masksToBounds = true
        plusPhotoBtn.layer.borderColor = UIColor.black.cgColor
        plusPhotoBtn.layer.borderWidth = 2
        plusPhotoBtn.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        presenter?.profileImageSelected(with: profileImage.withRenderingMode(.alwaysOriginal))
        self.formValidation()
        self.dismiss(animated: true, completion: nil)
    }
}
extension SignUpView: SignUpViewProtocol {
    func enableSignUpButton() {
        signUpButton.isEnabled = true
        signUpButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
     }

     func dissableSignUpButton() {
        signUpButton.isEnabled = false
        signUpButton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
     }

    func showLoader() {
        DispatchQueue.main.async {
            let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
            Indicator.label.text = self.localizables.SignUpRegisterInProgressTitle
            Indicator.isUserInteractionEnabled = false
            Indicator.detailsLabel.text = self.localizables.loading
            Indicator.show(animated: true)
        }
    }

    func hiddeLoader() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }

    func didFinishRegisterSuccess(with title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle:UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: localizables.SignUpAlertDone, style: UIAlertAction.Style.default) { _ -> Void in
            self.presenter?.didRegisterSucces()
        })
        self.present(alertController, animated: true, completion: nil)
    }

    func didFinishRegisterError(with title: String, errorString: String?) {
        let alertController = UIAlertController(title: title, message: errorString, preferredStyle:UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: localizables.SignUpAlertDone, style: UIAlertAction.Style.default))
        self.present(alertController, animated: true, completion: nil)
    }
}

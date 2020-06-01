//
//  SignUpInteractor.swift
//  PeetMee
//
//  Created by Carlos Rodriguez Guerrero on 05/03/20.
//  Copyright © 2020 Carlos Rodriguez Guerrero. All rights reserved.
//

import Foundation
import Firebase
import UIKit
class SignUpInteractor: SignUpInteractorInputProtocol {
    // MARK: Properties
    weak var presenter: SignUpInteractorOutputProtocol?
    private let localizables = PeetMeeLocalizables()
    var localDatamanager: SignUpLocalDataManagerInputProtocol?
    var remoteDatamanager: SignUpRemoteDataManagerInputProtocol?
    private var email: String?
    private var fullName: String?
    private var userName: String?
    private var userImage: UIImage?

    func updateFormInformation(withEmail email: String, password: String, fullName: String, userName: String) {
        if self.validateEmail(withEmail: email),
            self.validatePassword(withPassword: password),
            validateFullName(withFullName: fullName),
            validateuserName(withuserName: userName),
            validateuserImage() {
            self.email = email
            self.fullName = fullName
            self.userName = userName
            presenter?.enableSignUpButton()
        } else {
            presenter?.dissableSignUpButton()
        }
    }

    func profileImageSelected(withImage image: UIImage) {
        self.userImage = image
    }
    func signUp(with password: String) {
        guard let uploadData = userImage?.jpegData(compressionQuality: 0.3) else { return }
        remoteDatamanager?.signUp(with: self.email ?? "",
                                  password: password,
                                  fullName: self.fullName ?? "",
                                  userName: self.userName ?? "",
                                  imageData: uploadData)
    }

    func validateEmail(withEmail email:String) -> Bool {
        if !email.isEmpty, email.isValidEmail() {
            return true
        } else {
            return false
        }
    }

    func validatePassword(withPassword password:String) -> Bool {
        if !password.isEmpty, password.isValidPassword() {
            return true
        } else {
            return false
        }
    }

    func validateFullName(withFullName fullName:String) -> Bool {
        if !fullName.isEmpty {
            return true
        } else {
            return false
        }
    }

    func validateuserName(withuserName userName:String) -> Bool {
        if !userName.isEmpty {
            return true
        } else {
            return false
        }
    }

    func validateuserImage() -> Bool {
        if nil != userImage {
            return true
        } else {
            return false
        }
    }
}

extension SignUpInteractor: SignUpRemoteDataManagerOutputProtocol {
    func didFinishRegister(with status: LoginStatus, error: Error?) {
        if status == .succes {
            presenter?.didFinishRegisterSucces(with: localizables.SignUpRegisterSuccesTitle, message: localizables.SignUpRegisterSuccesMessage)
        } else {
            presenter?.didFinishRegisterError(with: localizables.SignUpServerSideErroTitle, errorString: error?.localizedDescription ?? "")
        }
    }
}

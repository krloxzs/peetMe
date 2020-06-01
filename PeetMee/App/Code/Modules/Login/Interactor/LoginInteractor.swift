//
//  LoginInteractor.swift
//  PeetMee
//
//  Created by Carlos Rodriguez Guerrero on 04/03/20.
//  Copyright © 2020 Carlos Rodriguez Guerrero. All rights reserved.
//

import Foundation

class LoginInteractor: LoginInteractorInputProtocol {
    // MARK: Properties
    weak var presenter: LoginInteractorOutputProtocol?
    var localDatamanager: LoginLocalDataManagerInputProtocol?
    var remoteDatamanager: LoginRemoteDataManagerInputProtocol?
    private var email: String?
    func updateFormInformation(with email: String, password: String) {
        if self.validateEmail(withEmail: email),
            self.validatePassword(withPassword: password) {
            self.email = email
            presenter?.enableSignUpButton()
        } else {
            presenter?.dissableSignUpButton()
        }
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

    func login(with password: String) {
        remoteDatamanager?.loginUser(with: password, email: self.email ?? "")
    }
}

extension LoginInteractor: LoginRemoteDataManagerOutputProtocol {
}

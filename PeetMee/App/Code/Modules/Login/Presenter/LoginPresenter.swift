//
//  LoginPresenter.swift
//  PeetMee
//
//  Created by Carlos Rodriguez Guerrero on 04/03/20.
//  Copyright © 2020 Carlos Rodriguez Guerrero. All rights reserved.
//

import Foundation
import UIKit
class LoginPresenter {
    // MARK: Properties
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var wireFrame: LoginWireFrameProtocol?
}

extension LoginPresenter: LoginPresenterProtocol {
    func loginButtonPress(with password: String) {
        view?.showLoader()
        interactor?.login(with: password)
    }

    func viewDidLoad() {
    }

    func updateFormInformation(with email: String, password: String) {
        interactor?.updateFormInformation(with: email, password: password)
    }

    func presentSignUp(controller: UIViewController) {
        wireFrame?.presentSignUp(controller: controller)
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func enableSignUpButton() {
        view?.enableSignUpButton()
    }

    func dissableSignUpButton() {
        view?.dissableSignUpButton()
    }

}

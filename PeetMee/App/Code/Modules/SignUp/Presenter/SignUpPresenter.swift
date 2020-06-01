//
//  SignUpPresenter.swift
//  PeetMee
//
//  Created by Carlos Rodriguez Guerrero on 05/03/20.
//  Copyright © 2020 Carlos Rodriguez Guerrero. All rights reserved.
//

import Foundation
import UIKit

class SignUpPresenter {
    // MARK: Properties
    weak var view: SignUpViewProtocol?
    var interactor: SignUpInteractorInputProtocol?
    var wireFrame: SignUpWireFrameProtocol?
}

extension SignUpPresenter: SignUpPresenterProtocol {
    func updateFormInformation(with email: String, password: String, fullName: String, userName: String) {
        interactor?.updateFormInformation(withEmail: email,
                                          password: password,
                                          fullName: fullName,
                                          userName: userName)
    }

    func profileImageSelected(with image: UIImage) {
        interactor?.profileImageSelected(withImage: image)
    }

    func signUpButtonPress(with password: String) {
        view?.showLoader()
        interactor?.signUp(with: password)
    }

    func viewDidLoad() {
    }

    func backButtonPress() {
        guard let viewController = view as? UIViewController else {
            return
        }
        wireFrame?.backButtonPress(from: viewController)
    }

    func didRegisterSucces() {
        guard let viewController = view as? UIViewController else {
            return
        }
        wireFrame?.didFinishRegisterSuccesAndBackToLogin(from: viewController)
    }
}

extension SignUpPresenter: SignUpInteractorOutputProtocol {
    func didFinishRegisterSucces(with title: String, message: String) {
        view?.hiddeLoader()
        view?.didFinishRegisterSuccess(with: title, message: message)
    }

    func didFinishRegisterError(with title: String, errorString: String?) {
        view?.hiddeLoader()
        view?.didFinishRegisterError(with: "", errorString: errorString ?? "")
    }
    func enableSignUpButton() {
        view?.enableSignUpButton()
    }

    func dissableSignUpButton() {
        view?.dissableSignUpButton()
    }
}

//
//  SignUpProtocols.swift
//  PeetMee
//
//  Created by Carlos Rodriguez Guerrero on 05/03/20.
//  Copyright © 2020 Carlos Rodriguez Guerrero. All rights reserved.
//

import Foundation
import UIKit

enum LoginStatus: Int {
    case succes
    case error
}

protocol SignUpViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: SignUpPresenterProtocol? { get set }
    func didFinishRegisterError(with title: String, errorString: String?)
    func didFinishRegisterSuccess(with title: String, message: String)
    func showLoader()
    func hiddeLoader()
    func enableSignUpButton()
    func dissableSignUpButton()
}

protocol SignUpWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createSignUpModule() -> UIViewController
    func backButtonPress(from viewController: UIViewController)
    func didFinishRegisterSuccesAndBackToLogin(from viewController: UIViewController)
}

protocol SignUpPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: SignUpViewProtocol? { get set }
    var interactor: SignUpInteractorInputProtocol? { get set }
    var wireFrame: SignUpWireFrameProtocol? { get set }
    func viewDidLoad()
    func backButtonPress()
    func didRegisterSucces()
    func signUpButtonPress(with password: String)
    func updateFormInformation(with email: String, password: String, fullName: String, userName: String)
    func profileImageSelected(with image: UIImage)
}

protocol SignUpInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
    func didFinishRegisterSucces(with title: String, message: String)
    func didFinishRegisterError(with title: String, errorString: String?)
    func enableSignUpButton()
    func dissableSignUpButton()
}

protocol SignUpInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: SignUpInteractorOutputProtocol? { get set }
    var localDatamanager: SignUpLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: SignUpRemoteDataManagerInputProtocol? { get set }
    func signUp(with password: String)
    func updateFormInformation(withEmail email: String, password: String, fullName: String, userName: String)
    func profileImageSelected(withImage image: UIImage)
}

protocol SignUpDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol SignUpRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: SignUpRemoteDataManagerOutputProtocol? { get set }
    func signUp(with email: String, password: String, fullName: String, userName: String, imageData: Data)
}

protocol SignUpRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func didFinishRegister(with status: LoginStatus, error: Error?)
}

protocol SignUpLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}

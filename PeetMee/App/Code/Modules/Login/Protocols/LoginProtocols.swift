//
//  LoginProtocols.swift
//  PeetMee
//
//  Created by Carlos Rodriguez Guerrero on 04/03/20.
//  Copyright © 2020 Carlos Rodriguez Guerrero. All rights reserved.
//

import Foundation
import UIKit

protocol LoginViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: LoginPresenterProtocol? { get set }
    func showLoader()
    func hiddeLoader()
    func enableSignUpButton()
    func dissableSignUpButton()
}

protocol LoginWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createLoginModule() -> UIViewController
    func presentSignUp(controller: UIViewController)
}

protocol LoginPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var wireFrame: LoginWireFrameProtocol? { get set }
    func viewDidLoad()
    func presentSignUp(controller: UIViewController)
    func loginButtonPress(with password: String)
    func updateFormInformation(with email: String, password: String)
}

protocol LoginInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
    func enableSignUpButton()
    func dissableSignUpButton()
}

protocol LoginInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: LoginInteractorOutputProtocol? { get set }
    var localDatamanager: LoginLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: LoginRemoteDataManagerInputProtocol? { get set }
    func updateFormInformation(with email: String, password: String)
    func login(with password: String)
}

protocol LoginDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol LoginRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: LoginRemoteDataManagerOutputProtocol? { get set }
    func loginUser(with password: String, email: String)
}

protocol LoginRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol LoginLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}

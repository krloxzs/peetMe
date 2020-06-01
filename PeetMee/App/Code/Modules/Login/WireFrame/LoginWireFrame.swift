//
//  LoginWireFrame.swift
//  PeetMee
//
//  Created by Carlos Rodriguez Guerrero on 04/03/20.
//  Copyright © 2020 Carlos Rodriguez Guerrero. All rights reserved.
//

import Foundation
import UIKit

class LoginWireFrame: LoginWireFrameProtocol {
    class func createLoginModule() -> UIViewController {
        let view = LoginView()
        let presenter: LoginPresenterProtocol & LoginInteractorOutputProtocol = LoginPresenter()
        let interactor: LoginInteractorInputProtocol & LoginRemoteDataManagerOutputProtocol = LoginInteractor()
        let localDataManager: LoginLocalDataManagerInputProtocol = LoginLocalDataManager()
        let remoteDataManager: LoginRemoteDataManagerInputProtocol = LoginRemoteDataManager()
        let wireFrame: LoginWireFrameProtocol = LoginWireFrame()
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        return view
    }
    func presentSignUp(controller: UIViewController) {
        let signUp = SignUpWireFrame.createSignUpModule()
        controller.present(signUp, animated: true, completion: nil)
    }
}

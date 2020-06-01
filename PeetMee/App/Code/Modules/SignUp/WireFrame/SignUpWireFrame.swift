//
//  SignUpWireFrame.swift
//  PeetMee
//
//  Created by Carlos Rodriguez Guerrero on 05/03/20.
//  Copyright © 2020 Carlos Rodriguez Guerrero. All rights reserved.
//

import Foundation
import UIKit

class SignUpWireFrame: SignUpWireFrameProtocol {

    class func createSignUpModule() -> UIViewController {
        let view = SignUpView()
        let presenter: SignUpPresenterProtocol & SignUpInteractorOutputProtocol = SignUpPresenter()
        let interactor: SignUpInteractorInputProtocol & SignUpRemoteDataManagerOutputProtocol = SignUpInteractor()
        let localDataManager: SignUpLocalDataManagerInputProtocol = SignUpLocalDataManager()
        let remoteDataManager: SignUpRemoteDataManagerInputProtocol = SignUpRemoteDataManager()
        let wireFrame: SignUpWireFrameProtocol = SignUpWireFrame()
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

    func backButtonPress(from viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }

    func didFinishRegisterSuccesAndBackToLogin(from viewController: UIViewController) {
       viewController.dismiss(animated: true, completion: nil)
    }

    func didFinishLoginSucces(from viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}

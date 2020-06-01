//
//  SignUpRemoteDataManager.swift
//  PeetMee
//
//  Created by Carlos Rodriguez Guerrero on 05/03/20.
//  Copyright © 2020 Carlos Rodriguez Guerrero. All rights reserved.
//

import Foundation
import Firebase

class SignUpRemoteDataManager:SignUpRemoteDataManagerInputProtocol {
  var remoteRequestHandler: SignUpRemoteDataManagerOutputProtocol?
  private var constants: SignUpConstants = SignUpConstants()
  
  /// Funtion to register the user information in Firebase
  /// - Parameter imageData: The user image data for the profile
  func signUp(with email: String, password: String, fullName: String, userName: String, imageData: Data) {
    Auth.auth().createUser(withEmail: email.uppercased(), password: password) {[weak self] (result, error) in
      if let error: Error = error { self?.didReceiveError(error: error) }
      guard let result: AuthDataResult = result else { return }
      guard let self: SignUpRemoteDataManager = self else { return }
      let fileName: String = NSUUID().uuidString
      let storageRef: StorageReference = Storage.storage().reference().child(self.constants.storageReferenceProfileImages).child(fileName)
      self.putDataInFB(storageRef: storageRef,
                       fullName: fullName,
                       userName: userName,
                       result: result,
                       imageData: imageData)
    }
  }
  
  /// Place the image data into FB Server
  func putDataInFB(storageRef: StorageReference, fullName: String, userName: String, result: AuthDataResult, imageData: Data) {
    storageRef.putData(imageData, metadata: nil, completion: {[weak self] (_, error) in
      guard let self: SignUpRemoteDataManager = self else { return }
      if let error: Error = error { self.didReceiveError(error: error) }
      self.downloadURL(storageRef: storageRef,
                        fullName: fullName,
                        userName: userName,
                        result: result)
    })
  }
  ///Asynchronously retrieves a long lived download URL with a revokable token (download the image from server that we already save).
  ///This can be used to share the file with others, but can be revoked by a developer
  /// in the Firebase Console if desired.
  private func downloadURL(storageRef: StorageReference, fullName: String, userName: String, result: AuthDataResult) {
    storageRef.downloadURL(completion: { [weak self] (downloadURL, error) in
      guard let self: SignUpRemoteDataManager = self else { return }
      if let error: Error = error { self.didReceiveError(error: error) }
      guard let profileImageUrl: String = downloadURL?.absoluteString else { return }
      let uid: String = result.user.uid
      guard let fcmToken: String = Messaging.messaging().fcmToken else { return }
      let dictionaryValues: Dictionary = [self.constants.storageReferenceNameForDictionary: fullName,
                                          self.constants.storageReferenceFMCForDictionary: fcmToken,
                                          self.constants.storageReferenceUserNameForDictionary: userName,
                                          self.constants.storageReferenceProfileImageForDictionary: profileImageUrl]
      let values: Dictionary = [uid: dictionaryValues]
      self.updateValues(values: values)
    })
  }

  /// After registration, we save the user values in the DB
  /// - Parameter values: the user values to be save
  private func updateValues(values: [String: [String: String]] ) {
    USER_REF.updateChildValues(values, withCompletionBlock: { [weak self] (error, _) in
      if let error: Error = error {
        self?.remoteRequestHandler?.didFinishRegister(with: .error, error: error)
      } else {
        self?.remoteRequestHandler?.didFinishRegister(with: .succes, error: nil)
      }
    })
  }

  private func didReceiveError(error: Error) {
    self.remoteRequestHandler?.didFinishRegister(with: LoginStatus.error, error: error)
  }
}

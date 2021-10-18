//
//  UserGateway.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/28.
//

import Foundation

protocol UserGatewayProtocol {
    func getLoginUser(completion: @escaping (User) -> Void)
    func fetchAll(completion: @escaping ([User]) -> Void)
    func checkLoginUser(email: String,
                        passWord: String,
                        completion: @escaping (Bool) -> Void)
    func createUser(doc: [String: Any],
                    imageData: Data,
                    completion: @escaping (Bool) -> Void)
}

class UserGateway {

    var userUseCase: UserUsecaseProtocol!
    var dataStore: UserDataStoreProtocol!

    init(userUseCase: UserUsecaseProtocol) {
        self.userUseCase = userUseCase
    }

}

extension UserGateway: UserGatewayProtocol {

    func createUser(doc: [String: Any],
                    imageData: Data,
                    completion: @escaping (Bool) -> Void) {
        self.dataStore.createUser(doc: doc,
                                  imageData: imageData){
            bool in
            completion(bool)
        }
    }

    func checkLoginUser(email: String,
                        passWord: String,
                        completion: @escaping (Bool) -> Void) {
        dataStore.checkLoginUser(email: email,
                                 passWord: passWord) { [weak self] bool in
            completion(bool)
        }
    }



    func getLoginUser(completion: @escaping (User) -> Void) {
        dataStore.getLoginUser() { [weak self] user in
            completion(user)
        }
    }
    

    func fetchAll(completion: @escaping ([User]) -> Void) {
        dataStore.fetchAll() { [weak self] userList in
            guard self != nil else { return }
            completion(userList)
        }
    }

}

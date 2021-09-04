//
//  UserGateway.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/28.
//

import Foundation

protocol UserGatewayProtocol {
    func login()
    func signUp()
    func getLoginUser(completion: @escaping (User) -> Void)
    func fetchAll(completion: @escaping ([User]) -> Void)
}

class UserGateway {

    var useCase: ChatUseCaseProtocol!
    var dataStore: UserDataStoreProtocol!

    init(useCase: ChatUseCaseProtocol) {
        self.useCase = useCase
    }

}

extension UserGateway: UserGatewayProtocol {


    func login() {
    }

    func signUp() {
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

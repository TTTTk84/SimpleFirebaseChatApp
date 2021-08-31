//
//  UserGateway.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/28.
//

import Foundation
import Firebase

protocol UserGatewayProtocol {
    func login()
    func signUp()
    func fetchAll(completion: ([User]) -> Void)
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

    func fetchAll(completion: ([User]) -> Void) {
        dataStore.fetchAll() { [weak self] userList in
            guard self != nil else { return }
            completion(userList)
        }
    }

}

//
//  UserUseCase.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/10/03.
//

import Foundation

protocol UserUsecaseProtocol {
    func createUser(doc: [String: Any], imageData: Data, completion: @escaping (Bool) -> Void)
    func getLoginUser(completion: @escaping (User) -> Void)
    func checkLoginUser(email: String,
                        passWord: String,
                        completion: @escaping (Bool) -> Void)
    func fetchUserAll()

    var userGateway: UserGatewayProtocol! { get set }
    var userListOutput: ChatUseCaseUserListOutput! { get set }
}

protocol ChatUseCaseUserListOutput {
    func useCaseDidUpdate(userList: [User])
}

class UserUseCase {
    var userGateway: UserGatewayProtocol!
    var userListOutput: ChatUseCaseUserListOutput!

    private(set) var userList: [User] = []

    init() {}
}

extension UserUseCase: UserUsecaseProtocol {
    func createUser(doc: [String: Any],
                    imageData: Data,
                    completion: @escaping (Bool) -> Void) {
        self.userGateway.createUser(doc: doc,
                                    imageData: imageData) {
            bool in
            completion(bool)
        }
    }

    func fetchUserAll() {
        self.userGateway.fetchAll() { [weak self] userList in
            self?.userList = userList
            self?.userListOutput.useCaseDidUpdate(userList: self!.userList)
        }
    }

    func checkLoginUser(email: String, passWord: String, completion: @escaping (Bool) -> Void) {
        self.userGateway.checkLoginUser(email: email,
                                        passWord: passWord) {[weak self] bool in
            completion(bool)
        }
    }

    func getLoginUser(completion: @escaping (User) -> Void) {
        self.userGateway.getLoginUser() { [weak self] user in
            completion(user)
        }
    }
}

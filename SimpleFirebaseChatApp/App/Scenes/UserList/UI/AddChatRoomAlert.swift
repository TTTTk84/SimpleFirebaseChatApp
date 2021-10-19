//
//  AddChatRoomAlert.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/09/07.
//

import UIKit

protocol AddChatRoomAlertProtocol {
    func createChatRoomAlert()
}

class AddChatRoomAlert: AddChatRoomAlertProtocol {

    var useCase: ChatRoomUsecaseProtocol!
    var selectedUsers: [String]!
    var view: UserListAlertProtocol!

    init(selectedUsers: [String],
         useCase: ChatRoomUsecaseProtocol,
         view: UserListAlertProtocol) {
        self.useCase = useCase
        self.selectedUsers = selectedUsers
        self.view = view
    }


    public func createChatRoomAlert() {
        var alertTextField: UITextField?

        let alert = UIAlertController(
            title: "チャットルーム名を入力してください",
            message: "",
            preferredStyle: UIAlertController.Style.alert)
        alert.addTextField(
            configurationHandler: {(textField: UITextField!) -> Void in
                alertTextField = textField
            })

        let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)

        let okAction = UIAlertAction(title: "追加", style: UIAlertAction.Style.default) { [self] _ in
            if let text = alertTextField?.text {
                self.useCase.createChatRoom(chatRoomName: text, members: self.selectedUsers)
                self.useCase.fetchChatRoomAll()
                self.view.transitonToChatList()
            }
        }

        


        alert.addAction(okAction)
        alert.addAction(cancelAction)

        view.didUpdateAlert(alert: alert)
    }
}

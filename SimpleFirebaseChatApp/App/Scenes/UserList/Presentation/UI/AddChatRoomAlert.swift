//
//  AddChatRoomAlert.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/09/07.
//

import UIKit

class AddChatRoomAlert {

    var useCase: ChatRoomUsecaseProtocol!
    var selectedUsers: [User]!

    init(selectedUsers: [User], useCase: ChatRoomUsecaseProtocol) {
        self.useCase = useCase
        self.selectedUsers = selectedUsers

        //self.createChatRoomAlert()
    }

    public func createChatRoomAlert() {
        var alertTextField: UITextField?

        let alert = UIAlertController(
            title: "チャットルーム名を入力してください",
            message: "",
            preferredStyle: UIAlertController.Style.alert)
        alert.addTextField(
            configurationHandler: {(textField: UITextField!) in
                alertTextField = textField
            })

        let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)

        let okAction = UIAlertAction(title: "追加", style: UIAlertAction.Style.default) { [self] _ in
            if let text = alertTextField?.text {
                self.useCase.createChatRoom(chatRoomName: text, members: self.selectedUsers)
            }
        }

        alert.addAction(cancelAction)
        alert.addAction(okAction)

    }
}

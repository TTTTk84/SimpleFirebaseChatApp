//
//  ChatListCell.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/25.
//

import UIKit

class ChatListCell: UITableViewCell {

    static let cellIdentifier = "ChatListCell"

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var partnerLabel: UILabel!
    @IBOutlet weak var latestMessageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    func setupValue(partnerLabel: String, latestMessageLabel: String) {
        self.partnerLabel.text = partnerLabel
        self.latestMessageLabel.text = latestMessageLabel
    }

}

//
//  ChatRoomPartnerCell.swift
//  SimpleFirebaseChatApp
//
//  Created by tk84 on 2021/08/25.
//

import UIKit

class ChatRoomPartnerUserCell: UITableViewCell {

    static let cellIdentifier = "ChatRoomPartnerUserCell"

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.messageTextView.layer.cornerRadius = 15
        self.messageTextView.isEditable = false
        self.messageTextView.isSelectable = false
        self.messageTextView.isScrollEnabled = false
    }
}

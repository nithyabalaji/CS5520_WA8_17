//
//  UserMessageTableViewCell.swift
//  WA8_17
//
//  Created by Ashmitha appandaraju on 11/12/24.
//

import UIKit

class UserMessageTableViewCell: UITableViewCell {
    let messageLabel = UILabel()
    let messageBackgroundView = UIView()
    let timestampLabel = UILabel()
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            setupMessageBackgroundView()
            setupMessageLabel()
            setupTimestampLabel()
            setupConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setupMessageBackgroundView() {
            messageBackgroundView.backgroundColor = UIColor.systemBlue
            messageBackgroundView.layer.cornerRadius = 12
            messageBackgroundView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(messageBackgroundView)
        }
        
        func setupMessageLabel() {
            messageLabel.font = UIFont.systemFont(ofSize: 16)
            messageLabel.textColor = .white
            messageLabel.numberOfLines = 0
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            messageBackgroundView.addSubview(messageLabel)
        }
    func setupTimestampLabel() {
            timestampLabel.font = UIFont.systemFont(ofSize: 12)
            timestampLabel.textColor = .lightGray
            timestampLabel.textAlignment = .right
            timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        messageBackgroundView.addSubview(timestampLabel)
        }
        
         func setupConstraints() {
            NSLayoutConstraint.activate([
                // Background view constraints
                messageBackgroundView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 8),
                            messageBackgroundView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -8),
                            messageBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                            messageBackgroundView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.centerXAnchor),
              
                // Message label constraints
                messageLabel.topAnchor.constraint(equalTo: messageBackgroundView.topAnchor, constant: 8),
                messageLabel.bottomAnchor.constraint(equalTo: messageBackgroundView.bottomAnchor, constant: -8),
                messageLabel.leadingAnchor.constraint(equalTo: messageBackgroundView.leadingAnchor, constant: 12),
                messageLabel.trailingAnchor.constraint(equalTo: messageBackgroundView.trailingAnchor, constant: -12),
                
                timestampLabel.topAnchor.constraint(equalTo: messageBackgroundView.bottomAnchor, constant: 0),
                timestampLabel.trailingAnchor.constraint(equalTo: messageBackgroundView.trailingAnchor, constant: -8),
                //timestampLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            ])
        }
        
        func setMessage(_ message: String) {
            messageLabel.text = message
        }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

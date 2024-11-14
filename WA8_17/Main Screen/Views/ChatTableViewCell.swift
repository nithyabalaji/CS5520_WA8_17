//
//  ChatTableViewCell.swift
//  WA8_17
//
//  Created by Ashmitha appandaraju on 11/6/24.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    static let identifier = "ChatTableViewCell"
    var wrapperCellView: UIView!
        var labelSenderName: UILabel!
        var labelMessage: UILabel!
        var labelTimestamp: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           
           setupWrapperCellView()
           setupLabelSenderName()
           setupLabelMessage()
           setupLabelTimestamp()
           
           initConstraints()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    func setupWrapperCellView() {
           wrapperCellView = UIView()
           wrapperCellView.backgroundColor = .white
           wrapperCellView.layer.cornerRadius = 6.0
           wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
           wrapperCellView.layer.shadowOffset = .zero
           wrapperCellView.layer.shadowRadius = 4.0
           wrapperCellView.layer.shadowOpacity = 0.4
           wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
           self.addSubview(wrapperCellView)
       }
       
       func setupLabelSenderName() {
           labelSenderName = UILabel()
           labelSenderName.font = UIFont.boldSystemFont(ofSize: 16)
           labelSenderName.translatesAutoresizingMaskIntoConstraints = false
           wrapperCellView.addSubview(labelSenderName)
       }
       
       func setupLabelMessage() {
           labelMessage = UILabel()
           labelMessage.font = UIFont.systemFont(ofSize: 14)
           labelMessage.textColor = .darkGray
           labelMessage.translatesAutoresizingMaskIntoConstraints = false
           wrapperCellView.addSubview(labelMessage)
       }
       
       func setupLabelTimestamp() {
           labelTimestamp = UILabel()
           labelTimestamp.font = UIFont.systemFont(ofSize: 12)
           labelTimestamp.textColor = .lightGray
           labelTimestamp.textAlignment = .right
           labelTimestamp.translatesAutoresizingMaskIntoConstraints = false
           wrapperCellView.addSubview(labelTimestamp)
       }
       
       // MARK: - Setting up Constraints
       
       func initConstraints() {
           NSLayoutConstraint.activate([
               wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
               wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
               wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
               wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
               
               labelSenderName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
               labelSenderName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
               labelSenderName.trailingAnchor.constraint(lessThanOrEqualTo: labelTimestamp.leadingAnchor, constant: -8),
               
               labelTimestamp.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
               labelTimestamp.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
               
               labelMessage.topAnchor.constraint(equalTo: labelSenderName.bottomAnchor, constant: 4),
               labelMessage.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
               labelMessage.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
               labelMessage.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -8)
           ])
       }
    
    func setTimestamp(_ timestamp: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z" // Match the input format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        if let date = dateFormatter.date(from: timestamp) {
            let now = Date()
            let timeInterval = now.timeIntervalSince(date)

            if timeInterval < 12 * 60 * 60 { // Less than 12 hours
                // Display as local time (e.g., "2:55 PM")
                let timeFormatter = DateFormatter()
                timeFormatter.dateFormat = "h:mm a" // Format as "2:55 PM"
                timeFormatter.locale = Locale.current
                labelTimestamp.text = timeFormatter.string(from: date)
            } else {
                // Display as relative time (e.g., "yesterday," "2 days ago")
                let relativeFormatter = RelativeDateTimeFormatter()
                relativeFormatter.unitsStyle = .full
                labelTimestamp.text = relativeFormatter.localizedString(for: date, relativeTo: now)
            }
        } else {
            // Fallback if parsing fails
            labelTimestamp.text = ""
        }
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

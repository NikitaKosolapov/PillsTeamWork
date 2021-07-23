//
//  JournalTableViewCell.swift
//  Pills
//
//  Created by aprirez on 7/23/21.
//

import UIKit

class JournalTableViewCell: UITableViewCell {

    private var entryID: Int = 0
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()

    private let numFormatter: NumberFormatter = {
        let numFormatter = NumberFormatter()
        numFormatter.minimumFractionDigits = 0
        numFormatter.maximumFractionDigits = 2
        numFormatter.numberStyle = .decimal
        return numFormatter
    }()

    private var pillTypeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    private let pillNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let pillTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private let singleDoseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()

    private var journalTime: Date? {
        willSet(time) {
            let dateInFormat = dateFormatter.string(from: time ?? Date().startOfDay)
            self.timeLabel.text = dateInFormat
        }
    }

    private var journalEntry: RealmMedKitEntry? {
        willSet(item) {
            guard let item = item else {
                self.pillNameLabel.text = "#error"
                self.pillTypeLabel.text = "#error"
                self.singleDoseLabel.text = ""
                return
            }
            self.pillTypeImage.image = AppImages.pillsImages[item.pillType] ?? UIImage()
            self.pillNameLabel.text = item.name
            self.pillTypeLabel.text = "\(item.pillType.rawValue.localized()):"
            self.singleDoseLabel.text = numFormatter.string(from: item.singleDose as NSNumber)
        }
    }

    func configure(model: JournalTableView.Event) {
        self.journalTime = model.time
        self.journalEntry = model.pill
    }

    private func addSubviews() {
        addSubview(pillTypeImage)
        addSubview(pillNameLabel)
        addSubview(pillTypeLabel)
        addSubview(singleDoseLabel)
        addSubview(timeLabel)
    }

    // swiftlint:disable function_body_length
    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            pillTypeImage.topAnchor
                .constraint(equalTo: contentView.topAnchor, constant: 10),
            pillTypeImage.leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor, constant: 10),
            pillTypeImage.widthAnchor
                .constraint(equalToConstant: 50),
            pillTypeImage.heightAnchor
                .constraint(equalToConstant: 50),

            pillNameLabel.topAnchor
                .constraint(equalTo: contentView.topAnchor, constant: 10),
            pillNameLabel.leadingAnchor
                .constraint(equalTo: pillTypeImage.trailingAnchor, constant: 10),
            pillNameLabel.widthAnchor
                .constraint(equalToConstant: bounds.width / 2),
            pillNameLabel.heightAnchor
                .constraint(equalToConstant: 20),

            pillTypeLabel.topAnchor
                .constraint(equalTo: pillNameLabel.bottomAnchor, constant: 10),
            pillTypeLabel.leadingAnchor
                .constraint(equalTo: pillTypeImage.trailingAnchor, constant: 10),
            pillTypeLabel.widthAnchor
                .constraint(equalToConstant: 90),
            pillTypeLabel.heightAnchor
                .constraint(equalToConstant: 20),

            singleDoseLabel.topAnchor
                .constraint(equalTo: pillNameLabel.bottomAnchor, constant: 10),
            singleDoseLabel.leadingAnchor
                .constraint(equalTo: pillTypeLabel.trailingAnchor, constant: 0),
            singleDoseLabel.widthAnchor
                .constraint(equalToConstant: 60),
            singleDoseLabel.heightAnchor
                .constraint(equalToConstant: 20),

            timeLabel.topAnchor
                .constraint(equalTo: contentView.topAnchor, constant: 10),
            timeLabel.leadingAnchor
                .constraint(equalTo: pillNameLabel.trailingAnchor, constant: 10),
            timeLabel.trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor, constant: 0),
            timeLabel.bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

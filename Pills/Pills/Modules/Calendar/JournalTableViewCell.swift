//
//  JournalTableViewCell.swift
//  Pills
//
//  Created by aprirez on 7/23/21.
//

import UIKit

final class JournalTableViewCell: UITableViewCell {

    class CellTheme {
        static let pillNameFont = AppLayout.Fonts.normalSemibold

        static let timeFont = AppLayout.Fonts.normalRegular
        static let timeLabelSize = CGSize(width: 54, height: 18)

        static let instructionFont = AppLayout.Fonts.smallRegular
        static let instructionTextColor = AppColors.semiTransparentBlack

        static let cellCornerRadius: CGFloat = 10
        static let cellBackgroundColor = AppColors.cellBackgroundColor
        static let cellVerticalSpacing: CGFloat = 8
        static let cellPaddingTop: CGFloat = 18
        static let cellPaddingBottom: CGFloat = 18
        static let cellHorizontalSpacing: CGFloat = 8

        static let pillImageSize = CGSize(width: 28, height: 28)
        static let pillImageContainerSize = CGSize(width: 36, height: 36)
        static let pillImageContainerRadius: CGFloat = 18

        static let defaultStackViewSpacing: CGFloat = 10

        static let cellHeight: CGFloat = 80
    }

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

    private var majorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CellTheme.cellBackgroundColor
        view.layer.cornerRadius = CellTheme.cellCornerRadius
        return view
    }()

    private var pillTypeImageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = CellTheme.pillImageContainerRadius
        return view
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
        label.font = CellTheme.pillNameFont
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.textColor = CellTheme.instructionTextColor
        label.font = CellTheme.instructionFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = CellTheme.timeFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.backgroundColor = UIColor.white.cgColor
        label.layer.cornerRadius = 4
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                self.pillTypeImageContainer,
                self.stackViewVertical
            ])
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = CellTheme.defaultStackViewSpacing
        stackView.alignment = .leading
        return stackView
    }()

    private lazy var stackViewNameAndTime: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                self.pillNameLabel,
                self.timeLabel
            ])
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = CellTheme.defaultStackViewSpacing
        return stackView
    }()

    private lazy var stackViewVertical: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                self.stackViewNameAndTime,
                self.instructionLabel
            ])
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()

    private var journalTime: Date? {
        willSet(time) {
            let dateInFormat = dateFormatter.string(from: time ?? Date().startOfDay)
            self.timeLabel.text = dateInFormat
        }
    }

    private var journalEntry: RealmMedKitEntry? {
        willSet(item) {
            guard let item = item,
                  let image = AppImages.pillsImages[item.pillType]
            else {
                self.pillNameLabel.text = "#error"
                self.instructionLabel.text = ""
                return
            }

            self.pillTypeImage.image = image
            self.pillNameLabel.text = item.name
            let type = item.pillType.rawValue.localized()
            let dose = numFormatter.string(from: item.singleDose as NSNumber) ?? "#error"
            let unit = item.unit.rawValue.localized()
            let usage = item.usage.rawValue.localized()
            self.instructionLabel.text =
                "\(type), \(dose) \(unit), \(usage)"
        }
    }
    
    func configure(model: JournalTableView.Event) {
        self.journalTime = model.time
        self.journalEntry = model.pill
    }

    override func updateConstraints() {
        super.updateConstraints()

        NSLayoutConstraint.activate([
            majorView.topAnchor
                .constraint(equalTo: contentView.topAnchor),
            majorView.leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor),
            majorView.widthAnchor
                .constraint(equalToConstant: contentView.frame.width),
            majorView.heightAnchor
                .constraint(equalToConstant: contentView.frame.height - CellTheme.cellVerticalSpacing),

            stackView.topAnchor
                .constraint(equalTo: majorView.topAnchor, constant: CellTheme.cellPaddingTop),
            stackView.leadingAnchor
                .constraint(equalTo: majorView.leadingAnchor, constant: CellTheme.cellHorizontalSpacing),
            stackView.trailingAnchor
                .constraint(equalTo: majorView.trailingAnchor, constant: -CellTheme.cellHorizontalSpacing),
            stackView.bottomAnchor
                .constraint(equalTo: majorView.bottomAnchor, constant: -CellTheme.cellPaddingBottom),

            pillTypeImageContainer.widthAnchor
                .constraint(equalToConstant: CellTheme.pillImageContainerSize.width),
            pillTypeImageContainer.heightAnchor
                .constraint(equalToConstant: CellTheme.pillImageContainerSize.height),

            pillTypeImage.topAnchor
                .constraint(
                    equalTo: pillTypeImageContainer.topAnchor,
                    constant: (CellTheme.pillImageContainerSize.height - CellTheme.pillImageSize.height) / 2
                ),
            pillTypeImage.leadingAnchor
                .constraint(
                    equalTo: pillTypeImageContainer.leadingAnchor,
                    constant: (CellTheme.pillImageContainerSize.width - CellTheme.pillImageSize.width) / 2
                ),
            pillTypeImage.widthAnchor
                .constraint(equalToConstant: CellTheme.pillImageSize.width),
            pillTypeImage.heightAnchor
                .constraint(equalToConstant: CellTheme.pillImageSize.height),

            timeLabel.widthAnchor
                .constraint(equalToConstant: CellTheme.timeLabelSize.width),
            timeLabel.heightAnchor
                .constraint(equalToConstant: CellTheme.timeLabelSize.height)
        ])
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        pillTypeImageContainer.addSubview(pillTypeImage)
        majorView.addSubview(stackView)
        addSubview(majorView)

        setNeedsUpdateConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

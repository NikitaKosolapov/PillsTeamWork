//
//  JournalTableViewCell.swift
//  Pills
//
//  Created by aprirez on 7/23/21.
//

import UIKit

final class JournalTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
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
    
    private lazy var majorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppLayout.Journal.cellBackgroundColor
        view.layer.cornerRadius = AppLayout.Journal.cellCornerRadius
        view.layer.borderWidth = traitCollection.userInterfaceStyle == .dark ? 1 : 0
        return view
    }()
    
    private var pillTypeImageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColors.whiteOnly
        view.layer.cornerRadius = AppLayout.Journal.pillImageContainerRadius
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
        label.textColor = AppColors.black
        label.font = AppLayout.Journal.pillNameFont
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.black
        label.font = AppLayout.Journal.instructionFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let usageLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.black
        label.font = AppLayout.Journal.instructionFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.blackOnly
        label.font = AppLayout.Journal.timeFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.backgroundColor = AppColors.whiteOnly.cgColor
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
        stackView.spacing = AppLayout.Journal.defaultStackViewSpacing
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var stackViewNameAndTime: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                self.pillNameLabel,
                self.timeLabel
            ])
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = AppLayout.Journal.defaultStackViewSpacing
        return stackView
    }()
    
    private lazy var stackViewInstructionAndUsage: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                self.instructionLabel,
                self.usageLabel
            ])
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = AppLayout.Journal.defaultStackViewSpacing
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var stackViewVertical: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                self.stackViewNameAndTime,
                self.stackViewInstructionAndUsage
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
            guard let item = item
            else {
                self.pillNameLabel.text = "#error"
                self.instructionLabel.text = ""
                return
            }
            
            self.pillTypeImage.image = item.pillType.image()
            self.pillNameLabel.text = item.name
            let dose = numFormatter.string(from: item.singleDose as NSNumber) ?? "#error"
            let unit = item.unitString.localized()
            let usage = item.usage.rawValue.localized()
            self.instructionLabel.text = "\(dose) \(unit)"
            self.usageLabel.text = "\(usage)"
        }
    }
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        majorView.layer.borderWidth = traitCollection.userInterfaceStyle == .dark ? 1 : 0
    }
    
    // MARK: - Public Methods
    
    public func configure(model: Event) {
        journalTime = model.time
        journalEntry = model.pill
        if let isUsed = model.pill.schedule.first?.isUsed.value {
            majorView.backgroundColor = isUsed ? AppColors.lightBlueSapphire : AppColors.lightRed
            majorView.layer.borderColor = isUsed ? AppColors.blue.cgColor : AppColors.red.cgColor
        }
    }
    
    // swiftlint:disable function_body_length
    override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.activate([
            majorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            majorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            majorView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            majorView.heightAnchor.constraint(
                equalToConstant: contentView.frame.height - AppLayout.Journal.cellVerticalSpacing
            ),
            
            stackView.topAnchor.constraint(
                equalTo: majorView.topAnchor,
                constant: AppLayout.Journal.cellPaddingTop
            ),
            stackView.leadingAnchor.constraint(
                equalTo: majorView.leadingAnchor,
                constant: AppLayout.Journal.cellHorizontalSpacing
            ),
            stackView.trailingAnchor.constraint(
                equalTo: majorView.trailingAnchor,
                constant: -AppLayout.Journal.cellHorizontalSpacing
            ),
            stackView.bottomAnchor.constraint(
                equalTo: majorView.bottomAnchor,
                constant: -AppLayout.Journal.cellPaddingBottom
            ),
            
            pillTypeImageContainer.widthAnchor.constraint(
                equalToConstant: AppLayout.Journal.pillImageContainerSize.width
            ),
            pillTypeImageContainer.heightAnchor.constraint(
                equalToConstant: AppLayout.Journal.pillImageContainerSize.height
            ),
            
            pillTypeImage.topAnchor.constraint(
                equalTo: pillTypeImageContainer.topAnchor,
                constant: (
                    AppLayout.Journal.pillImageContainerSize.height -
                    AppLayout.Journal.pillImageSize.height
                ) / 2
            ),
            pillTypeImage.leadingAnchor.constraint(
                equalTo: pillTypeImageContainer.leadingAnchor,
                constant: (
                    AppLayout.Journal.pillImageContainerSize.width -
                    AppLayout.Journal.pillImageSize.width
                ) / 2
            ),
            pillTypeImage.widthAnchor.constraint(equalToConstant: AppLayout.Journal.pillImageSize.width),
            pillTypeImage.heightAnchor.constraint(equalToConstant: AppLayout.Journal.pillImageSize.height),
            
            timeLabel.widthAnchor.constraint(equalToConstant: AppLayout.Journal.timeLabelSize.width),
            timeLabel.heightAnchor.constraint(equalToConstant: AppLayout.Journal.timeLabelSize.height)
        ])
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        self.selectionStyle = .none
        self.layer.cornerRadius = AppLayout.Journal.cellCornerRadius
        self.clipsToBounds = true
        self.backgroundColor = .clear
        setNeedsUpdateConstraints()
    }
    
    private func addSubviews() {
        pillTypeImageContainer.addSubview(pillTypeImage)
        majorView.addSubview(stackView)
        addSubview(majorView)
    }
    
}

//
//  JournalTableViewCell.swift
//  Pills
//
//  Created by aprirez on 7/23/21.
//

import UIKit
import UIKit

final class JournalTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private var acceptedType: AcceptedType?
    
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
        view.layer.cornerRadius = AppLayout.Journal.cellCornerRadius
        view.isUserInteractionEnabled = true
        view.layer.borderWidth = traitCollection.userInterfaceStyle == .dark ? 1 : 0
        view.layer.borderColor = UIColor.clear.cgColor
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
        label.textColor = AppColors.semiGrayFont
        label.font = AppLayout.Journal.instructionFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let usageLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.semiGrayFont
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
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        let theme = traitCollection.userInterfaceStyle
        
        switch theme {
        case .unspecified:
            print("None")
        case .light:
            switch acceptedType {
            case .used:
                majorView.backgroundColor = highlighted ? AppColors.highlighedBlue : AppColors.lightBlueSapphire
            case .unused:
                majorView.backgroundColor = highlighted ? AppColors.highlightedRed : AppColors.lightRed
            case .undefined:
                majorView.backgroundColor = highlighted ? AppColors.highlightedGray : AppColors.lightGray
            case .none:
                break
            }
        case .dark:
            switch acceptedType {
            case .used:
                majorView.backgroundColor = highlighted ? AppColors.highlighedBlue : AppColors.lightBlueSapphire
            case .unused:
                majorView.backgroundColor = highlighted ? AppColors.highlightedRed : AppColors.lightRed
            case .undefined:
                majorView.backgroundColor = highlighted ? AppColors.sapphireDark : AppColors.lightGray
            case .none:
                break
            }
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        majorView.layer.borderWidth = traitCollection.userInterfaceStyle == .dark ? 1 : 0
    }
    
    // swiftlint: disable function_body_length
    override func updateConstraints() {
        super.updateConstraints()
        
        majorView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(contentView.frame.width)
            $0.height.equalTo(contentView.frame.height - AppLayout.Journal.cellVerticalSpacing)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(AppLayout.Journal.cellPaddingTop)
            $0.leading.trailing.equalToSuperview().inset(AppLayout.Journal.cellHorizontalSpacing)
            $0.bottom.equalTo(majorView.snp.bottom).offset(-AppLayout.Journal.cellPaddingBottom)
        }
        
        pillTypeImageContainer.snp.makeConstraints {
            $0.size.equalTo(AppLayout.Journal.pillImageContainerSize)
        }
        
        pillTypeImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(AppLayout.Journal.pillTypeImagePaddingTop)
            $0.leading.equalToSuperview().inset(AppLayout.Journal.pillTypeImagePaddingTop)
            $0.size.equalTo(AppLayout.Journal.pillImageSize)
        }
        
        timeLabel.snp.makeConstraints {
            $0.width.height.equalTo(AppLayout.Journal.timeLabelSize)
        }
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
        contentView.addSubview(majorView)
        majorView.addSubview(stackView)
        pillTypeImageContainer.addSubview(pillTypeImage)
    }
    
    // MARK: - Public Methods
    
    func configure(model: Event) {
        journalTime = model.time
        journalEntry = model.pill
        acceptedType = model.pill.schedule.first?.acceptedType
        
        switch acceptedType {
        case .used:
            majorView.backgroundColor = AppColors.lightBlueSapphire
            majorView.layer.borderColor = AppColors.blue.cgColor
        case .unused:
            majorView.backgroundColor = AppColors.lightRed
            majorView.layer.borderColor = AppColors.red.cgColor
        case .undefined:
            majorView.backgroundColor = AppColors.lightGray
        case .none:
            break
        }
    }
}

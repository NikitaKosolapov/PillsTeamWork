//
//  CalendarCell.swift
//  Pills
//
//  Created by Rayen on 14.08.2021.
//
import FSCalendar

class CalendarCell: FSCalendarCell {
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let view = UIView(frame: self.bounds)
        self.backgroundView = view
        view.backgroundColor = AppColors.white
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundView?.frame = self.bounds.insetBy(dx: 0, dy: 0.5)
    }
    
}

//
//  CalendarCell.swift
//  Pills
//
//  Created by Rayen on 14.08.2021.
//
import FSCalendar

class CalendarCell: FSCalendarCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let view = UIView(frame: self.bounds)
        self.backgroundView = view
        view.backgroundColor = AppColors.AidKit.background
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundView?.frame = self.bounds.insetBy(dx: 0, dy: 0.5)
    }
}

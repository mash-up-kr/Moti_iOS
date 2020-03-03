//
//  UIDatePickerView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/02/18.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import UIKit

class UIDatePickerView: UIControl {
    
    var monthWheel: UIWheelView!
    var yearWheel: UIWheelView!
    var dayWheel: UIWheelView!
    
    var dateValidator: DateValidator = DateValidator()
    
    let yearOffset: Int = 150
    var maximumYear: Int? {
        didSet {
            dateValidator.maximumYear = maximumYear
        }
    }
    var date: Date = Date() {
        didSet {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            let month = calendar.component(.month, from: date)
            let day = calendar.component(.day, from: date)
            yearWheel.selectedItem = year
            monthWheel.selectedItem = month
            dayWheel.selectedItem = day
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        guard let superView = superview else { return }
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black
        
        let now = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: now)
        let month = calendar.component(.month, from: now)
        let day = calendar.component(.day, from: now)

        yearWheel = UIWheelView(items: Array((year - yearOffset)...(year + yearOffset)))
        yearWheel.delegate = self
        yearWheel.selectedItem = year
        
        monthWheel = UIWheelView(items: Array(1...12))
        monthWheel.delegate = self
        monthWheel.selectedItem = month
        
        dayWheel = UIWheelView(items: Array(1...31))
        dayWheel.delegate = self
        dayWheel.selectedItem = day
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        addSubview(stackView)
        
        stackView.addArrangedSubview(yearWheel)
        stackView.addArrangedSubview(monthWheel)
        stackView.addArrangedSubview(dayWheel)
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

extension UIDatePickerView: UIWheelViewDelegate {
    func wheelView(_ wheelView: UIWheelView, didSelectItem item: Int) {
        let year = yearWheel.selectedItem
        let month = monthWheel.selectedItem
        let day = dayWheel.selectedItem

        let dateComponents = DateComponents(year: year, month: month, day: day)
        let suggestedDateComponents = dateValidator.validatedDateComponents(from: dateComponents)
        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withFullDate
        date = formatter.date(from: "\(suggestedDateComponents.year!)-\(suggestedDateComponents.month!)-\(suggestedDateComponents.day!)") ?? date
        sendActions(for: .valueChanged)
    }
}

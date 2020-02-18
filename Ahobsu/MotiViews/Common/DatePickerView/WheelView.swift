//
//  WheelView.swift
//  Ahobsu
//
//  Created by JU HO YOON on 2020/02/18.
//  Copyright © 2020 ahobsu. All rights reserved.
//

import UIKit

protocol WheelViewDelegate: class {
    func wheelView(_ wheelView: WheelView, didSelectItem item: Int)
}

class WheelView: UIView {
    
    enum SectionAccessoryViewType {
        case header, footer
    }
    
    weak var delegate: WheelViewDelegate?
    
    var tableView: UITableView!
    var items: [Int]
    private var _selectedItem: Int = 0
    var selectedItem: Int {
        set {
            if let selectedRow = items.firstIndex(of: newValue) {
                tableView.scrollToRow(at: IndexPath(row: selectedRow, section: 0), at: .top, animated: true)
                _selectedItem = newValue
            }
        }
        get {
            return _selectedItem
        }
    }
    
    var upperSeparator: UIView!
    var lowerSeparator: UIView!
    
    // Constants
    var itemSize: CGSize = CGSize(width: 72 + 8, height: 44)
    var gradientColor: UIColor = .black
    var separatorColor: UIColor = .lightgold
    var cellTextColor: UIColor = .rosegold
    var cellTextFont: UIFont = UIFont(name: "IropkeBatangOTFM", size: 24) ?? UIFont.systemFont(ofSize: 20)
    
    private var selectionFeedback: UISelectionFeedbackGenerator? = UISelectionFeedbackGenerator()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: itemSize.width, height: itemSize.height * 3 - 8)
    }
    
    init(items: [Int]) {
        self.items = items
        super.init(frame: .zero)
        setupView()
        setupLayout()
        selectionFeedback?.prepare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
        clipsToBounds = true
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = itemSize.height
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.bounces = false
        tableView.delaysContentTouches = true
        tableView.reloadData()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "CellHeaderFooter")
        
        upperSeparator = UIView()
        upperSeparator.backgroundColor = separatorColor
        
        lowerSeparator = UIView()
        lowerSeparator.backgroundColor = separatorColor
        
        addSubview(tableView)
        addSubview(upperSeparator)
        addSubview(lowerSeparator)
    }
    
    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        upperSeparator.translatesAutoresizingMaskIntoConstraints = false
        upperSeparator.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -itemSize.height / 2).isActive = true
        upperSeparator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        upperSeparator.widthAnchor.constraint(equalToConstant: itemSize.width).isActive = true
        upperSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        lowerSeparator.translatesAutoresizingMaskIntoConstraints = false
        lowerSeparator.centerYAnchor.constraint(equalTo: centerYAnchor, constant: itemSize.height / 2).isActive = true
        lowerSeparator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lowerSeparator.widthAnchor.constraint(equalToConstant: itemSize.width).isActive = true
        lowerSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func dequeueHeaderFooter(from tableView: UITableView, type: SectionAccessoryViewType) -> UITableViewHeaderFooterView {
        let headerFooter = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CellHeaderFooter")!
        if headerFooter.backgroundView == nil {
            let view = UIView()
            view.backgroundColor = gradientColor.withAlphaComponent(0.5)
            headerFooter.backgroundView = view
        }
        return headerFooter
    }
}

extension WheelView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.font = cellTextFont
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = cellTextColor
        cell.textLabel?.text = "\(items[indexPath.row])"
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        return cell
    }
}

extension WheelView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return itemSize.height
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return itemSize.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return dequeueHeaderFooter(from: tableView, type: .header)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return dequeueHeaderFooter(from: tableView, type: .footer)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let point = CGPoint(x: scrollView.center.x + scrollView.contentOffset.x,
                            y: scrollView.center.y + scrollView.contentOffset.y)
        guard let indexPath = tableView.indexPathForRow(at: point) else { return }
        _selectedItem = items[indexPath.row]
        delegate?.wheelView(self, didSelectItem: _selectedItem)
        selectionFeedback?.selectionChanged()
        selectionFeedback?.prepare()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !decelerate else { return }
        scrollViewDidEndDecelerating(scrollView)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        selectionFeedback?.selectionChanged()
        selectionFeedback?.prepare()
    }
}

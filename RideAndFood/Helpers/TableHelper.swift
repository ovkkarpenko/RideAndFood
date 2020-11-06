//
//  TableHelper.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 24.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import Foundation

enum CellType {
    case none
    case `default`(UIColor? = nil)
    case `switch`(Bool, (Bool) -> Void)
    case icon(UIImage?)
    case subTitle(String)
    case radio(Bool)
}

struct TableItem {
    var title: String
    var segue: String?
    var cellTypes: [CellType] = []
    var completion: ((UIViewController) -> Void)?
}

class TableHelper {
    
    static let shared = TableHelper()
    
    private init() { }
    
    private let bag = DisposeBag()
    private let padding: CGFloat = 20
    
    func setupCell(_ cell: UITableViewCell, item: TableItem) {
        
        defaultCellConfig(cell, title: item.title)
        
        for cellType in item.cellTypes {
            switch cellType {
            case .default(let textColor):
                defaultCell(cell, textColor: textColor)
            case .none:
                noneCell(cell)
            case .switch(let checked, let completion):
                switchCell(cell, checked: checked, completion: completion)
            case .icon(let icon):
                iconCell(cell, icon: icon)
            case .subTitle(let subTitle):
                subTitleCell(cell, subTitle: subTitle)
            case .radio(let checked):
                radioCell(cell, checked: checked)
            }
        }
    }
    
    func setupHeaderView(view: UIView) {
        guard let view = view as? UITableViewHeaderFooterView else { return }
        
        if let textLabel = view.textLabel,
           let text = textLabel.text,
           !text.isEmpty {
            textLabel.font = .systemFont(ofSize: 12)
            textLabel.textColor = .gray
            view.backgroundView?.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        } else {
            view.frame = CGRect.zero
        }
    }
    
    private func defaultCell(_ cell: UITableViewCell, textColor: UIColor?) {
        cell.textLabel?.textColor = textColor == nil ? .black : textColor
        cell.accessoryType = .disclosureIndicator
    }
    
    private func noneCell(_ cell: UITableViewCell) {
        cell.accessoryType = .none
    }
    
    private func switchCell(_ cell: UITableViewCell, checked: Bool, completion: @escaping (Bool) -> Void) {
        cell.accessoryType = .none
        cell.subviews.first { $0 is UISwitch }?.removeFromSuperview()
        
        let switchView = UISwitch()
        switchView.rx
            .controlEvent(.valueChanged)
            .withLatestFrom(switchView.rx.value)
            .subscribe (onNext: { isOn in
                completion(isOn)
            }).disposed(by: bag)
        
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.setOn(checked, animated: true)
        cell.addSubview(switchView)
        
        NSLayoutConstraint.activate([
            switchView.topAnchor.constraint(equalTo: cell.topAnchor, constant: 8),
            switchView.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -padding)
        ])
    }
    
    private func iconCell(_ cell: UITableViewCell, icon: UIImage?) {
        cell.accessoryType = .none
        
        if let icon = icon {
            cell.textLabel?.text = "\(icon.size.width >= 25 ? "          " : "       ")\(cell.textLabel?.text ?? "")"
            
            let imageView = UIImageView(image: icon)
            imageView.tintColor = .systemIndigo
            imageView.frame.origin = CGPoint(x: 15, y: cell.frame.height/2-4)
            cell.addSubview(imageView)
        }
    }
    
    private func radioCell(_ cell: UITableViewCell, checked: Bool) {
        cell.accessoryType = .none
        cell.subviews.first { $0 is UIButton }?.removeFromSuperview()
        
        let button = UIButton(frame: CGRect(x: cell.frame.width-40, y: cell.frame.height/2-10, width: 20, height: 20))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .none
        if checked {
            button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            button.tintColor = .green
        } else {
            button.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            button.tintColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        }
        cell.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: cell.topAnchor, constant: 8),
            button.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -padding)
        ])
    }
    
    private func subTitleCell(_ cell: UITableViewCell, subTitle: String) {
        cell.accessoryType = .disclosureIndicator
        cell.subviews.first { $0 is UILabel }?.removeFromSuperview()
        
        let label = UILabel(frame: CGRect(x: cell.frame.width-92, y: cell.frame.height/2-8, width: 100, height: 20))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        label.text = subTitle
        cell.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: cell.topAnchor, constant: 13),
            label.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -padding-16)
        ])
    }
    
    private func defaultCellConfig(_ cell: UITableViewCell, title: String) {
        cell.textLabel?.text = title
        cell.frame = CGRect(x: 0, y: 0, width: 375, height: 40)
        cell.textLabel?.font = .systemFont(ofSize: 15)
    }
}

//
//  TableHelper.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 24.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxDataSources
import Foundation

enum CellType {
    case none
    case `default`(UIColor? = nil)
    case `switch`
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
    
    func setupCell(_ cell: UITableViewCell, item: TableItem) {
        
        defaultCellConfig(cell)
        
        for cellType in item.cellTypes {
            switch cellType {
            case .default(let textColor):
                defaultCell(cell, title: item.title, textColor: textColor)
            case .none:
                noneCell(cell, title: item.title)
            case .switch:
                switchCell(cell, title: item.title)
            case .icon(let icon):
                iconCell(cell, title: item.title, icon: icon)
            case .subTitle(let subTitle):
                subTitleCell(cell, title: item.title, subTitle: subTitle)
            case .radio(let checked):
                radioCell(cell, title: item.title, checked: checked)
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
            view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        } else {
            view.frame = CGRect.zero
        }
    }
    
    private func defaultCell(_ cell: UITableViewCell, title: String, textColor: UIColor?) {
        cell.textLabel?.text = title
        cell.textLabel?.textColor = textColor == nil ? .black : textColor
        cell.accessoryType = .disclosureIndicator
    }
    
    private func noneCell(_ cell: UITableViewCell, title: String) {
        cell.textLabel?.text = title
        cell.accessoryType = .none
    }
    
    private func switchCell(_ cell: UITableViewCell, title: String) {
        cell.textLabel?.text = title
        cell.accessoryType = .none
        
        let switchView = UISwitch()
        switchView.center = CGPoint(x: cell.frame.width-switchView.frame.width+8, y: cell.frame.height/2)
        cell.addSubview(switchView)
    }
    
    private func iconCell(_ cell: UITableViewCell, title: String, icon: UIImage?) {
        cell.textLabel?.text = "    \(title)"
        cell.accessoryType = .none
        
        if let icon = icon {
            let imageView = UIImageView(image: icon)
            imageView.tintColor = .systemIndigo
            imageView.center = CGPoint(x: 20, y: cell.frame.height/2+2)
            cell.addSubview(imageView)
        }
    }
    
    private func radioCell(_ cell: UITableViewCell, title: String, checked: Bool) {
        cell.textLabel?.text = title
        cell.accessoryType = .none
        
        cell.subviews.first { $0 is UIButton }?.removeFromSuperview()
        
        let button = UIButton(frame: CGRect(x: cell.frame.width-40, y: cell.frame.height/2-10, width: 20, height: 20))
        button.backgroundColor = .white
        if checked {
            button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            button.tintColor = .green
        } else {
            button.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            button.tintColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        }
        cell.addSubview(button)
    }
    
    private func subTitleCell(_ cell: UITableViewCell, title: String, subTitle: String) {
        cell.textLabel?.text = title
        cell.accessoryType = .disclosureIndicator
        
        let label = UILabel(frame: CGRect(x: cell.frame.width-92, y: cell.frame.height/2-8, width: 100, height: 20))
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        label.text = subTitle
        cell.addSubview(label)
    }
    
    private func defaultCellConfig(_ cell: UITableViewCell) {
        cell.frame = CGRect(x: 0, y: 0, width: 375, height: 40)
        cell.textLabel?.font = .systemFont(ofSize: 15)
    }
}

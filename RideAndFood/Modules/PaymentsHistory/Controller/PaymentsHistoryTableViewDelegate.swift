//
//  PaymentsHistoryTableViewDelegate.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 23.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class PaymentsHistoryTableViewDelegate: NSObject, UITableViewDelegate {
    
    // MARK: - Private properties
    
    private weak var viewController: PaymentsHistoryViewController?
    private let paymentTappedBlock: (IndexPath) -> Void
    private let rowHeight: CGFloat = 147
    
    // MARK: - Initializer
    
    init(viewController: PaymentsHistoryViewController?,
         paymentTappedBlock: @escaping (IndexPath) -> Void) {
        self.viewController = viewController
        self.paymentTappedBlock = paymentTappedBlock
        super.init()
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        paymentTappedBlock(indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let searchBar = UISearchBar()
        searchBar.placeholder = PaymentsHistoryStrings.search.text()
        return searchBar
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

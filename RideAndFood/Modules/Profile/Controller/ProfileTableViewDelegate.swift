//
//  ProfileTableViewDelegate.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 13.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class ProfileTableViewDelegate: NSObject, UITableViewDelegate {
    
    // MARK: - Private properties
    
    private weak var viewController: ProfileViewController?
    private let phoneNumberTappedBlock: (Int) -> Void
    private let addressesTappedBlock: () -> Void
    private let paymentHistoryTappedBlock: () -> Void
    private let ordersHistoryTappedBlock: () -> Void
    private let paymentsTappedBlock: () -> Void
    
    // MARK: - Initializer
    
    init(viewController: ProfileViewController?,
         phoneNumberTappedBlock: @escaping (Int) -> Void,
         addressesTappedBlock: @escaping () -> Void,
         paymentHistoryTappedBlock: @escaping () -> Void,
         ordersHistoryTappedBlock: @escaping () -> Void,
         paymentsTappedBlock: @escaping () -> Void) {
        self.viewController = viewController
        self.phoneNumberTappedBlock = phoneNumberTappedBlock
        self.addressesTappedBlock = addressesTappedBlock
        self.paymentHistoryTappedBlock = paymentHistoryTappedBlock
        self.ordersHistoryTappedBlock = ordersHistoryTappedBlock
        self.paymentsTappedBlock = paymentsTappedBlock
        super.init()
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            phoneNumberTappedBlock(indexPath.row)
        case 1:
            addressesTappedBlock()
        case 2:
            switch indexPath.item {
            case 0:
                paymentHistoryTappedBlock()
            case 1:
                ordersHistoryTappedBlock()
            case 2:
                paymentsTappedBlock()
            default:
                break
            }
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 2) {
            return 25
        } else {
            return 0
        }
    }
}

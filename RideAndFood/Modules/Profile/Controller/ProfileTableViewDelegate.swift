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
    
    // MARK: - Initializer
    
    init(viewController: ProfileViewController?,
         phoneNumberTappedBlock: @escaping (Int) -> Void) {
        self.viewController = viewController
        self.phoneNumberTappedBlock = phoneNumberTappedBlock
        super.init()
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            phoneNumberTappedBlock(indexPath.row)
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

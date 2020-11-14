//
//  AccountTableViewDataSource.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 13.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class AccountTableViewDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Public properties
    
    var phoneNumbers: [PhoneNumberModel]
    
    // MARK: - Private properties
    
    private var phoneCellModels: [AccountCellModel] { phoneNumbers.map { AccountCellModel(title: $0.formattedPhone,
                                                                                          leftView: UIImageView(image: UIImage(named: "PersonIcon")),
                                                                                          description: $0.isDefault ? AccountStrings.isDefault.text() : nil) }
    }
    private lazy var myAddressesCellModel: [AccountCellModel] = [.init(title: AccountStrings.myAdresses.text(),
                                                                       leftView: nil,
                                                                       description: nil)]
    private lazy var lastSectionCellModel: [AccountCellModel] = [.init(title: AccountStrings.paymentsHistory.text(),
                                                                       leftView: nil,
                                                                       description: nil),
                                                                 .init(title: AccountStrings.ordersHistory.text(),
                                                                       leftView: nil,
                                                                       description: nil),
                                                                 .init(title: AccountStrings.paymentMethod.text(),
                                                                       leftView: nil,
                                                                       description: nil)]
    private var sections: [[AccountCellModel]] {
        [phoneCellModels, myAddressesCellModel, lastSectionCellModel]
    }
    private let cellId: String
    
    // MARK: - Initializer
    
    init(phoneNumbers: [PhoneNumberModel], cellId: String) {
        self.phoneNumbers = phoneNumbers
        self.cellId = cellId
        super.init()
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? AccountTableViewCell
        else { return UITableViewCell() }
        
        cell.configure(with: sections[indexPath.section][indexPath.row])
        
        return cell
    }
}

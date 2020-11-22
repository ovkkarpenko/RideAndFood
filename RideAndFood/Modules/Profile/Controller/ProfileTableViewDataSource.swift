//
//  ProfileTableViewDataSource.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 13.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class ProfileTableViewDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Public properties
    
    var phoneNumbers: () -> [ProfilePhoneModel]
    
    // MARK: - Private properties
    
    private var phoneCellModels: [ProfileCellModel] { phoneNumbers().map { ProfileCellModel(title: $0.formattedPhone,
                                                                                          leftView: UIImageView(image: UIImage(named: "PersonIcon")),
                                                                                          description: $0.isMain ? ProfileStrings.isDefault.text() : nil,
                                                                                          hasDisclosureIndicator: false) }
    }
    private lazy var myAddressesCellModel: [ProfileCellModel] = [.init(title: ProfileStrings.myAdresses.text(),
                                                                       leftView: nil,
                                                                       description: nil,
                                                                       hasDisclosureIndicator: true)]
    private lazy var lastSectionCellModel: [ProfileCellModel] = [.init(title: ProfileStrings.paymentsHistory.text(),
                                                                       leftView: nil,
                                                                       description: nil,
                                                                       hasDisclosureIndicator: true),
                                                                 .init(title: ProfileStrings.ordersHistory.text(),
                                                                       leftView: nil,
                                                                       description: nil,
                                                                       hasDisclosureIndicator: true),
                                                                 .init(title: ProfileStrings.paymentMethod.text(),
                                                                       leftView: nil,
                                                                       description: nil,
                                                                       hasDisclosureIndicator: true)]
    private var sections: [[ProfileCellModel]] {
        [phoneCellModels, myAddressesCellModel, lastSectionCellModel]
    }
    private let cellId: String
    
    // MARK: - Initializer
    
    init(cellId: String, phoneNumbers: @escaping () -> [ProfilePhoneModel]) {
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? ProfileTableViewCell
        else { return UITableViewCell() }
        
        cell.configure(with: sections[indexPath.section][indexPath.row])
        
        return cell
    }
}

//
//  PaymentsHistoryTableViewDataSource.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 23.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class PaymentsHistoryTableViewDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Public properties
    
    // MARK: - Private properties
    
    private var payments: [Payment] = []
    
    private let cellId: String
    
    // MARK: - Initializer
    
    init(cellId: String) {
        self.cellId = cellId
        super.init()
    }
    
    // MARK: - Public methods
    
    func setModels(_ models: [Payment]) {
        self.payments = models
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        payments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? PaymentTableViewCell
        else { return UITableViewCell() }
        
        let payment = payments[indexPath.row]
        if let model = PaymentCellModel(payment: payment) {
            cell.configure(with: model)
        }
        
        return cell
    }
}

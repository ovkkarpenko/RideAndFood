//
//  SelectTariffViewModel.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 04.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import RxSwift
import RxDataSources

class SelectTariffViewModel {
    
    var tariffsPublishSubject = PublishSubject<[SectionModel<String, TariffModel>]>()
    
    func getPointsCount(_ completion: ((Int) -> ())?) {
        ServerApi.shared.getCredits(completion: { item, _ in
            completion?(item?.credit ?? 0)
        })
    }
    
    func fetchData() {
        let request = RequestModel<TariffModel>(path: tariffPath, method: .get)
        let networker = Networker()
        
        networker.makeRequest(request: request) { [weak self] (results: [TariffModel]?, error: RequestErrorModel?) in
            guard let self = self else { return }
            
            if let results = results {
                self.tariffsPublishSubject.onNext([SectionModel(model: "", items: results)])
            }
            
            if let error = error {
                print(error.message)
            }
        }
    }
    
    func dataSource(cellIdentifier: String) -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, TariffModel>> {
        
        return RxCollectionViewSectionedReloadDataSource<SectionModel<String, TariffModel>>(
            configureCell: { (_, tv, indexPath, item) in
                
                let cell = tv.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! TaxiTariffCollectionViewCell
                cell.configurate(tariff: item)
                return cell
            }
        )
    }
}

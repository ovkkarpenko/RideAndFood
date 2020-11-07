//
//  TariffPageViewController.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 07.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class TariffPageViewController: UIPageViewController {
    private var pages: [UIViewController] = []
    private var tariffModel: [TariffModel] = []
    
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        setTariffs()
    }
    
    private func setTariffs() {
        let request = RequestModel<TariffModel>(path: tariffPath, method: .get)
        let networker = Networker()
        
        networker.makeRequest(request: request) { [weak self] (results: [TariffModel]?, error: RequestErrorModel?) in
            guard let self = self else { return }
            
            if let results = results {
                self.tariffModel = results
                self.setPages()

                if let firstViewController = self.pages.first {
                    self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
                }
            }
            
            if let error = error {
                print(error.message)
            }
        }
    }
    
    private func setPages() {
        for tariff in tariffModel {
            pages.append(createTariffPage(tariff: tariff))
        }
    }
    
    private func createTariffPage(tariff: TariffModel) -> UIViewController{
        let controller = UIViewController()
        controller.view = TariffPage(tariffModel: tariff)

        return controller
    }
}

extension TariffPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        return currentIndex == 0 ? pages.last : pages[currentIndex - 1]
    }
    
    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        return currentIndex == pages.count - 1 ? pages.first : pages[currentIndex + 1]
    }
}

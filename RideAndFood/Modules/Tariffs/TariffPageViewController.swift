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
    
    override var transitionStyle: UIPageViewController.TransitionStyle {
        return .scroll
    }
    
    override var spineLocation: UIPageViewController.SpineLocation {
        return .none
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self

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
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return pages.last
        }
        
        guard pages.count > previousIndex else {
            return nil
        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard pages.count != nextIndex else {
            return pages.first
        }
        
        guard pages.count > nextIndex else {
            return nil
        }
        
        return pages[nextIndex]
    }
}

//
//  TaxiStrings.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 16.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum TaxiStrings {
    case driver
    case pickupTime
    case onTheWay
    case call
    case almostThere
    case waiting
    case waitingForYou
    case waitingDesctiption
    case paidWaiting
    case paidWaitingDescription
    case onMyWay
    
    func text() -> String {
        switch UserConfig.shared.settings.language {
        case .rus:
            return rus()
        case .eng:
            return eng()
        }
    }
    
    private func rus() -> String {
        switch self {
        case .driver:
            return "Водитель"
        case .pickupTime:
            return "Время подачи"
        case .onTheWay:
            return "Уже в пути"
        case .call:
            return "Позвонить"
        case .almostThere:
            return "Почти на месте"
        case .waitingForYou:
            return "Вас ожидает"
        case .waiting:
            return "Ожидание"
        case .waitingDesctiption:
            return "Время бесплатного ожидания согласно тарифу"
        case .paidWaiting:
            return "Платное ожидание"
        case .paidWaitingDescription:
            return "Время ожидания: 2 мин. Плата взымается согласно тарифу"
        case .onMyWay:
            return "Скоро буду"
        }
    }
    
    private func eng() -> String {
        switch self {
        case .driver:
            return "Driver"
        case .pickupTime:
            return "Pick-up time"
        case .onTheWay:
            return "On the way"
        case .call:
            return "Call"
        case .almostThere:
            return "Almost there"
        case .waitingForYou:
            return "Waiting for you"
        case .waiting:
            return "Waiting"
        case .waitingDesctiption:
            return "Free waiting time according to the tariff"
        case .paidWaiting:
            return "Paid waiting"
        case .paidWaitingDescription:
            return "Waiting time: 2 min. The fee is charged according to the tariff"
        case .onMyWay:
            return "On my way"
        }
    }
}

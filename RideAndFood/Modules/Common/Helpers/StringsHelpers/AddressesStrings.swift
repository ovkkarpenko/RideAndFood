//
//  AddressesStrings.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 09.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum AddressesStrings {
    case title
    case alertLabel
    case addAddressButton
    
    func text() -> String {
        switch UserConfig.shared.settings.language {
        case .rus:
            return rus()
        case .eng:
            return eng()
        }
    }
    
    func rus() -> String {
        switch self {
        case .title:
            return "Мои адреса"
        case .alertLabel:
            return "Здесь пока пусто..."
        case .addAddressButton:
            return "Добавить адрес"
        }
    }
    
    func eng() -> String {
        switch self {
        case .title:
            return "My addresses"
        case .alertLabel:
            return "It's empty here for now ..."
        case .addAddressButton:
            return "Add address"
        }
    }
}

enum AddAddressesStrings {
    case title
    case deliveryTitle
    case addres
    case addresName
    case commentForDriver
    case commentForCourier
    case apartment
    case doorphone
    case entrance
    case floor
    case mapButton
    case saveButton
    case selectAddress
    case chooseDestination
    case removeTitle
    case removeButton
    case cencelButton
    
    func text() -> String {
        switch UserConfig.shared.settings.language {
        case .rus:
            return rus()
        case .eng:
            return eng()
        }
    }
    
    func rus() -> String {
        switch self {
        case .selectAddress:
            return "Выбрать адрес"
        case .title:
            return "Новый адрес"
        case .addres:
            return "Адрес"
        case .addresName:
            return "Название адреса"
        case .mapButton:
            return "Карта"
        case .commentForDriver:
            return "Комментарий для водителя"
        case .deliveryTitle:
            return "Для доставки"
        case .apartment:
            return "Кв./офис"
        case .doorphone:
            return "Домофон"
        case .entrance:
            return "Подъезд"
        case .floor:
            return "Этаж"
        case .commentForCourier:
            return "Комментарий для курьера"
        case .saveButton:
            return "Сохранить"
        case .chooseDestination:
            return "Выбрать местом назначения"
        case .removeTitle:
            return "Удалить адрес?"
        case .removeButton:
            return "Удалить"
        case .cencelButton:
            return "Отменить"
        }
    }
    
    func eng() -> String {
        switch self {
        case .selectAddress:
            return "Select address"
        case .title:
            return "New addres"
        case .addres:
            return "Addres"
        case .addresName:
            return "Addres name"
        case .mapButton:
            return "Map"
        case .commentForDriver:
            return "Commentary for driver"
        case .deliveryTitle:
            return "For delivery"
        case .apartment:
            return "Apartment. / Office"
        case .doorphone:
            return "Doorphone"
        case .entrance:
            return "Entrance"
        case .floor:
            return "Floor"
        case .commentForCourier:
            return "Commentary for courier"
        case .saveButton:
            return "Save"
        case .chooseDestination:
            return "Choose destination"
        case .removeTitle:
            return "Remove address?"
        case .removeButton:
            return "Remove"
        case .cencelButton:
            return "Cencel"
        }
    }
}

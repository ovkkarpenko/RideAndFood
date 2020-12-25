//
//  FoodStrings.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 19.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

enum FoodStrings {
    case addressTextField
    case backButton
    case makeOrder
    case cart
    case deliverWithin
    case goToPayment
    case haveGoodsInCart
    case emptyCart
    case empty
    case cartIsEmpty
    case backToShopping
    case emptyCartDescription
    case emptyCartConfirmation
    case spendAllPoints
    case spendSomePoints
    case youHave
    case confirm
    case enterPointsCount
    case errorLabelMessage
    case points
    case needChange
    case changeCount
    case leftChangeValue
    case rightChangeValue
    case from
    case deliveryAddress
    case card
    case order
    case pay
    
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
        case .addressTextField:
            return "Введите адрес доставки"
        case .backButton:
            return "Назад"
        case .makeOrder:
            return "Оформить заказ"
        case .cart:
            return "Корзина"
        case .deliverWithin:
            return "Доставим через"
        case .goToPayment:
            return "Перейти к оплате"
        case .haveGoodsInCart:
            return "У вас остались товары в корзине"
        case .emptyCart:
            return "Очистить корзину?"
        case .empty:
            return "Очистить"
        case .cartIsEmpty:
            return "Корзина пуста"
        case .backToShopping:
            return "Вернуться к покупкам"
        case .emptyCartDescription:
            return "Для новых покупок вам необходимо очистить корзину предыдущего заказа"
        case .emptyCartConfirmation:
            return "Очистить корзину"
        case .spendAllPoints:
            return "Потратить все баллы сразу"
        case .spendSomePoints:
            return "Другое количество"
        case .youHave:
            return "У вас "
        case .confirm:
            return "Подтвердить"
        case .enterPointsCount:
            return "Введите количество баллов"
        case .errorLabelMessage:
            return "Недопустимое количество"
        case .points:
            return "Баллов"
        case .needChange:
            return "Потребуется сдача"
        case .changeCount:
            return "С какой суммы потребуется сдача?"
        case .leftChangeValue:
            return "\(ReservedChangeCount.change1000.rawValue) руб"
        case .rightChangeValue:
            return "\(ReservedChangeCount.change5000.rawValue) руб"
        case .from:
            return "с"
        case .deliveryAddress:
            return "Адрес доставки"
        case .card:
            return "Карта"
        case .order:
            return "Заказать"
        case .pay:
            return "Оплатить"
        }
    }
    
    func eng() -> String {
        switch self {
        case .addressTextField:
            return "Enter delivery address"
        case .backButton:
            return "Back"
        case .makeOrder:
            return "Order"
        case .cart:
            return "Cart"
        case .deliverWithin:
            return "Deliver within"
        case .goToPayment:
            return "Go to payment"
        case .haveGoodsInCart:
            return "You still have goods in your cart"
        case .emptyCart:
            return "Empty cart?"
        case .empty:
            return "Empty"
        case .cartIsEmpty:
            return "Cart is empty"
        case .backToShopping:
            return "Back to shopping"
        case .emptyCartDescription:
            return "For new purchases, you need to empty the cart of the previous order"
        case .emptyCartConfirmation:
            return "Empty cart"
        case .spendAllPoints:
            return "Spend all points"
        case .spendSomePoints:
            return "Spend some points"
        case .youHave:
            return "You have "
        case .confirm:
            return "Confirm"
        case .enterPointsCount:
            return "Enter points count"
        case .errorLabelMessage:
            return "Invalid number"
        case .points:
            return "Points"
        case .needChange:
            return "Need change"
        case .changeCount:
            return "How much will you need to change?"
        case .leftChangeValue:
            return "\(ReservedChangeCount.change1000.rawValue) rub"
        case .rightChangeValue:
            return "\(ReservedChangeCount.change5000.rawValue) rub"
        case .from:
            return "from"
        case .deliveryAddress:
            return "Delivery address"
        case .card:
            return "Card"
        case .order:
            return "Order"
        case .pay:
            return "Pay"
        }
    }
}

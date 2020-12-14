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
        }
    }
}

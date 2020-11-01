//
//  ResponseModel.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 01.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct ResponseModel<T: Codable>: Codable {
    var data: T?
}

// MARK: - TODO: Нужно доработать и добавить логирование ответа сервера сюда. 

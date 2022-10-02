//
//  BitcoinRate.swift
//  ExpensesTracker
//
//  Created by Artem Stozhok on 02.10.2022.
//

import Foundation

struct BitcoinRate: Codable {
    let time: Time
    let disclaimer, chartName: String
    let bpi: Bpi
}

struct Bpi: Codable {
    let usd, gbp, eur: Eur

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case gbp = "GBP"
        case eur = "EUR"
    }
}

struct Eur: Codable {
    let code, symbol, rate, eurDescription: String
    let rateFloat: Double

    enum CodingKeys: String, CodingKey {
        case code, symbol, rate
        case eurDescription = "description"
        case rateFloat = "rate_float"
    }
}

struct Time: Codable {
    let updated: String
    let updatedISO: String
    let updateduk: String
}

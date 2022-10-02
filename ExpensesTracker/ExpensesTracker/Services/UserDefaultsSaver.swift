//
//  UserDefaultsSaver.swift
//  ExpensesTracker
//
//  Created by Artem Stozhok on 02.10.2022.
//

import Foundation

class UserDefaultsSaver {

    static private let dateOfBitcoinRateRequest = "dateOfBitcoinRateRequest"
    static private let bitcoinRate = "bitcoinRate"

    static func saveDateOfBitcoinRateRequest(date: Date) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(date, forKey: dateOfBitcoinRateRequest)
    }

    static func loadDateForAfterVideoSubscribeAlert() -> Date? {
        let userDefaults = UserDefaults.standard
        let date = userDefaults.date(forKey: dateOfBitcoinRateRequest)

        return date
    }
    
    static func saveBitcoinRate(_ rate: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(rate, forKey: bitcoinRate)
    }

    static func loadBitcoinRate() -> String? {
        let userDefaults = UserDefaults.standard
        let rate = userDefaults.string(forKey: bitcoinRate)

        return rate
    }
}

extension UserDefaults {

    func date(forKey key: String) -> Date? {
        return self.value(forKey: key) as? Date
    }

    func set(date: Date?, forKey key: String) {
        self.set(date, forKey: key)
    }
}

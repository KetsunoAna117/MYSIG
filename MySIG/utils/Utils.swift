//
//  Utils.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 03/04/24.
//

import Foundation

struct Utils {
    func validateUser(email: String, password: String, appStoreData: AppDataStore) -> User?{
        return appStoreData.users.first(where: { $0.email.lowercased() == email.lowercased() && $0.password == password })
    }
}

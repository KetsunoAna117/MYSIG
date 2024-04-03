//
//  Utils.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 03/04/24.
//

import Foundation

struct Utils {
    func validateUser(email: String, password: String, appStoreData: AppDataStore) -> User?{
        for user in appStoreData.users {
            if user.email == email{
                return user
            }
        }
        return nil
    }
}

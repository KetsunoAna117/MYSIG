//
//  Utils.swift
//  MySIG
//
//  Created by Hans Arthur Cupiterson on 03/04/24.
//

import Foundation

struct Utils {
    // USER
    func validateUser(email: String, password: String, appStoreData: AppDataStore) -> User?{
        return appStoreData.users.first(where: { $0.email.lowercased() == email.lowercased() && $0.password == password })
    }
    
    // DATE
    func formatDate(from date: String) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.date(from: date)
    }
    
    func getDayName(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    func getDay(from date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        return components.day ?? 0
    }
    
    func getMonth(from date: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        dateFormatter.calendar = calendar
        
        if let monthDate = calendar.date(from: components) {
            return dateFormatter.string(from: monthDate)
        } else {
            return ""
        }
    }
    
    // SIG
    func getSigById(sigId: Int, appStoreData: AppDataStore) -> SIG?{
        return appStoreData.sigs.first(where: {$0.id == sigId})
    }
    
    // EVENT
    func checkIfUserBookEvent(event: EventSIG, user: User) -> Bool{
        for registeredMember in event.listRegisteredParticipantId {
            if(registeredMember == user.id){
                return true
            }
        }
        return false
    }
    
    func getEventById(eventId: Int, appStoreData: AppDataStore) -> EventSIG?{
        return appStoreData.events.first(where: { $0.id == eventId })
    }
    
    func getEventListWithoutTheUser(user: User, appStoreData: AppDataStore) -> [EventSIG]{
        return appStoreData.events.filter { event in
            checkIfUserBookEvent(event: event, user: user) == false
        }
    }
    
    func calculateRemainingSlot(event: EventSIG) -> Int{
        let maxSlots = event.maxSlots
        
        return maxSlots - event.listRegisteredParticipantId.count
    }
}

//
//  MainScreenModel.swift
//  BlackSwanTest
//
//  Created by Максим Ламанский on 09.06.2021.
//

import Foundation

enum Main {
    
    struct Order: Identifiable {
        enum State: String, CaseIterable {
            case pending, inProgress, fulfilled, rejected
            
            var title: String {
                self.rawValue
            }
            
            static func get(by id: UInt) -> State {
                let (_, index) = (State.allCases.count-1).quotientAndRemainder(dividingBy: Int(id))
                return State.allCases[index]
            }
        }
        
        let id: UUID
        let lastModified: Date
        let seat: (UInt, Character)
        let state: State
        let price: (Decimal, String)
        let items: [String]

        init(
            id: UUID = UUID(),
            lastModified: Date = Date(),
            seat: (UInt, Character),
            state: State = .pending,
            price: (Decimal, String),
            items: [String] = []) {
            
            self.id = id
            self.lastModified = lastModified
            self.seat = seat
            self.state = state
            self.price = price
            self.items = items

        }
        
        var info: String {
            "\(state.title) \(lastModified.toString()) (\(seat))"
        }
        
    }
}

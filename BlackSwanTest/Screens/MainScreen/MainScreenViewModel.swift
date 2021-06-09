//
//  MainScreenViewModel.swift
//  BlackSwanTest
//
//  Created by Максим Ламанский on 09.06.2021.
//

import SwiftUI

protocol MainScreenViewModelDelegate: AnyObject {
    func addOrders(for id: UInt)
    func del(order: Main.Order)
}

final class MainScreenViewModel {
    
    //MARK: Test cases area
    private let testOrders = TestAccessOrder.shared
    
    private let letters: String = "abcdefghijklmnopqrstuvwxyz"
    
    init() {
    }

    private func add3Ordes(for id: UInt) {
        let state = Main.Order.State.getRandom()
        testOrders.add(order: Main.Order(
                        lastModified: Date(timeInterval: Double(id), since: Date()),
                        seat: (id, letters[id * 2]),
                        state: state,
                        price: (Decimal(id), "$")))
        testOrders.add(order: Main.Order(
                        lastModified: Date(timeInterval: Double(id), since: Date()),
                        seat: (id, letters[id * 2 + 1]),
                        state: state,
                        price: (Decimal(id), "$")))
        testOrders.add(order: Main.Order(
                        lastModified: Date(timeInterval: Double(id + 1), since: Date()),
                        seat: (id, letters[id * 2 + 1]),
                        state: state,
                        price: (Decimal(id), "$")))    }
}

extension MainScreenViewModel: MainScreenViewModelDelegate {
    
    func addOrders(for id: UInt) {
        add3Ordes(for: id)
    }
    
    func del(order: Main.Order) {
        testOrders.del(order: order)
    }
    
}

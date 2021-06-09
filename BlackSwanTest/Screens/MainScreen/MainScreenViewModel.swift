//
//  MainScreenViewModel.swift
//  BlackSwanTest
//
//  Created by Максим Ламанский on 09.06.2021.
//

import SwiftUI

protocol MainScreenViewModelDelegate: AnyObject {
    func addOrder(for id: UInt)
    func del(order: Main.Order)
}

final class MainScreenViewModel {
    
    //MARK: Test cases area
    private let testOrders = TestAccessOrder.shared
    
    private let letters: String = "abcdefghijklmnopqrstuvwxyz"
    
    init() {
    }

    private func add3Ordes(for id: UInt) {
        testOrders.add(order: Main.Order(
                        lastModified: Date(timeInterval: Double(id), since: Date()),
                        seat: (id, letters[id * 2]),
                        state: Main.Order.State.get(by: id),
                        price: (Decimal(id), "$")))
        testOrders.add(order: Main.Order(
                        lastModified: Date(timeInterval: Double(id), since: Date()),
                        seat: (id, letters[id * 2 + 1]),
                        state: Main.Order.State.get(by: id),
                        price: (Decimal(id), "$")))
        testOrders.add(order: Main.Order(
                        lastModified: Date(timeInterval: Double(id + 1), since: Date()),
                        seat: (id, letters[id * 2 + 1]),
                        state: Main.Order.State.get(by: id),
                        price: (Decimal(id), "$")))    }
}

extension MainScreenViewModel: MainScreenViewModelDelegate {
    
    func addOrder(for id: UInt) {
        add3Ordes(for: id)
    }
    
    func del(order: Main.Order) {
        testOrders.del(order: order)
    }
    
}

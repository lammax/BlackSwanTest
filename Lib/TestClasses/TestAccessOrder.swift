//
//  TestAccessOrder.swift
//  BlackSwanTest
//
//  Created by Максим Ламанский on 09.06.2021.
//

import Combine

final class TestAccessOrder: ObservableObject {
    
    static let shared = TestAccessOrder()
    
    @Published var orders: [Main.Order] = []
    
    private let added: PassthroughSubject<Main.Order, Never> = PassthroughSubject<Main.Order, Never>()
    private let removed: PassthroughSubject<Main.Order, Never> = PassthroughSubject<Main.Order, Never>()
    
    private let randomAccessOrder: RandomAccessOrder!
    
    private var cancellables: [AnyCancellable] = []
    
    private init() {
        randomAccessOrder = RandomAccessOrder(added: added.eraseToAnyPublisher(), removed: removed.eraseToAnyPublisher())
        setupSubscriptions()
    }
    
    deinit {
        clear()
    }
    
    private func clearSubscriptions() {
        cancellables.forEach({ $0.cancel() })
        cancellables = []
    }
    
    private func setupSubscriptions() {
        let randAccOrd = randomAccessOrder.output
            .sink { orders in
                self.orders = orders
            }

        cancellables = [randAccOrd]
    }
    
    func add(order: Main.Order ) {
        added.send(order)
    }
    
    func del(order: Main.Order) {
        removed.send(order)
    }
    
    func clear() {
        randomAccessOrder.clear()
        clearSubscriptions()
    }
}

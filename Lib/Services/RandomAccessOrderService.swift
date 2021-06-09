//
//  RandomAccessOrderService.swift
//  BlackSwanTest
//
//  Created by Максим Ламанский on 09.06.2021.
//

import Combine

final class RandomAccessOrder: Service {
    typealias T = Array<Main.Order>

    private var collection: CurrentValueSubject<T, Never> = CurrentValueSubject([])
    
    lazy var output: AnyPublisher<T, Never> = {
        collection
            .map { orders in
                orders.sorted { ordL, ordR in
                    /// Sorting logic to use for the `Order` state:
                    /// - `pending`, `inProgress` - by date(ASC)
                    /// - `fulfilled`, `rejected` - by seat(number then abc) then by date(DESC)
                    switch ordL.state {
                    case .pending, .inProgress:
                        return ordL.lastModified < ordR.lastModified
                    case .fulfilled, .rejected:
                        if ordL.seat.0 != ordR.seat.0 {
                            return ordL.seat.0 > ordR.seat.0
                        } else if ordL.seat.1 != ordR.seat.1 {
                            return ordL.seat.1 > ordR.seat.1
                        } else {
                            return ordL.lastModified > ordR.lastModified
                        }
                    }
                    
                }
            }
            .eraseToAnyPublisher()
            
    }()
    
    private let added: AnyPublisher<Main.Order, Never>
    private let removed: AnyPublisher<Main.Order, Never>
    
    private var cancellables: [AnyCancellable] = []

    init(added: AnyPublisher<Main.Order, Never>, removed: AnyPublisher<Main.Order, Never>) {
        self.added = added
        self.removed = removed
        
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
        let addedCancel = added
            .sink { ord in
                self.collection.value.append(ord)
            }

        let removedCancel = removed
            .sink { ord in
                if let index = self.collection.value.firstIndex(where: { $0.id == ord.id }) {
                    self.collection.value.remove(at: index)
                }
            }
        
        cancellables = [addedCancel, removedCancel]
    }
    
    func clear() {
        clearSubscriptions()
        collection.value = []
    }
}

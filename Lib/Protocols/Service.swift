//
//  Service.swift
//  BlackSwanTest
//
//  Created by Максим Ламанский on 09.06.2021.
//

import Combine

/// Input parameters are a publisher that emits orders that should be added to the fray
/// one-by-one, and similarly a publisher that emits orders that should be removed one-by-one.
/// We would like to see a collection of `Order`s on the ouput triggered by the inputs. The emitted
/// collection should be sorted by the aforementioned logic. To ensure the sortedness if possible use
/// the best fitting insertion and removal on your `Service.T` type.
protocol Service where Self.T.Element == Main.Order {
    associatedtype T: RandomAccessCollection
    init(added: AnyPublisher<Main.Order, Never>, removed: AnyPublisher<Main.Order, Never>)
    var output: AnyPublisher<T, Never> { get }
}

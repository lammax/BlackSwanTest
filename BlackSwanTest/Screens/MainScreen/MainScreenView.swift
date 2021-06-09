//
//  ContentView.swift
//  BlackSwanTest
//
//  Created by Максим Ламанский on 09.06.2021.
//

import SwiftUI

struct MainScreenView: View {
    @EnvironmentObject var testClass: TestAccessOrder
    
    @State private var counter: UInt = .zero
    private let viewModel: MainScreenViewModelDelegate = MainScreenViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing: .zero, content: {
            HStack {
                Text("Orders")
                    .font(.title)
                    .foregroundColor(.black)

                Spacer()
                
                Button(action: {
                    counter += 3
                    viewModel.addOrders(for: counter)
                }, label: {
                    Text("Add 3 orders")
                        .font(.title3)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(3.0)
                })
            }
            .padding()
            
            
            ScrollView(.vertical, showsIndicators: false, content: {
                ForEach(testClass.orders) { order in
                    Button(action: {
                        if counter > .zero {
                            counter -= 1
                            viewModel.del(order: order)
                        }
                    }, label: {
                        Text(order.info)
                            .font(.body)
                            .foregroundColor(.black)
                    })
                    
                }
            })
        })
        .padding()
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}

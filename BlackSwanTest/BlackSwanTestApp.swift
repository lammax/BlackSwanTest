//
//  BlackSwanTestApp.swift
//  BlackSwanTest
//
//  Created by Максим Ламанский on 09.06.2021.
//

import SwiftUI

@main
struct BlackSwanTestApp: App {
    var body: some Scene {
        WindowGroup {
            MainScreenView().environmentObject(TestAccessOrder.shared)
        }
    }
}

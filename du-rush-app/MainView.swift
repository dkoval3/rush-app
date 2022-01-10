//
//  MainView.swift
//  du-rush-app
//
//  Created by Dane Koval on 12/26/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            LoginView()
            ContentView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

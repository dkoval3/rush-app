//
//  CycleListView.swift
//  du-rush-app
//
//  Created by Dane Koval on 12/26/21.
//

import SwiftUI

struct CycleListView: View {
    var body: some View {
        NavigationView {
            VStack {
                Button(action: { print("Pressed") }) {
                    Text("Add Rushee")
                        .foregroundColor(.white)
                        .frame(width: 150, height: 35)
                        .background(Color.blue)
                        .cornerRadius(15)
                }
                
                List {
                    Text("Test")
                    Text("Test")
                    Text("Test")
                }
            }.navigationTitle("Cycle")
        }
    }
}

struct CycleListView_Previews: PreviewProvider {
    static var previews: some View {
        CycleListView()
    }
}

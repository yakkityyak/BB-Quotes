//
//  ContentView.swift
//  BB Quotes
//
//  Created by Jakob Hjortshøj on 30/08/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            QuoteView()
                .tabItem {
                    Label("Breaking Bad", systemImage: "tortoise")
                }
            
            Text("Better Call Saul View")
                .tabItem {
                    Label("Better Call Saul", systemImage: "briefcase")
                }
        }
        .onAppear{
            UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

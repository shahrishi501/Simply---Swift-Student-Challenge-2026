//
//  MainTabView.swift
//  Simply
//
//  Created by Rishi Shah on 08/02/26.
//


import SwiftUI

struct MainTabView: View {

    @State private var selectedTab = 0
    @State private var showAI = false
    @EnvironmentObject var state: AppState

    var body: some View {

        ZStack {
            
            // Main Tabs
                TabView(selection: $selectedTab) {
                    
                    // Home
                    NavigationStack(path: $state.homePath) {
                        HomeView()
                            .navigationDestination(for: HomeRoute.self) { route in
                                switch route {

                                case .termList(let domain):
                                    TermListView(domain: domain)

                                case .termDetail(let term):
                                    TermDetailView(term: term)

                                case .quiz(let term):
                                    QuizView(term: term)
                                }
                            }
                    }
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .tag(0)
                    
                    // Profile
                    NavigationStack {
                        ProfileView()
                    }
                    .tabItem {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
                    .tag(1)
                    
                    NavigationStack{
                        if #available(iOS 26.0, *) {
                            AssistantView()
                        } else {
                            // Fallback on earlier versions
                            AIFallbackView()
                        }
                    }
                    .tabItem{
                        Label("SimplyAI", systemImage: "sparkles")
                    }
                }
        }
    }
}

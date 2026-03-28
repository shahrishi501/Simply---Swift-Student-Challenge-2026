import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var state: AppState
    
    var body: some View {
        NavigationStack {

           if state.hasOnboarded {
               MainTabView()
           } else {
               OnboardingView()
           }
       }
    }
}

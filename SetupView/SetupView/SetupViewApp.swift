import SwiftUI

@main
struct SetupViewApp: App {
  var body: some Scene {
    WindowGroup {
      HomeView()
    }
  }
}

struct HomeView: View {
  var body: some View {
    Text("Hello, world!")
  }
}

struct QuestionView: View {
  var body: some View {
    Text("The question goes here")
  }
}

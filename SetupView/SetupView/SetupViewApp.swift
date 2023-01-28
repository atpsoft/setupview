import SwiftUI

@main
struct SetupViewApp: App {
  var body: some Scene {
    WindowGroup {
      // HomeView1()
      // HomeView2()
      // HomeView3()
    }
  }
}

struct Question {
  let value1: Int
  let value2: Int
  let answer: Int

  init(_ highestNumber: Int) {
    value1 = Int.random(in: 1...highestNumber)
    value2 = Int.random(in: 1...highestNumber)
    answer = value1 * value2
  }

  var prompt: String {
    "\(value1) x \(value2) = ?"
  }
}

struct HomeView1: View {
  @State var highestNumber: Int? = nil

  var body: some View {
    NavigationStack {
      Picker("Highest Number", selection: $highestNumber) {
        ForEach(4...12, id: \.self) { Text(String($0)) }
      }
      .pickerStyle(.wheel)
      NavigationLink(destination: QuestionView1(highestNumber: highestNumber!)) {
        Text("Start")
      }
    }
  }
}

struct QuestionView1: View {
  @State var highestNumber: Int
  @State var question: Question

  init(highestNumber: Int) {
    self.highestNumber = highestNumber
    self.question = Question(highestNumber)
  }

  var body: some View {
    Text(question.prompt)
    Button("I got it") {
      question = Question(highestNumber)
    }
  }
}

struct HomeView2: View {
  @State var highestNumber: Int? = nil

  var body: some View {
    NavigationStack {
      Picker("Highest Number", selection: $highestNumber) {
        ForEach(4...12, id: \.self) { Text(String($0)) }
      }
      .pickerStyle(.wheel)
      NavigationLink(destination: QuestionView2(highestNumber: $highestNumber)) {
        Text("Start")
      }
    }
  }
}

struct QuestionView2: View {
  @Binding var highestNumber: Int?
  @State var question: Question? = nil

  var body: some View {
    if let questionR = question {
      Text(questionR.prompt)
      Button("I got it") {
        question = Question(highestNumber!)
      }.onChange(of: highestNumber) { _ in
        question = Question(highestNumber!)
      }
    }
  }
}

struct HomeView3: View {
  @State var highestNumber: Int? = nil

  var body: some View {
    NavigationStack {
      Picker("Highest Number", selection: $highestNumber) {
        ForEach(4...12, id: \.self) { Text(String($0)) }
      }
      .pickerStyle(.wheel)
      NavigationLink(destination: QuestionView3(highestNumber: $highestNumber)) {
        Text("Start")
      }
    }
  }
}

struct QuestionView3: View {
  @Binding var highestNumber: Int?
  @State var question: Question? = nil

  var body: some View {
    if let questionR = question {
      Text(questionR.prompt)
      Button("I got it") {
        question = Question(highestNumber!)
      }
    }
    Text("Huzzah")
      .onAppear {
        question = Question(highestNumber!)
      }
  }
}

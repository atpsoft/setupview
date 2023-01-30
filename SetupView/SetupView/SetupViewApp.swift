import SwiftUI

@main
struct SetupViewApp: App {
  var body: some Scene {
    WindowGroup {
      Text("uncomment a HomeView to see each of the 4 bad examples")
      // HomeView1()
      HomeView2()
      // HomeView3()
      // HomeView4()
    }
  }
}

struct Question {
  let value1: Int
  let value2: Int
  let answer: Int

  init(_ highestNumber: Int) {
    print("Question.init \(highestNumber)")
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
  @State var highestNumber: Int = 12

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
  @Binding var highestNumber: Int
  @State var question: Question

  init(highestNumber: Binding<Int>) {
    print("QuestionView2.init")
    self._highestNumber = highestNumber
    question = Question(highestNumber.wrappedValue)
  }

  var body: some View {
    Text(question.prompt)
    Button("I got it") {
      question = Question(highestNumber)
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

struct HomeView4: View {
  @State var highestNumber: Int? = nil
  @State var question: Question? = nil

  var body: some View {
    NavigationStack {
      Picker("Highest Number", selection: $highestNumber) {
        ForEach(4...12, id: \.self) { Text(String($0)) }
      }
      .pickerStyle(.wheel)
      NavigationLink(destination: QuestionView4(highestNumber: $highestNumber, question: $question)) {
        Text("Start")
      }.onChange(of: highestNumber) { _ in
        question = Question(highestNumber!)
      }
    }
  }
}

struct QuestionView4: View {
  @Binding var highestNumber: Int?
  @Binding var question: Question?

  var body: some View {
    if let questionR = question {
      Text(questionR.prompt)
      Button("I got it") {
        question = Question(highestNumber!)
      }
    }
  }
}

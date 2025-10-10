import UIKit
import Combine

let subject = CurrentValueSubject<Int, Never>(0)

let subscription = subject
    .sink { num in
        print("숫자 \(num)가 서브젝트로 잘 전달되었습니다")
    }

import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    var body: some View {
        Button("Click") {
            let randomNunber = Int.random(in: 0...10)
            let sum = subject.value + randomNunber
            subject.send(sum)
        }
    }
}

PlaygroundPage.current.setLiveView(ContentView())

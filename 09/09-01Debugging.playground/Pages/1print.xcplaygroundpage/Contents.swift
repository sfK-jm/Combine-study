import UIKit
import Combine

let url = URL(string: "https://www.google.com")!

print("=== 정상적으로 데이터를 받은경우 ===")

let subscription = URLSession.shared.dataTaskPublisher(for: url)
    .print("[정상적인 경우]")
    .sink { completion in
        print(completion)
    } receiveValue: { (data: Data, response: URLResponse) in
        print("data count: \(data.count)")
    }

print("=== subscription을 달지 않은 경우 ===")

URLSession.shared.dataTaskPublisher(for: url)
    .print("[subscription을 달지 않은 경우] ")
    .sink { completion in
        print(completion)
    } receiveValue: { (data: Data, response: URLResponse) in
        print("data count: \(data.count)")
    }

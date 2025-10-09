# Combine (Operator와 Subscriber) 살펴보기 

```swift
import Foundation
import Combine

struct CatFact: Decodable {
    let fact: String
    let length: Int
}

var anyCancellables: Set<AnyCancellable> = []

// 정상 주소
let url = URL(string: "https://catfact.ninja/fact")!
// 오류 주소
//let url = URL(string: "httpcatfact.ninja/fact")!


func fetchCatFactPublisher() -> AnyPublisher<CatFact, Error>{
    URLSession.shared.dataTaskPublisher(for: url)
        .map({ (data: Data, response: URLResponse) in
            return data
        })
        .decode(type: CatFact.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
}

fetchCatFactPublisher()
    .sink { completion in
        switch completion {
        case .finished:
            print("정상적으로 완료")
        case .failure(let error):
            print("에러 발생: \(error)")
        }
    } receiveValue: { catFact in
        print(catFact)
    }
    .store(in: &anyCancellables)
```

# 일반적인 비동기 코드와 combine코드 비교

## no Combine 일반적인 비동기 코드

```swift
import Foundation

struct CatFact: Decodable {
    let fact: String
    let length: Int
}

func fetchCatFact(completion: @escaping (CatFact) -> Void) {
    let url = URL(string: "https://catfact.ninja/fact")!

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        //에러 처리 코드 생략
        let decoder = JSONDecoder()
        let catFact = try! decoder.decode(CatFact.self, from: data!)
        completion(catFact)
    }
    task.resume()
}

fetchCatFact { catFactString in
    DispatchQueue.main.async {
        //뷰에 데이터 장착하는 부분
        print(catFactString)
    }
}
```

## 컴바인 적용 후

```swift
import Foundation
import Combine

struct CatFact: Decodable {
    let fact: String
    let length: Int
}

func fetchCatFactPubliser() -> AnyPublisher<CatFact, Error> {
    let url = URL(string: "https://catfact.ninja/fact")!
    
    return URLSession.shared.dataTaskPublisher(for: url)
        .map { (data: Data, response: URLResponse) in
            return data
        }
        .decode(type: CatFact.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
}

let subscription = fetchCatFactPubliser()
    .sink { completion in
        print(completion)
    } receiveValue: { catFatct in
        print(catFatct)
    }

```

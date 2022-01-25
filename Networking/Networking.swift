//
//  Networking.swift
//  NYReader
//
//  Created by Hp  on 24/01/2022.
//
import Moya
import Foundation

struct Networking {
    enum NewsService {
        case MostPopular
    }
    
    static func getPopularNews(successHandler: @escaping ([NewsModel]) -> (), failureHandler: @escaping (MoyaError) -> ()) {
        let provider = MoyaProvider<NewsService>()
        provider.request(.MostPopular) { result in
            switch result {
                case .success(let response):
                    let responseCode = response.statusCode
                    if responseCode != 200 {
                        let errorResponse = Response(statusCode: responseCode, data: response.data)
                        let error = MoyaError.statusCode(errorResponse)
                        failureHandler(error)
                    } else {
                        let data = response.data
                        
                        do {
                            let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                            let news = newsResponse.news
                            
                            successHandler(news)
                        } catch {
                            print(error)
                            let errorResponse = Response(statusCode: 0, data: response.data)
                            let failureError = MoyaError.jsonMapping(errorResponse)
                            
                            failureHandler(failureError)
                        }
                    }
                case .failure(let error):
                    failureHandler(error)
            }
        }
    }
}

extension Networking.NewsService : TargetType
{
    var baseURL: URL {
        URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/7.json?api-key=bxyD8pT7gTWkU3uwDmPca7RQGbAwGeeZ")!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

        

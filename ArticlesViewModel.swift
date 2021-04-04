//
//  ArticlesViewModel.swift
//  articles-API
//
//  Created by Abdullah Alnutayfi on 03/04/2021.
//

import Foundation


class AriclesViewModel: ObservableObject{
   
    @Published var articles = [Articles]()
    
   func fetchData(){
    let API_KEY = ""
    let API_URL = "https://newsapi.org/v2/everything?q=apple&from=2021-04-02&to=2021-04-02&sortBy=popularity&apiKey=\(API_KEY)"
        guard let url = URL(string: API_URL)else{
            return
        }
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        URLSession.shared.dataTask(with: request) { (data, _, error) in
          
            if let data = data{
                do{
                let response = try decoder.decode(News.self, from: data)
                    DispatchQueue.main.async {
                        self.articles = response.articles.compactMap(){$0}
                    }
               
                   print(response)
                }catch{
                    print(error.localizedDescription)
                }
            }
            print(error?.localizedDescription as Any)
        }.resume()
    }
    var dateFormatter : DateFormatter?{
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }
    func loadImage(ImageUrl: String) -> Data?{
        guard let url = URL(string: ImageUrl) else {return Data()}
        if let data = try? Data(contentsOf: url){
            return data
        }
        return nil
    }
}

struct News : Codable{
    var articles : [Articles]
}


struct Articles : Codable,Identifiable {
    var title : String?
    var author : String?
    var description : String?
    var url : String?
    var urlToImage : String?
    var publishedAt : String
    var content : String?
    var id : String?{
        url
    }
    var date : Date{
        let dateFormatter = DateFormatter()
       // dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:publishedAt)!
        return date
    }
  
}

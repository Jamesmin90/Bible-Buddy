//
//  Bible.swift
//  ChristeninMuenchen
//
//  Created by admin on 12.05.20.
//  Copyright © 2020 Gruppe03. All rights reserved.
//

import SwiftUI

struct BibleView: View {
    
    @State var text: String = ""
    @State var error: String = ""
    @State var data: String = ""
    @State var content: String = ""
    
    var body: some View {
        VStack {
            if (content == "") {
                Text("BibleContent")
                Button(action: {self.getDataFromUrl()}) {
                    Text("Button")
                }
                
                if (error != "") {
                    Text(error)
                }
                
                if (text != "") {
                    Text(text)
                }
            }
            else {
                HTMLStringView(htmlContent: content).font(.system(size: 12))

            }

            
//            UILabel().attributedText = content

            
            }
            
//            if (content != "") {
//            }
        }
//    }
    
    func getDataFromUrl() {
        
        let urlTest = "https://api.scripture.api.bible/v1/bibles/542b32484b6e38c2-01/chapters/GEN.1"
        
        var request = URLRequest(url: URL(string: urlTest)!)
        request.setValue("ea17ec75497f6980cc7d63f8428656da", forHTTPHeaderField: "api-key")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
                        guard let data = data, error == nil else {
                            print("sth went wrong")
                            self.error = "Failed 1"
                            return
                        }
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)

            }
            
                        var result: MyTestResult?
                        do {
                            print("in do loop")
                            self.text = "Worked before"
                            result = try JSONDecoder().decode(MyTestResult.self, from: data)
//                            result = try JSONSerialization.jsonObject(with: data!) as! Response
                            self.text = "Worked"
                        }
                        catch {
                            self.error = "Failed 2"
                            print("failed to converts")
                            self.error = "Failed 2"
                        }
            
//            print(result?.status)
            
                        guard let json = result else {
                            self.error = "Failed 3"
                            return
                        }
            
            print(json.data.bibleId)
            
            print(json.data.content)
            
//            let decoded = CFXMLCreateStringByUnescapingEntities(nil, encoded, nil) as String
            
            self.content = json.data.content

//                        print(json.status)

//            print(json.results.data.id)
            
        }
        
        task.resume()
    }
    
}

extension String {
    /// Converts HTML string to a `NSAttributedString`

    var htmlAttributedString: NSAttributedString? {
        return try? NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
}

//let url = "https://api.scripture.api.bible/v1/bibles/ea17ec75497f6980cc7d63f8428656da/chapters/GEN.1"

struct Response: Codable {
    let results: MyTestResult
//    let status: String
}

struct MyTestResult: Codable {
    let data: MyTestData
    let meta: MyTestMeta
}

struct MyTestData: Codable {
    let id: String
    let bibleId: String
    let number: String
    let bookId: String
    let content: String
    let reference: String
//    let next: nextPrevious
//    let previous: nextPrevious
    let copyright: String
}

struct nextPrevious: Codable {
    let id: String
    let bookId: String
    let number: String
}

struct MyTestMeta: Codable {
    let fums: String
    let fumsId: String
    let fumsJsInclude: String
    let fumsJs: String
    let fumsNoScript: String
}


//struct Response: Codable {
//    let results: MyResult
//    let status: String
//}

struct MyResult: Codable {
    let data: MyData
    let meta: MyMeta
}

struct MyData: Codable {
    let id: String
    let bibleId: String
    let number: String
    let bookId: String
    let content: String
    let reference: String
    let next: MyNext
    let previous: MyPrevious
    let copyright: String
}

struct MyNext: Codable {
    let id: String
    let bookId: String
    let number: String
}

struct MyPrevious: Codable {
    let id: String
    let bookId: String
    let number: String
}

struct MyMeta: Codable {
    let fums: String
    let fumsId: String
    let fumsJsInclude: String
    let fumsJs: String
    let fumsNoScript: String
}



struct BibleView_Previews: PreviewProvider {
    static var previews: some View {
        BibleView()
    }
}

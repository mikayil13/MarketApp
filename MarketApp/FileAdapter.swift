//
//  FileAdapter.swift
//  MarketApp
//
//  Created by Mikayil on 13.01.25.
//

import Foundation
enum FileName: String {
    case basket = "basket.json"
}
class FileAdapter{
    func getFilePath(fileName: FileName = .basket) -> URL {
        let files = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let path = files[0].appendingPathComponent(fileName.rawValue)
        print(path)
        return path
        
    }
    func readData(completion:(([Product]?) ->Void )){
        if let data = try? Data(contentsOf: getFilePath()) {
            do{
                let  items = try JSONDecoder().decode([Product].self, from: data)
                completion(items)
            }catch{
                print(error.localizedDescription)
            }
        }else{
            completion(nil)
        }
    }
    
    func writeData(items:[Product]){
        do{
            let data = try JSONEncoder().encode(items)
            let path = getFilePath()
            try data.write(to: path)
        }catch{
            print(error.localizedDescription)
        }
    }
}

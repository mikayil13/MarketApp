//
//  UserAdapter.swift
//  MarketApp
//
//  Created by Mikayil on 06.01.25.
//

import Foundation
class UserAdapter {
    func getFilePath() -> URL {
        let files = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let path = files[0].appendingPathComponent("users.json")
        print(path)
        return path
        
    }
    func readDate(completion:(([User]) ->Void )){
        if let data = try? Data(contentsOf: getFilePath()) {
            do{
              let  users = try JSONDecoder().decode([User].self, from: data)
                completion(users)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    func writedata(user:[User]){
        do{
            let data = try JSONEncoder().encode(user)
            let path = getFilePath()
            try data.write(to: path)
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    
}

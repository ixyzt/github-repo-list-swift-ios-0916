//
//  FISGithubAPIClient.swift
//  github-repo-list-swift
//
//  Created by  susan lovaglio on 10/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class GithubAPIClient {
    
    static var completeJSON = [[String:Any]]()
    
    class func getRepositories(completionHandler: @escaping ([[String: Any]]?)->()) {
        
        let urlString = "https://api.github.com/repositories?client_id=\(Secrets.clientID)&client_secret=\(Secrets.clientSecret)"
        let url = URL(string: urlString)
        
        let session = URLSession.shared
        
        if let unwrappedURL = url {
            
            let dataTask = session.dataTask(with: unwrappedURL, completionHandler: { (data, response, error) in
                
                
                // checks for internet accessibility
                let httpResponse = response as! HTTPURLResponse
                if httpResponse.statusCode == 200 {
                    
                    if let unwrappeddata = data {
                        print("I'm running")
                        do {
                            let responseJSON = try
                                JSONSerialization.jsonObject(with: unwrappeddata, options: [])
//                            dump(responseJSON)
                            self.completeJSON = responseJSON as! [[String : Any]]
//                            dump(self.completeJSON)
                            completionHandler(self.completeJSON)
                        } catch {
                            
                        }
                    }
                }
            })
            dataTask.resume()
        }
    }
}




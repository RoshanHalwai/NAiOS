//
//  DownloadService.swift
//  nammaApartment
//
//  Created by Vikas Nayak on 24/09/18.
//  Copyright © 2018 Vikas Nayak. All rights reserved.
//

import Foundation
import UIKit

class DownloadService {
    
    private init() {}
    static let shared = DownloadService()
    
    func getImage(with urlString: String, completion: @escaping (URL) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, _, _) in
            
            let fileManager = FileManager.default
            
            guard let data = data,
                let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
                else { return }
            
            let fileUrl = documentsUrl.appendingPathComponent("image.jpg")
            do {
                try data.write(to: fileUrl)
                DispatchQueue.main.async {
                    completion(fileUrl)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

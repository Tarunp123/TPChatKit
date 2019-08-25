//
//  TPDownloadManager.swift
//  TPChatKit
//
//  Created by Tarun on 05/05/19.
//  Copyright © 2019 Tarun Prajapati. All rights reserved.
//

import Foundation

protocol TPDownloadManagerDelegate {
    func tpDownloadManager(_ manager: TPDownloadManager, didFailToDownloadFromURL remoteURL: URL, withError error: Error?)
    func tpDownloadManager(_ manager: TPDownloadManager, didDownloadFileChunkFromURL remoteURL: URL, withProgress progress: Double)
    func tpDownloadManager(_ manager: TPDownloadManager, didDownloadFileFromURL remoteURL: URL, toLocation location: URL)
}


class TPDownloadManager: NSObject, URLSessionDelegate, URLSessionDownloadDelegate{
    
    private let fileURL: URL

    var delegate: TPDownloadManagerDelegate?
    
    init?(fileURL: String, delegate: TPDownloadManagerDelegate){
        guard let url = Foundation.URL(string: fileURL) else{
            return nil
        }
        self.fileURL = url
        self.delegate = delegate
    }
    
    
    func startDownload() {
        let request = URLRequest(url: self.fileURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: .infinity)
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        session.downloadTask(with: request).resume()
    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let downloadProgress = totalBytesExpectedToWrite == -1 ? -1 : Double(totalBytesWritten)/Double(totalBytesExpectedToWrite)
        self.delegate?.tpDownloadManager(self, didDownloadFileChunkFromURL: self.fileURL, withProgress: downloadProgress)
    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        self.delegate?.tpDownloadManager(self, didDownloadFileFromURL: self.fileURL, toLocation: location)
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        self.delegate?.tpDownloadManager(self, didFailToDownloadFromURL: self.fileURL, withError: error)
    }
    
}

//
//class TPUploadManager: NSObject, URLSessionDelegate, URLSessionDownloadDelegate{
//    
//    private let uploadURL: URL
//    private let fileData: Data
//
//    var delegate: TPDownloadManagerDelegate?
//
//    init?(fileURL: String, delegate: TPDownloadManagerDelegate){
//        guard let url = Foundation.URL(string: fileURL) else{
//            return nil
//        }
//        self.fileURL = url
//        self.delegate = delegate
//    }
//
//
//    func startUpload() {
//        var request = URLRequest(url: self.fileURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: .infinity)
//        request.httpMethod = "POST"
//        request.httpBody =
//        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
//        session.uploadTask(with: request, fromFile: <#T##URL#>)//downloadTask(with: request).resume()
//    }
//
//
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
//        let downloadProgress = totalBytesExpectedToWrite == -1 ? -1 : Double(totalBytesWritten)/Double(totalBytesExpectedToWrite)
////        self.delegate?.tpDownloadManager(self, didDownloadFileChunkFromURL: self.fileURL, withProgress: downloadProgress)
//    }
//
//
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
////        self.delegate?.tpDownloadManager(self, didDownloadFileFromURL: self.fileURL, toLocation: location)
//    }
//
//    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
////        self.delegate?.tpDownloadManager(self, didFailToDownloadFromURL: self.fileURL, withError: error)
//    }
//
//}

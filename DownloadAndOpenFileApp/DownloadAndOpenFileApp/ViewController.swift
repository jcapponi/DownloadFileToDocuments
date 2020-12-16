//
//  ViewController.swift
//  DownloadAndOpenFileApp
//
//  Created by Juan Capponi on 12/13/20.
//

import UIKit

class ViewController: UIViewController {
    
    var newUrl: URL!

    @IBOutlet weak var acivityIndicator: UIActivityIndicatorView!
    
    @IBAction func downloadFileButton(_ sender: Any) {
        
        self.acivityIndicator.startAnimating()
        self.acivityIndicator.isHidden = false
        
        
        guard let url = URL(string: "https://jorgesanchez.net/manuales/viejos/fpr/Java.pdf") else {
            print("URL Error")
            stopAnimating()
            return
        }
        let task = URLSession.shared.downloadTask(with: url) { (data, response, error) in
            guard let originalUrl = data else { return }
            
            //print("originalUrl..: \(originalUrl)")
            
            do {
                // get path to directory
                let path = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                
                //print("path..: \(path)")
                
                // giving name to file
                self.newUrl = path.appendingPathComponent("java_tutorial.pdf")
                
                //print("newUrl..: \(String(describing: self.newUrl))")
                
                //remove file fisrt if exists
                if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
                let removeFile = dir.appendingPathComponent("java_tutorial.pdf")
                let fileManager = FileManager.default
                do{
                    try fileManager.removeItem(at: removeFile)
                }catch  {
                        self.stopAnimating()
                        print("cant remove file… file doesn't exists")
                    }
                }
                
                //move file to oldUrl to a new permnanent url (Documents directory)
                try FileManager.default.moveItem(at: originalUrl, to: self.newUrl)
                self.stopAnimating()
            } catch {
                print("error..: \(error.localizedDescription)")
                self.stopAnimating()
                return
            }
        }
        task.resume()
    }
    
    @IBAction func openFileButton(_ sender: Any) {
        
        guard let url = self.newUrl else {
            print("Download the file before open it")
            return
        }
            
        let pdfView = storyboard?.instantiateViewController(identifier: "pDFReaderViewController") as! PDFReaderViewController
        
        print("ViewController pdfUrl..: \(url)")
        
        pdfView.pdfUrl = url
        navigationController?.pushViewController(pdfView, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.acivityIndicator.isHidden = true
    }
    
    func stopAnimating(){
        DispatchQueue.main.async {
               self.acivityIndicator.stopAnimating()
               self.acivityIndicator.isHidden = true
           }
    }
}


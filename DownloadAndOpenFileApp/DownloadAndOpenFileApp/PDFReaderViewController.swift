//
//  PDFReaderViewController.swift
//  DownloadAndOpenFileApp
//
//  Created by Juan Capponi on 12/15/20.
//

import UIKit
import PDFKit



class PDFReaderViewController: UIViewController {

   
 
    var pdfUrl: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pdfView = PDFView()
        self.view.addSubview(pdfView)
        
        
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)

        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        print("PDFReaderViewController pdfUrl..: \(pdfUrl )")
        
       
        if let doc = PDFDocument(url: pdfUrl) {
            pdfView.document = doc
        }
        
        
    }
}

//
//  CustomSegue.swift
//  LessonProgram
//
//  Created by Furkan Ekinci on 13.09.2023.
//

import UIKit

class CustomSegue: UIStoryboardSegue {

    override func perform() {
        // Geçişin nasıl gerçekleşeceğini belirleyin
        if let sourceView = source.view, let destinationView = destination.view {
                let screenWidth = UIScreen.main.bounds.size.width
                let screenHeight = UIScreen.main.bounds.size.height

                // Başlangıç konumu
                destinationView.frame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight)

                // Hedef konumu
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.addSubview(destinationView)

                    // Geçiş animasyonu
                    UIView.animate(withDuration: 0.5, animations: {
                        destinationView.frame = sourceView.frame
                    }) { (finished) in
                        self.source.present(self.destination, animated: false, completion: nil)
                    }
                }
            }
    }
}

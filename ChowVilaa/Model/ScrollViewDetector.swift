//
//  ScrollViewDetector.swift
//  ChowVilaa
//
//  Created by Bryan Danquah on 05/09/2023.
//

import SwiftUI

struct ScrollViewDetector: UIViewRepresentable{
    @Binding var carousel: Bool
    var totalCardCount: Int
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.async {
            if let scrollView = uiView.superview?.superview?.superview as? UIScrollView {
                scrollView.decelerationRate = carousel ? .fast : .normal
                if carousel {
                    scrollView.delegate = context.coordinator
                }else {
                    scrollView.delegate = nil
                }
                
                context.coordinator.totalCardCount = totalCardCount
            }
        }
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: ScrollViewDetector
        init(parent: ScrollViewDetector) {
            self.parent = parent
        }
        
        var totalCardCount: Int = 0
        var velocityY: CGFloat = 0
        
        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGFloat, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            let cardHeight: CGFloat = 220
            let cardSpace: CGFloat = 35
            
            let targetEnd: CGFloat = scrollView.contentOffset.y + (velocity * 60)
            let index = (targetEnd / cardHeight).rounded()
            let modifiedEnd = index * cardHeight
            let spacing = cardSpace * index
            
            targetContentOffset.pointee.y = modifiedEnd + spacing
            velocityY = velocity
        }
        
        func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            let cardHeight: CGFloat = 220
            let cardSpace: CGFloat = 35
            
            let targetEnd: CGFloat = scrollView.contentOffset.y + (velocityY * 60)
            let index = max(min((targetEnd / cardHeight).rounded(), CGFloat(totalCardCount - 1)), 0.0)
            let modifiedEnd = index * cardHeight
            let spacing = cardSpace * index
            
            scrollView.setContentOffset(.init(x: 0, y: modifiedEnd + spacing), animated: true)
        }
    }
}


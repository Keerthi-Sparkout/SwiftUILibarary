//
//  SwiftUIView.swift
//  
//
//  Created by apple on 31/08/24.
//

import SwiftUI

@available(iOS 13.0.0, *)
public struct SwiftUIView: View {
    @StateObject var viewModel: ViewModel  = .init(delegate: ApiProtocol())

    public init() {
        
    }
    
    public var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear() {
                viewModel.fetchDetails().sink { error in
                    print(error)
                } receiveValue: { result in
                    print(result)
                }

            }
    }
}

//#Preview {
//    SwiftUIView()
//}

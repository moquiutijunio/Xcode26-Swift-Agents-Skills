//
//  AuthCoordinatorView.swift
//  swift-agents-skills
//
//  Created by Junio Cesar Moquiuti on 10/04/26.
//

import SwiftUI

struct AuthCoordinatorView: View {
    enum Route: Hashable {
        case register
    }
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            LoginView {
                path.append(Route.register)
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .register:
                    RegisterView()
                }
            }
        }
    }
}

#Preview {
    AuthCoordinatorView()
}

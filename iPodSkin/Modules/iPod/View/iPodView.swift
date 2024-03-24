//
//  iPodView.swift
//  iPodSkin
//
//  Created by Максим Алексеев  on 21.11.2023.
//

import SwiftUI
import Combine
//struct DismissAction {
//    typealias Action = () -> ()
//    let action: Action
//    func callAsFunction() {
//        action()
//    }
//}
//
//struct DismissActionKey: EnvironmentKey {
//    static var defaultValue: DismissAction? = nil
//}

struct ModalModeKey: EnvironmentKey {
//    static let defaultValue = Binding<Bool>.constant(false) // < required
    static let defaultValue = PassthroughSubject<Bool, Never>()
}

// define modalMode value
extension EnvironmentValues {
    var modalMode: PassthroughSubject<Bool, Never> {
        get { self[ModalModeKey.self] }
        set { self[ModalModeKey.self] = newValue }
    }
}

//extension EnvironmentValues {
//    var dismissAction: DismissAction? {
//        get { self[DismissActionKey.self] }
//        set { self[DismissActionKey.self] = newValue }
//    }
//}

extension View {
//    func on(_ action: @escaping CreateNoteAction.Action) -> some View {
//        self.environment(\.createNote, CreateNoteAction(action: action))
//    }
//    func onDismissAction(_ action: @escaping DismissAction.Action) -> some View {
//        self.environment(\.dismissAction, DismissAction(action: action))
//    }
}

struct iPodView: View {
    @ObservedObject var viewModel: iPodViewModel
//    @State var onMenuPressed: Void
//    @State var showModal: Bool = true 
    @State var showingModalSubject = PassthroughSubject<Bool, Never>()
    
    var body: some View {
        VStack {
            Button(action: {
                viewModel.connectPressd()
            }, label: {
                Text("connect to spotify")
            })
            .background(.green)
            .frame(width: 100, height: 100)
            
            
            ScreenViewContainer(title: "Albums") {
                iPodRouter.destinationForHomeMenu(using: viewModel.networkService, spotifyService: viewModel.spotifyService)
                    .environment(\.modalMode, showingModalSubject)
//                    .environment(onMenuPressed)
            }
            .padding(.bottom, 61)
            .padding(.horizontal, 30)
            .padding(.top, 30)
            
            ControlView(lastButtonPressed: {
                viewModel.lastPressed()
            }, nextButtonPressed: {
                viewModel.nextPressed()
            }, menuButtonPressed: {
                showingModalSubject.send(false)
                viewModel.menuPressed()
            }, playPausePressed: {
                viewModel.playPausePressed()
            })
            .frame(width: 230, height: 230, alignment: .center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(colors: [Color(red: 40/255, green: 40/255, blue: 41/255), Color(red: 103/255, green: 100/255, blue: 103/255)], startPoint: .bottom, endPoint: .top)
        )
    }
}

//#Preview {
//    iPodView(viewModel: iPodViewModel(spotifyService: <#SpotifyService#>, networkService: <#Networkable#>))
//}

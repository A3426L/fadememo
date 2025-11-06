//
//  ContentView.swift
//  fadememo
//
//  Created by aru on 2025/11/06.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var coordinator: AppCoordinator
    let vm: MainCameraViewModelImpl

    init() {
        let photoRepository = PhotoRepositoryImpl()
        let container = AppContainer(
            makePhotoUseCase: { photoUseCaseImpl(repository: photoRepository) }
        )
        let coordinator = AppCoordinator(container: container)
        _coordinator = StateObject(wrappedValue: coordinator)
        let service = CameraServiceImpl()
        let photoUseCase = photoUseCaseImpl(repository: photoRepository)
        self.vm = MainCameraViewModelImpl(service: service, coordinator: coordinator, photoUseCase: photoUseCase)
        vm.viewdidLoad()
    }
    var body: some View{
        MainCameraView(vm: vm)
            .sheet(item: $coordinator.presentedRoute) { route in
                coordinator.destinationView(for: route)
            }
            .environmentObject(coordinator)
    }
}

#Preview {
    ContentView()
}

import SwiftUI

struct CargoConfig {
    @DevelopmentLocalToggle(key: "cargo")
    var value: LocalToggleValue

    var isFeatureEnabled: Bool {
        switch value {
        case .on:
            return true
        case .off:
            return false
        }
    }
}

struct CourierConfig {
    @DevelopmentRemoteToggle(key: "courier")
    var value: RemoteToggleValue

    var isFeatureEnabled: Bool {
        switch value {
        case .on:
            return true
        case .off:
            return false
        case .default:
            return isEnabledOnServer
        }
    }

    let isEnabledOnServer: Bool
}

struct ContentView: View {
    let cargoConfig = CargoConfig()
    let courierConfig = CourierConfig(isEnabledOnServer: true)

    var body: some View {
        VStack {
            Text("Cargo: \(cargoConfig.isFeatureEnabled ? "enabled" : "disabled")")
            Text("Courier: \(courierConfig.isFeatureEnabled ? "enabled" : "disabled")")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

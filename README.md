# CountriesList

An iOS app that displays a searchable, dynamic list of countries with region, capital, and code. The app demonstrates clean MVVM architecture, robust error handling, Dynamic Type, and full support for iPhone and iPad, including rotation.

## Features

- Fetches country data from a remote JSON API.
- Search countries or capitals.
- Handles loading, errors, and empty states.
- Custom table view cell layout for improved readability.
- **Dynamic Type**: fully supports larger/smaller text sizes.
- Supports both **iPhone and iPad**, and all device orientations.
- Modular architecture with a separate service layer.
- Unit tested with async/await and dependency injection.

  
## Architecture

- **MVVM**: Model-View-ViewModel pattern
- **Service Layer**: All networking is separated into `CountryService.swift`
- **UIKit**: Uses `UITableViewController` for best practices

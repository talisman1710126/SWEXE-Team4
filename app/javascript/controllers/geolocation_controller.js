import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "latitude", "longitude", "status"]

  sortByDistance() {
    if (!navigator.geolocation) {
      this.statusTarget.textContent = "Location is not available in this browser."
      return
    }

    this.buttonTarget.disabled = true
    this.statusTarget.textContent = "Requesting your location..."

    navigator.geolocation.getCurrentPosition(
      ({ coords }) => {
        this.latitudeTarget.value = coords.latitude
        this.longitudeTarget.value = coords.longitude
        this.element.requestSubmit()
      },
      (error) => {
        this.buttonTarget.disabled = false
        this.statusTarget.textContent = error.code === error.PERMISSION_DENIED
          ? "Location permission was denied. You can still browse all spots."
          : "Your location could not be determined. Please try again."
      }
    )
  }
}

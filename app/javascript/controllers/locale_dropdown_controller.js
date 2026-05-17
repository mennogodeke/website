import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "trigger"]

  toggle() {
    const open = this.menuTarget.classList.toggle("is-open")
    this.triggerTarget.setAttribute("aria-expanded", open)
  }

  closeOnOutside(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.remove("is-open")
      this.triggerTarget.setAttribute("aria-expanded", "false")
    }
  }
}

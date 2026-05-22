import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggle() {
    const opening = !this.element.classList.contains("open")
    this.element.classList.toggle("open")
    if (opening) this.dispatch("opened")
  }
}

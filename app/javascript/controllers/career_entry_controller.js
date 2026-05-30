import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggle() {
    const opening = !this.element.classList.contains("is-open")
    this.element.classList.toggle("is-open")
    if (opening) this.dispatch("opened")
  }
}

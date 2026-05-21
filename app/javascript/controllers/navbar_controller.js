import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "burger"]

  connect() {
    this.navEl = this.element.querySelector("nav")
    this.onScroll = this.handleScroll.bind(this)
    window.addEventListener("scroll", this.onScroll, { passive: true })
    this.handleScroll()
  }

  disconnect() {
    window.removeEventListener("scroll", this.onScroll)
  }

  handleScroll() {
    this.navEl.classList.toggle("is-scrolled", window.scrollY > 20)
  }

  toggle() {
    this.menuTarget.classList.toggle("is-active")
    this.burgerTarget.classList.toggle("is-active")
  }
}

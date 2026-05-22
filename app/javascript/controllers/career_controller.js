import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["entry"]

  closeOthers({ target }) {
    const opened = target.closest(".tl-entry")
    this.entryTargets.forEach(entry => {
      if (entry !== opened) entry.classList.remove("open")
    })
  }
}

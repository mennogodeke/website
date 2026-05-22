import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["row", "panel"]

  connect() {
    const params = new URLSearchParams(window.location.search)
    const key = params.get("area") || this.rowTargets[0]?.dataset.experienceKey
    if (key) this.activateKey(key, false)
  }

  select(event) {
    this.activateKey(event.currentTarget.dataset.experienceKey, true)
  }

  activateKey(key, updateUrl) {
    this.rowTargets.forEach(row => {
      const active = row.dataset.experienceKey === key
      row.classList.toggle("active", active)
      row.setAttribute("aria-selected", active)
    })

    this.panelTargets.forEach(panel => {
      const active = panel.dataset.experienceKey === key
      if (!active) {
        panel.querySelectorAll(".bar i").forEach(bar => bar.style.width = "0")
        panel.hidden = true
      } else {
        panel.hidden = false
        requestAnimationFrame(() => {
          panel.querySelectorAll(".bar i").forEach(bar => {
            bar.style.width = (bar.dataset.width || "0") + "%"
          })
        })
      }
    })

    if (updateUrl) {
      const url = new URL(window.location)
      url.searchParams.set("area", key)
      history.replaceState({}, "", url)
    }
  }
}

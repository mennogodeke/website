import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["swatch", "rpgBtn"]

  connect() {
    const palette = sessionStorage.getItem("palette")
    if (palette) this.#applyPalette(palette)
    const rpg = sessionStorage.getItem("rpg-mode")
    if (rpg) this.#applyRpg(rpg)
  }

  switch(event) {
    this.#applyPalette(event.currentTarget.dataset.paletteName)
  }

  switchRpg(event) {
    this.#applyRpg(event.currentTarget.dataset.rpgMode)
  }

  #applyPalette(name) {
    document.documentElement.setAttribute("data-palette", name)
    sessionStorage.setItem("palette", name)
    this.swatchTargets.forEach(s =>
      s.classList.toggle("is-active", s.dataset.paletteName === name)
    )
  }

  #applyRpg(mode) {
    document.documentElement.setAttribute("data-rpg", mode)
    sessionStorage.setItem("rpg-mode", mode)
    this.rpgBtnTargets.forEach(b =>
      b.classList.toggle("is-active", b.dataset.rpgMode === mode)
    )
  }
}

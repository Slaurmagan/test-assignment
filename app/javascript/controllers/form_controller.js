import {Controller} from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.updateOptions()
  }

  updateSecondSelect(event) {
    this.updateOptions()
  }

  updateOptions() {
    const sender = this.element.querySelector("#sender");
    const receiver = this.element.querySelector("#receiver");

    Array.from(receiver.options).forEach(option => option.remove())
    Array.from(sender.options).forEach((option, idx) => {
      if (idx === sender.options.selectedIndex) return;

      receiver.options.add(new Option(option.text, option.value))
    })
  }
}

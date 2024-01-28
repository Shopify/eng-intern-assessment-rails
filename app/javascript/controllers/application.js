import { Application } from "@hotwired/stimulus"
import ConfirmationController from "../controllers/confirmation_controller";

const application = Application.start();
application.register("confirmation", ConfirmationController);

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

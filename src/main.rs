use gtk::{prelude::*, Label};
use gtk::{Application, ApplicationWindow};
use gtk4 as gtk;

fn main() -> glib::ExitCode {
    let app = Application::builder()
        .application_id("org.example.HelloWorld")
        .build();

    app.connect_activate(|app| {
        // We create the main window.
        let window = ApplicationWindow::builder()
            .application(app)
            .default_width(320)
            .default_height(200)
            .title("Hello, World!")
            .build();

        let label = Label::new(Some("It works!"));

        window.set_child(Some(&label));

        // Show the window.
        window.show();
    });

    app.run()
}

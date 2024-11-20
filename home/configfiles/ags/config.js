const birthDate = new Date("1994-12-31T00:00:00Z"); // Your birth date

// Create a Variable to hold the calculated age
const age = Variable("", {
  poll: [
    50, // Update every second
    function () {
      const now = new Date();
      const calculatedAge =
        (now.getTime() - birthDate.getTime()) / (1000 * 60 * 60 * 24 * 365.25); // Age in years
      return calculatedAge.toFixed(12); // Format to 5 decimal places
    },
  ],
});

// Create a widget to display the age
const Bar = (/** @type {number} */ monitor) =>
  Widget.Window({
    monitor,
    name: `bar${monitor}`,
    anchor: ["bottom", "right"],
    css: "background-color: transparent;", // Transparent background
    exclusivity: "exclusive",
    layer: "bottom",
    child: Widget.CenterBox({
      center_widget: Widget.Label({
        css: "color: #e0def4; background:#1f1d2e; opacity: 0.8; padding: 8px;  font-size: 40px; margin-bottom: 32px; border-radius: 8px; margin-right: 48px;",
        hpack: "center",
        label: age.bind().as((value) => `${value}`), // Bind age to the label and format
      }),
    }),
  });

// Configure the application to display the widget
App.config({
  windows: [Bar(0)],
});

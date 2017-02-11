(function (root) {
  if (typeof MediumEditor !== "function") {
      throw new Error("Medium Editor is not loaded on the page.");
  }

  var MediumMarkdown = function (options, callback) {

    if (typeof options === "function") {
        callback = options;
        options = {};
    }

    // Defaults
    options = Object(options);
    options.events = options.events || ["input", "change"];
    callback = callback || options.callback || function () {};

    // Called by medium-editor during init
    this.init = function () {

        // If this instance of medium-editor doesn't have any elements, there's nothing for us to do
        if (!this.base.elements || !this.base.elements.length) { return; }

        // Element(s) that this instance of medium-editor is attached to is/are stored in .elements
        this.element = this.base.elements[0];

        var handler = function () {
            callback(toMarkdown(this.element.innerHTML).split("\n").map(function (c) {
                return c.trim();
            }).join("\n").trim());
        }.bind(this);

        options.events.forEach(function (c) {
            this.element.addEventListener(c, handler);
        }.bind(this));

        handler();
    };
  };

  var Wysiwyg = function (options) {
    var editorOptions = {
      autoLink: true,
      buttonLabels: 'fontawesome',
      toolbar: {
        /* These are the default options for the toolbar,
           if nothing is passed this is what is used */
        allowMultiParagraphSelection: true,
        buttons: [ 'bold', 'italic', 'h1', 'h2', 'h3', 'hr' ],
        diffLeft: 0,
        diffTop: -10,
        firstButtonClass: 'medium-editor-button-first',
        lastButtonClass: 'medium-editor-button-last',
        standardizeSelectionStart: false,
        static: true,
        relativeContainer: null,
        /* options which only apply when static is true */
        align: 'center',
        sticky: false,
        updateOnEmptySelection: true
      },
      extensions: {
        imageDragging: {},
        markdown: new MediumMarkdown(function (md) {
          options.markDownEl.textContent = md;
        }),
        hr: new HorizontalLine() 
      }
    }

    if (options.mode == 'default') {
      editorOptions.toolbar.buttons.push('anchor')
    }

    if (options.mode == 'stationery') {
      editorOptions.autoLink = false
      editorOptions.extensions.guestName = new GuestName()
      editorOptions.toolbar.buttons.push('guestName')
    }

    return new MediumEditor(options.editorEl, editorOptions)
  }

  root.Wysiwyg = Wysiwyg;
})(this);

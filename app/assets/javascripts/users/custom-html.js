(function () {
  function insertHtmlAtCaret(html) {
      var sel, range;
      if (window.getSelection) {
          // IE9 and non-IE
          sel = window.getSelection();
          if (sel.getRangeAt && sel.rangeCount) {
              range = sel.getRangeAt(0);
              range.deleteContents();

              // Range.createContextualFragment() would be useful here but is
              // only relatively recently standardized and is not supported in
              // some browsers (IE9, for one)
              var el = document.createElement("div");
              el.innerHTML = html;
              var frag = document.createDocumentFragment(), node, lastNode;
              while ((node = el.firstChild)) {
                  lastNode = frag.appendChild(node);
              }
              range.insertNode(frag);

              // Preserve the selection
              if (lastNode) {
                  range = range.cloneRange();
                  range.setStartAfter(lastNode);
                  range.collapse(true);
                  sel.removeAllRanges();
                  sel.addRange(range);
              }
          }
      } else if (document.selection && document.selection.type != "Control") {
          // IE < 9
          document.selection.createRange().pasteHTML(html);
      }
  };

  var HorizontalLine = MediumEditor.Extension.extend({
    name: 'hr',

    init: function () {
      this.button = document.createElement('button');
      this.button.classList.add('medium-editor-action');
      this.button.innerHTML = "<i class='fa fa-ellipsis-h'></i>";
      this.button.title = "Horizontal line";
      this.on(this.button, 'click', this.handleClick.bind(this));
    },

    handleClick: function () {
      insertHtmlAtCaret("<hr/>")
    },

    getButton: function () {
      return this.button;
    }
  })

  var GuestName = MediumEditor.Extension.extend({
    name: 'guestName',

    init: function () {
      this.button = document.createElement('button');
      this.button.classList.add('medium-editor-action');
      this.button.innerHTML = "<i class='fa fa-user'></i>";
      this.button.title = "Horizontal line";
      this.on(this.button, 'click', this.handleClick.bind(this));
    },

    handleClick: function () {
      insertHtmlAtCaret("{{ guest.name }}");
    },

    getButton: function () {
      return this.button;
    }
  })

  window.HorizontalLine = HorizontalLine;
  window.GuestName = GuestName;
})();

mergeInto(LibraryManager.library, {
  DeepalState: function (name, json) {
    window.dispatchEvent(new CustomEvent('deepal-state', {
      detail: {name: UTF8ToString(name), state: JSON.parse(UTF8ToString(json))}
    }));
  }
});

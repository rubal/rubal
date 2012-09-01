function isFullScreen(cm) {
    return /\bCodeMirror-fullscreen\b/.test(cm.getWrapperElement().className);
}
function winHeight() {
    return window.innerHeight || (document.documentElement || document.body).clientHeight;
}
function setFullScreen(cm, full) {
    var wrap = cm.getWrapperElement(), scroll = cm.getScrollerElement();
    if (full) {
        wrap.className += " CodeMirror-fullscreen";
        scroll.style.height = winHeight() + "px";
        document.documentElement.style.overflow = "hidden";
        $(wrap).appendTo($("#cm-fullscreen-container"));
        $("#cm-fullscreen-container").show();
    } else {
        $(wrap).appendTo($("#cm-normal-container"));
        $("#cm-fullscreen-container").hide();
        wrap.className = wrap.className.replace(" CodeMirror-fullscreen", "");
        scroll.style.height = "";
        document.documentElement.style.overflow = "";
    }
    cm.refresh();
}




function initCodeEditor() {
    var editor = CodeMirror.fromTextArea(document.getElementById("rubal-vhtml-editor"), {
        mode: "rubhtml",
        tabMode: "indent",
        lineNumbers: true,
        extraKeys: {
            "F11": function(cm) {
                setFullScreen(cm, !isFullScreen(cm));
            },
            "Esc": function(cm) {
                if (isFullScreen(cm)) setFullScreen(cm, false);
            }
        }
    });
}

$(document).ready(function() {
  $("a.form-helper").tooltip();
    CodeMirror.connect(window, "resize", function() {
        var showing = document.body.getElementsByClassName("CodeMirror-fullscreen")[0];
        if (!showing) return;
        showing.CodeMirror.getScrollerElement().style.height = winHeight() + "px";
    });

    CodeMirror.defineMode("rubhtml", function(config) {
        return CodeMirror.multiplexingMode(
            CodeMirror.getMode(config, "text/html"),
            {open: "[[", close: "]]",
                mode: CodeMirror.getMode(config, "text/plain"),
                delimStyle: "rubhtml-placeholder"}
            // .. more multiplexed styles can follow here
        );
    });
});

$(function() {
  $(".update-type-select").change(toggleChangeNote);
  toggleChangeNote();
});

function toggleChangeNote() {
  var value = $(".update-type-select:checked").val();
  var changeNote = $(".change-note-form-group");

  if (value == "major") {
    changeNote.show();
  } else {
    changeNote.hide();
  }
}

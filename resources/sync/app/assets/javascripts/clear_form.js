function clearForm(form) {
  $(form).find(':input').not(':button, :submit, :reset, :hidden, :checkbox, :radio').val('');
  $(form).find(':checkbox, :radio').prop('checked', false);
}

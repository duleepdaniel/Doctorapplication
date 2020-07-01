(function() {
  jQuery(function() {
    var patients;
    patients = $('#meeting_patient_id').html();
    console.log(patients)

    $('#meeting_user_id').change(function() {
      var user, new_patients;
      user = $('meeting_user_email :selected');
      new_patients = $(patients).filter("optgroup[label='" + user + "']").html();
      console.log(new_patients)
      return $('#meeting_patient_id').html(new_patients);
    });
  });

}).call(this);

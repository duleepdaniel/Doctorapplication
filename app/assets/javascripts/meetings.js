$(document).ready(function(){
  var patients;
    patients = $('#meeting_patient_id').html();

    $('#meeting_user_id').change(function() {
      var selected_user, new_patients, users;

      users = $('#meeting_user_id').html();
      selected_user = $('#meeting_user_id option:selected');
      new_patients = $(patients).filter("optgroup[label='" + selected_user.text() + "']").html();
      return $('#meeting_patient_id').html(new_patients);
    });
  });

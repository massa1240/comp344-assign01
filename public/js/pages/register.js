$('#search-email').on('click', function(e) {
	searchLoading = $('#search-email-loading');
	formHidden = $('.form-hidden');
	$this = $(this);
	$('.error').remove();
	$email = $('input[type="email"]');

		//Regular expression to verify macquarie email: name1=name2-nameX.surname1-surname2-surnameX@(mq.edu.au or students.mq.edu.au)
		var re = /^[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+(@mq.edu.au|@students.mq.edu.au)$/;
		if ( re.test($email.val()) ) {

			searchLoading.show();;

			e.preventDefault();
			$.ajax({
				url: "/mqauth/43413846/public/check-email",
				data: {email:$email.val()},
				dataType: "json",
			}).done(function(msg) {
				if ( msg.name != "" ) {
					if ( formHidden.hasClass('hidden') ) {
						formHidden.removeClass('hidden');
					}
					$('#name').find('span').text(msg.name);
					$('#mqid').find('strong').text(msg.type == 2 ? "Staff ID:" : "Student ID:" );
					$('#mqid').find('span').text(msg.oneid);
					$email.hide().after($('<p></p>').html($email.val()));
					$this.hide();
				} else {
					if ( ! msg.registered ) {
						$email.after('<p class="error">The e-mail you provided does not exist on our database. Please, check it and try again.</p>');
					} else {
						$email.after('<p class="error">You are registered already.</p>');
					}

					if ( ! formHidden.hasClass('hidden') ) {
						formHidden.addClass('hidden');
					}
				}
				searchLoading.hide();
			});

		} else {

			$email.after('<p class="error">Invalid e-mail.</p>');
			if ( ! formHidden.hasClass('hidden') ) {
				formHidden.addClass('hidden');
			}
		}
});



function clearSuburbList() {
	$('#suburb-list').find('li').remove();
	$('#suburb-list').hide();
}

$('#search-suburb button').on('click', function(e) {
	e.preventDefault();
	$loading = $('#search-suburb-loading').show();

	$suburbList = $('#suburb-list');
	$suburb = $('#search-suburb input');
	clearSuburbList();
	$suburbList.html('');
	$.ajax({
		url: "/mqauth/43413846/public/check-postcode",
		data: {q:$suburb.val()},
		dataType: "json",
	}).done(function(msg) {
		if ( msg.length > 0 ) {
			$.each(msg, function(index, value) {
				$suburbList.append($('<li></li>')
								.html($('<a></a>')
									.attr('href','#')
									.html(value.suburb+', '+value.state+', '+value.postcode+'</a>')
									.addClass('suburb-selector')));
			});
			bindSuburbSelector();
			$suburbList.show();
			$loading.hide();
		} else {
			$suburbList.append($('<li></li>').html('No suburb found.'));
		}
	});
});

$('#reset-address').on('click', function() {
	$('#search-suburb').show();
	$('#address').hide();
	$('input[name="suburb"').val("");
	$('input[name="state"').val("");
	$('input[name="postcode"').val("");
});

function bindSuburbSelector() {
	$('.suburb-selector').on('click', function(e) {
		e.preventDefault();
		$('#suburb-error').remove();
		clearSuburbList();

		$('#search-suburb').hide();
		$('#address').show();

		address = $(this).html().split(", ");

		$('#place-suburb span').text(address[0]);
		$('#place-state span').text(address[1]);
		$('#place-postcode span').text(address[2]);

		$('input[name="suburb"]').val(address[0]);
		$('input[name="state"]').val(address[1]);
		$('input[name="postcode"]').val(address[2]);
	});
}

$('#signup').on('click', function(e) {
	e.preventDefault();
	if ( validate() ) {
		$('#registration').submit();
	}
});

function validate(){ 
	validated = true;

	$('p.help-text.error').remove();

	$password = $('input[name="password"]');
	$confirmp = $('input[name="confirm_password"]');

	$postcode = $('input[name="postcode"]');
	$state = $('input[name="state"]');
	$suburb = $('input[name="suburb"]');
	$address = $('input[name="address"]');

	$ccnumber = $('input[name="cc-number"]');
	$ccholder = $('input[name="cc-holder"]');
	$ccmonth = $('input[name="cc-month"]');
	$ccyear = $('input[name="cc-year"]');
	$ccccv = $('input[name="cc-ccv"]');

	if ( ! $password.val() ) {
		validated = false;
		$password.after('<p class="help-text error">Password is required.</p>');
	}

	if ( $password.val() != $confirmp.val() ) {
		validated = false;
		$confirmp.after('<p class="help-text error">Password does not match.</p>');
	}

	if ( ! $postcode.val() || ! $state.val() || ! $suburb.val() ) {
		validated = false;
		$address.after('<p id="suburb-error" class="help-text error">You have not chosen your suburb.</p>');
	}

	if ( ! $address.val() ) {
		validated = false;
		$address.after('<p class="help-text error">Address is required.</p>');
	}

	if ( ! $ccnumber.val() ) {
		validated = false;
		$ccnumber.after('<p class="help-text error">Card number is required.</p>');
	} else {
		if ( $ccnumber.val().toString().length != 10 ) {
			validated = false;
			$ccnumber.after('<p class="help-text error">Card number must have 10 digits.</p>');
		}
	}

	if ( ! $ccholder.val() ) {
		validated = false;
		$ccholder.after('<p class="help-text error">Card holder is required.</p>');
	}

	if ( ! $ccccv.val() ) {
		validated = false;
		$ccccv.after('<p class="help-text error">CCV is required.</p>');
	}

	if ( ! $ccmonth.val() || ! $ccyear.val() ) {
		validated = false;
		$ccyear.after('<p class="help-text error">Expiry date is required.</p>');
	} else {

		if ( $ccmonth.val() > 12 || $ccmonth.val() < 0 ) {
			validated = false;
			$ccyear.after('<p class="help-text error">Invalid month.</p>');
		}


		currentYear = new Date().getFullYear().toString().substr(2,2);
		currentMonth = new Date().getMonth();
		if ( $ccyear.val() < currentYear || ( currentYear == $ccyear.val() && currentMonth > $ccmonth.val() ) ) {
			validated = false;
			$ccyear.after('<p class="help-text error">Invalid expiry date.</p>');
		}
	}

	return validated;
}
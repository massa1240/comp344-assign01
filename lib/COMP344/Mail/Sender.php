<?php

namespace COMP344\Mail;

class Sender {

	public static function sendEmail($emailTo, $emailFrom, $subject, $message) {
		@mail($emailTo, $subject, $message, 'From: <' . $emailFrom . '>');
	}

	private function __construct() {

	}
}
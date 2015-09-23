<?php

namespace COMP344\Entities;

/**
 * @Entity
 */
class MQStudent extends Customer {

	/**
	 * @Column(type="integer",name="mq_studentid")
	 */
	private $MQStudentID;

	public function getOneId() {
		return $this->MQStudentID;
	}

}
<?php

namespace COMP344\Entities;

/**
 * @Entity
 */
class MQStaff extends Customer {

	/**
	 * @Column(type="integer",name="mq_staffid")
	 */
	private $MQStaffID;

	public function getOneId() {
		return $this->MQStaffID;
	}

}
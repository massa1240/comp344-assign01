<?php

namespace COMP344\Entities;

/**
 * @Entity
 * @Table(name="postcode")
 */
class PostCode {


    /**
     * @Id
     * @Column(type="integer")
     **/
    private $postcode;

    /**
     * @ManyToOne(targetEntity="COMP344\Entities\State",cascade={"persist"})
     * @JoinColumn(name="state_acronym", referencedColumnName="acronym")
     **/
    private $state;
	
	public function __construct($postcode, State $state) {
        $this->postcode = $postcode;
        $this->state = $state;
    }
}
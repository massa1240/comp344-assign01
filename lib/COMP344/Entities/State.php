<?php

namespace COMP344\Entities;

/**
 * @Entity
 * @Table(name="state")
 */
class State {


    /**
     * @Id
     * @Column(type="string")
     **/
    private $acronym;

    /**
     * @Column(type="string")
     **/
    private $name;

    public function getAcronym() {
        return $this->acronym;
    }

    public function getName() {
        return $this->name;
    }
}
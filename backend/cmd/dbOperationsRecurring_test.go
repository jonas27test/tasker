package main

import (
	"log"
	"testing"
)

func Test_SetRecurringPleasure(t *testing.T) {
	log.SetFlags(log.Lshortfile)
	list := []Recurring{{Mon: true, Name: "test"}}
	coll := Collection{Coll: dbConn(t, "test")}
	coll.setRecurringPleasure(list)

	r := coll.getRecurrings()
	if len(r.RecurringPleasure) == 0 || r.RecurringPleasure[0].Name != "test" {
		t.Fatal()
	}

	cleanup(coll.Coll)
}

func Test_SetRecurringPurpose(t *testing.T) {
	log.SetFlags(log.Lshortfile)
	list := []Recurring{{Mon: true, Name: "test"}}
	coll := Collection{Coll: dbConn(t, "test")}
	coll.setRecurringPurpose(list)

	r := coll.getRecurrings()
	if len(r.RecurringPurpose) == 0 || r.RecurringPurpose[0].Name != "test" {
		t.Fatal()
	}

	cleanup(coll.Coll)
}

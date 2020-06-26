package controller

import (
	"log"
	"net/http"

	"github.com/jonas27test/jwt-backend/cmd/db"
)

type Controller struct {
	DB     db.DB
	Secret string
}

func ifPanic(err error) {
	if err != nil {
		log.Panicln(err)
	}
}

func enableCors(w *http.ResponseWriter) {
	(*w).Header().Set("Access-Control-Allow-Origin", "*")
	(*w).Header().Set("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE")
	(*w).Header().Set("Access-Control-Allow-Headers", "Accept, Content-Type, Content-Length, Accept-Encoding, X-CSRF-Token, Authorization")
}

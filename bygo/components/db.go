package components

import (
	"database/sql"
	"fmt"
)

// Database info
const (
	user     = "postgres"
	password = "mytodo"
	dbname   = "mytodo"
	host     = "db-postgresql"
	port     = 5432
)

// Use global Instance
var DB *sql.DB

// Connect to postgresql
func DBConnect() error {
	var err error
	dbinfo := fmt.Sprintf("user=%s password=%s dbname=%s host=%s port=%d sslmode=disable", user, password, dbname, host, port)
	if DB, err = sql.Open("postgres", dbinfo); err != nil {
		return err
	}
	if err = DB.Ping(); err != nil {
		return err
	}
	return nil
}

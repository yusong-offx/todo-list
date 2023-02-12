package main

import (
	"log"

	"github.com/gofiber/fiber/v2"
	"github.com/yusong-offx/todo-list/components"
	"github.com/yusong-offx/todo-list/route"
)

func main() {
	// DB connect
	if err := components.DBConnect(); err != nil {
		log.Fatal(err)
	}

	// Server init
	app := fiber.New(fiber.Config{
		Prefork: true,
	})

	route.AllMiddleWare(app)
	route.AllGet(app)
	route.AllPost(app)
	route.AllDelete(app)
	route.AllPut(app)

	log.Fatal(app.Listen(":3000"))
}

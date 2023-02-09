package main

import (
	"log"

	"github.com/gofiber/fiber/v2"
	"github.com/yusong-offx/todo-list/route"
)

func main() {
	app := fiber.New()

	app.Get("/", func(c *fiber.Ctx) error {
		return c.SendString("start")
	})
	route.AllMiddleWare(app)
	route.AllPost(app)

	log.Fatal(app.Listen(":3000"))
}

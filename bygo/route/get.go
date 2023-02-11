package route

import (
	"fmt"

	"github.com/gofiber/fiber/v2"
)

func AllGet(app *fiber.App) {
	app.Get("/", func(c *fiber.Ctx) error {
		fmt.Println("check")
		return c.SendString("start")
	})

}

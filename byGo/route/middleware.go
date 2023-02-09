package route

import (
	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/recover"
)

func AllMiddleWare(app *fiber.App) {
	app.Use(recover.New())
}

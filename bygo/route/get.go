package route

import (
	"github.com/gofiber/fiber/v2"
	"github.com/yusong-offx/todo-list/components"
)

func AllGet(app *fiber.App) {
	app.Get("/todo/user/:id", components.ProtectByJWT(), components.GetTodoByUserID)
}

package route

import (
	"github.com/gofiber/fiber/v2"
	"github.com/yusong-offx/todo-list/components"
)

func AllPut(app *fiber.App) {
	app.Put("/todo", components.ProtectByJWT(), components.PutTodoByID)
}

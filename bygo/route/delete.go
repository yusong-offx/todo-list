package route

import (
	"github.com/gofiber/fiber/v2"
	"github.com/yusong-offx/todo-list/components"
)

func AllDelete(app *fiber.App) {
	app.Delete("/todo/:id", components.ProtectByJWT(), components.DeleteTodoByID)
}

package route

import (
	"github.com/gofiber/fiber/v2"
	"github.com/yusong-offx/todo-list/components"
)

func AllPost(app *fiber.App) {
	app.Post("/login", components.PostLoginFunc)
	app.Post("/signup", components.PostSignUp)
	app.Post("/todo", components.ProtectByJWT(), components.PostTodo)
}

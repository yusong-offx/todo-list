package components

import (
	"time"

	"github.com/gofiber/fiber/v2"
	jwtware "github.com/gofiber/jwt/v3"
	"github.com/golang-jwt/jwt/v4"
)

var (
	JWT_SCRETE_KEY = []byte("Hello-World:)")
	VALID_DURATION = time.Duration(time.Minute * 15)
)

// Protected protect routes
func ProtectByJWT() fiber.Handler {
	return jwtware.New(jwtware.Config{
		SigningKey:   JWT_SCRETE_KEY,
		ErrorHandler: jwtError,
	})
}

func jwtError(c *fiber.Ctx, err error) error {
	if err.Error() == "Missing or malformed JWT" {
		return c.SendStatus(fiber.StatusBadRequest)
	}
	return c.SendStatus(fiber.StatusUnauthorized)
}

func GenerateJWT(userClaim jwt.MapClaims) (string, error) {
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, userClaim)
	tokenString, err := token.SignedString(JWT_SCRETE_KEY)
	if err != nil {
		return "", err
	}
	return tokenString, nil
}

// Compare request_user_id and jwt_user_id
func UserCheck(c *fiber.Ctx, bodyID int) bool {
	// Get jwt token from context
	token := c.Locals("user").(*jwt.Token)
	// Get claims from jwt token
	claims := token.Claims.(jwt.MapClaims)
	jwtID := int(claims["user_id"].(float64))
	return jwtID == bodyID
}

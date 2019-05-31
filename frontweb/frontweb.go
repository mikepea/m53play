package frontweb

import (
  "fmt"
        "net/http"
        "github.com/gin-gonic/gin"
)

const defaultPort = 8080

func setupRouter() *gin.Engine {
  r := gin.Default()

  r.GET("/ping", func (c *gin.Context) {
    c.String(http.StatusOK, "pong")
  })

  return r

}

func StartServer() {
  var port = defaultPort
  r := setupRouter()
  r.Run(fmt.Sprintf(":%d", port))
}

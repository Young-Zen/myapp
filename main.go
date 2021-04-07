package main

import (
    "fmt"
    "net/http"
    "os"
    "time"
)

func main()  {
    http.HandleFunc("/", HelloWorldHandler)
    err := http.ListenAndServe("0.0.0.0:80", nil)
    if err != nil {
        fmt.Println("服务器错误")
    }
}


func HelloWorldHandler(res http.ResponseWriter, req *http.Request)  {
    fmt.Printf("[%s] %s %s\n", time.Now().Format("2006-01-02 15:04:05"), req.Method, req.URL)
    hostname, _ := os.Hostname()
    fmt.Fprintf(res, "Version: v1, Hostname: %s\n", hostname)
}

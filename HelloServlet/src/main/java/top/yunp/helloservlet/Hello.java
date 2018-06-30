package top.yunp.helloservlet;

import java.io.IOException;
import java.io.PrintWriter;

@javax.servlet.annotation.WebServlet(name = "Hello", urlPatterns = "/hello")
public class Hello extends javax.servlet.http.HttpServlet {

    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        PrintWriter writer = response.getWriter();
//        writer.append("<html><head><title>Hello Servlet</title></head><body>This is a servlet</body></html>");
        writer.append("Hello World");
    }
}

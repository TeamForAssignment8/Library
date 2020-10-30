import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        HttpSession session = request.getSession(true);
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        int i = DB.getInstance().loginStudent(name,password);
        if(i == 1) {
            session.setAttribute("name",name);
            int index = DB.getInstance().getId(name,password);
            session.setAttribute("id",index);
            session.setAttribute("type","student");
            response.getWriter().write("True");
        }
        if(i == 2) {
            session.setAttribute("name",name);
            session.setAttribute("type","admin");
            response.getWriter().write("True");
        }
    }
}
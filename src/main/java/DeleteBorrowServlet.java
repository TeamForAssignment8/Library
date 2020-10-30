import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteBorrowServlet")
public class DeleteBorrowServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        String isbn = request.getParameter("isbn");
        int id = Integer.parseInt(request.getParameter("id"));

        int i = DB.getInstance().deleteBorrow(isbn, id);
        if(i == 1) {
            response.getWriter().write("True");
        }
    }
}

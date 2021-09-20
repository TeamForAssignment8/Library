import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/BorrowBookServlet")
public class BorrowBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        String isbn = request.getParameter("isbn");
        int id = Integer.parseInt(request.getParameter("id"));
        int copies = Integer.parseInt(request.getParameter("copies"));

        if(DB.getInstance().checkBorrow(isbn, id) == 0) {
            copies--;
            if (copies>=0) {
                int i = DB.getInstance().insertBorrowBook(isbn, id, copies);
                if(i == 1) {
                    response.getWriter().write("True");
                }
            }
        }
    }
}
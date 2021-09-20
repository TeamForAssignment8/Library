import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;

public class DB {
    private static DB instance = new DB();

    public static DB getInstance() {
        return instance;
    }

    private DB() {}

    private Connection getConnection()
    {
        Context initialContext;
        Connection connection = null;
        try
        {
            initialContext = new InitialContext();
            Context envCtx = (Context)initialContext.lookup("java:comp/env");
            DataSource ds = (DataSource)envCtx.lookup("jdbc/testdb");
            connection = ds.getConnection();
        }
        catch (NamingException | SQLException e)
        {
            e.printStackTrace();
        }
        return connection;
    }

    public int getId(String name, String password) {
        String sql = "SELECT id FROM students WHERE name='"+name+"' and password='"+password+"'";
        try {
            Connection connection = getConnection();
            Statement s = connection.createStatement();
            ResultSet rs = s.executeQuery(sql);
            while(rs.next()) {
                return rs.getInt("id");
            }
            s.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public int loginStudent(String name, String password) {
        String sql = "SELECT * FROM students WHERE name='"+name+"' and password='"+password+"'";
        try {
            Connection connection = getConnection();
            Statement s = connection.createStatement();
            ResultSet rs = s.executeQuery(sql);
            while(rs.next()) {
                return 1;
            }
            sql = "SELECT * FROM librarian WHERE name='"+name+"' and password='"+password+"'";
            s = connection.createStatement();
            rs = s.executeQuery(sql);
            while(rs.next()) {
                return 2;
            }
            s.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int checkStudent(int id) {
        String sql = "select * from students where id="+id+"";
        try {
            Connection connection = getConnection();
            Statement s = connection.createStatement();
            ResultSet rs = s.executeQuery(sql);
            while(rs.next()) {
                return 1;
            }
            connection.close();
            s.close();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return 0;
    }

    public int checkBorrowStudent(int id) {
        String sql = "select * from borrow where id="+id+"";
        try {
            Connection connection = getConnection();
            Statement s = connection.createStatement();
            ResultSet rs = s.executeQuery(sql);
            while(rs.next()) {
                return 1;
            }
            connection.close();
            s.close();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return 0;
    }

    public int checkBook(String isbn) {
        String sql = "select * from books where isbn='"+isbn+"'";
        try {
            Connection connection = getConnection();
            Statement s = connection.createStatement();
            ResultSet rs = s.executeQuery(sql);
            while(rs.next()) {
                return 1;
            }
            connection.close();
            s.close();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return 0;
    }

    public int checkBorrow(String isbn, int id) {
        String sql = "select * from borrow where isbn='"+isbn+"' and id='"+id+"'";
        try {
            Connection connection = getConnection();
            Statement s = connection.createStatement();
            ResultSet rs = s.executeQuery(sql);
            while(rs.next()) {
                return 1;
            }
            connection.close();
            s.close();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return 0;
    }

    public int insertBorrowBook(String isbn, int id, int copies) {
        String sql = "insert into borrow(isbn, id) values(?, ?)";
        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, isbn);
            preparedStatement.setInt(2, id);
            if (preparedStatement.executeUpdate() > 0) {
                String upd = "update books set copies=? where isbn=?";
                PreparedStatement pst = connection.prepareStatement(upd);
                pst.setInt(1, copies);
                pst.setString(2, isbn);
                if (pst.executeUpdate() > 0) {
                    return 1;
                }
            }
            connection.close();
            preparedStatement.close();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return 0;
    }

    public int insertStudent(int id, String name, String password) {
        String sql = "insert into students(id, name, password) values(?, ?, ?)";
        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            preparedStatement.setString(2, name);
            preparedStatement.setString(3, password);
            if (preparedStatement.executeUpdate() > 0) {
                return 1;
            }
            connection.close();
            preparedStatement.close();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return 0;
    }

    public int updateStudent(int id, String name, String password) {
        String sql = "update students set name=?, password=? where id=?";
        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, password);
            preparedStatement.setInt(3, id);
            if (preparedStatement.executeUpdate() > 0) {
                return 1;
            }
            connection.close();
            preparedStatement.close();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return 0;
    }

    public int deleteStudent(int id) {
        String sql = "delete from students where id=?";
        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            if (preparedStatement.executeUpdate() > 0) {
                return 1;
            }
            connection.close();
            preparedStatement.close();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return 0;
    }



    public int insertBook(String isbn, String name, String author, int copies) {
        String sql = "insert into books(isbn, name, author, copies) values(?, ?, ?, ?)";
        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, isbn);
            preparedStatement.setString(2, name);
            preparedStatement.setString(3, author);
            preparedStatement.setInt(4, copies);
            if (preparedStatement.executeUpdate() > 0) {
                return 1;
            }
            connection.close();
            preparedStatement.close();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return 0;
    }

    public int updateBook(String isbn, String name, String author, int copies) {
        String sql = "update books set name=?, author=?, copies=? where isbn=?";
        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, author);
            preparedStatement.setInt(3, copies);
            preparedStatement.setString(4, isbn);
            if (preparedStatement.executeUpdate() > 0) {
                return 1;
            }
            connection.close();
            preparedStatement.close();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return 0;
    }

    public int deleteBook(String isbn) {
        String sql = "delete from books where isbn=?";
        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, isbn);
            if (preparedStatement.executeUpdate() > 0) {
                return 1;
            }
            connection.close();
            preparedStatement.close();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return 0;
    }

    public int deleteBorrow(String isbn, int id) {
        String sql = "delete from borrow where isbn=? and id=?";
        try {
            Connection connection = getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, isbn);
            preparedStatement.setInt(2,id);
            if (preparedStatement.executeUpdate() > 0) {
                return 1;
            }
            connection.close();
            preparedStatement.close();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return 0;
    }
}
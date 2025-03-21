/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Department;
import model.Employee;
import model.LeaveRequest;
import model.User;
import java.util.ArrayList;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author NITRO 5
 */
public class LeaveRequestDBContext extends DBContext<LeaveRequest> {

    @Override
    public ArrayList<LeaveRequest> list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public LeaveRequest get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void insert(LeaveRequest model) {
        try {
            String sql = "INSERT INTO [LeaveRequest]\n"
                    + "           ([title]\n"
                    + "           ,[reason]\n"
                    + "           ,[from]\n"
                    + "           ,[to]\n"
                    + "           ,[createdby]\n"
                    + "           ,[status]\n"
                    + "		   ,[createddate]\n"
                    + "		   )\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,0,GETDATE())";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, model.getTitle());
            stm.setString(2, model.getReason());
            stm.setDate(3, model.getFrom());
            stm.setDate(4, model.getTo());
            stm.setString(5, model.getCreatedby().getUsername());
            stm.executeUpdate();//update insert delete
        } catch (SQLException ex) {
            Logger.getLogger(LeaveRequestDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (connection != null)
                try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(LeaveRequestDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    public int count() {
        try {
            String sql = "SELECT COUNT(*) FROM LeaveRequest";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(LeaveRequestDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (connection != null)
                try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(LeaveRequestDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return -1;
    }

    public ArrayList<LeaveRequest> getByDept(Integer did) {
        ArrayList<LeaveRequest> requests = new ArrayList<>();
        try {
            String sql = "SELECT \n"
                    + "	r.rid,r.title,r.reason,r.[from],r.[to],u.username,u.displayname,\n"
                    + "	r.createddate,r.status,\n"
                    + "	d.did,d.dname,\n"
                    + "	e.eid,e.ename\n"
                    + "FROM LeaveRequest r INNER JOIN Users u ON u.username = r.createdby\n"
                    + "			INNER JOIN Employees e ON e.eid = u.eid\n"
                    + "			INNER JOIN Departments d ON d.did = e.did";

            if (did != null) {
                sql += " WHERE d.did = ? ";
            }
            PreparedStatement stm = connection.prepareStatement(sql);
            if (did != null) {
                stm.setInt(1, did);
            }

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                LeaveRequest r = new LeaveRequest();
                r.setId(rs.getInt("rid"));
                r.setTitle(rs.getString("title"));
                r.setReason(rs.getString("reason"));
                r.setFrom(rs.getDate("from"));
                r.setTo(rs.getDate("to"));
                r.setCreateddate(rs.getTimestamp("createddate"));
                r.setStatus(rs.getInt("status"));

                User u = new User();
                u.setUsername(rs.getString("username"));
                u.setDisplayname(rs.getString("displayname"));
                r.setCreatedby(u);

                Employee e = new Employee();
                u.setE(e);
                e.setId(rs.getInt("eid"));
                e.setName(rs.getString("ename"));

                Department d = new Department();
                e.setDept(d);
                d.setId(rs.getInt("did"));
                d.setName(rs.getString("dname"));

                requests.add(r);
            }

        } catch (SQLException ex) {
            Logger.getLogger(LeaveRequestDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (connection != null)
                try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(LeaveRequestDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return requests;
    }

    public ArrayList<LeaveRequest> getRequestsByManager(String managerUsername) {
        ArrayList<LeaveRequest> requests = new ArrayList<>();
        try {
            String sql = "SELECT r.rid, r.title, r.reason, r.[from], r.[to], u.username, u.displayname, r.createddate, r.status "
                    + "FROM LeaveRequest r "
                    + "JOIN Users u ON u.username = r.createdby "
                    + "JOIN Employees e ON e.eid = u.eid "
                    + "WHERE e.managerid = (SELECT eid FROM Users WHERE username = ?)";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, managerUsername);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                LeaveRequest r = new LeaveRequest();
                r.setId(rs.getInt("rid"));
                r.setTitle(rs.getString("title"));
                r.setReason(rs.getString("reason"));
                r.setFrom(rs.getDate("from"));
                r.setTo(rs.getDate("to"));
                r.setCreateddate(rs.getTimestamp("createddate"));
                r.setStatus(rs.getInt("status"));

                User u = new User();
                u.setUsername(rs.getString("username"));
                u.setDisplayname(rs.getString("displayname"));
                r.setCreatedby(u);

                requests.add(r);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return requests;
    }

    public void deleteRequest(int requestId) {
        try {
            String sql = "DELETE FROM LeaveRequest WHERE rid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, requestId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void updateStatus(int requestId, int status) {
        String sql = "UPDATE LeaveRequest SET status = ? WHERE rid = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, status);
            stm.setInt(2, requestId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public LeaveRequest getID(int id) {
        LeaveRequest request = null;
        try {
            String sql = "SELECT r.rid, r.title, r.reason, r.[from], r.[to], u.username, u.displayname, r.createddate, r.status "
                    + "FROM LeaveRequest r "
                    + "JOIN Users u ON u.username = r.createdby "
                    + "WHERE r.rid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                request = new LeaveRequest();
                request.setId(rs.getInt("rid"));
                request.setTitle(rs.getString("title"));
                request.setReason(rs.getString("reason"));
                request.setFrom(rs.getDate("from"));
                request.setTo(rs.getDate("to"));
                request.setCreateddate(rs.getTimestamp("createddate"));
                request.setStatus(rs.getInt("status"));

                User u = new User();
                u.setUsername(rs.getString("username"));
                u.setDisplayname(rs.getString("displayname"));
                request.setCreatedby(u);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return request;
    }

    @Override
    public void update(LeaveRequest model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(LeaveRequest model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}

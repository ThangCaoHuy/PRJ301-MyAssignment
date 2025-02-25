/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Feature;
import model.Role;
import model.User;

/**
 *
 * @author NITRO 5
 */
public class UserDBContext extends DBContext {

    public User getWithRoles(String username, String password) {
        String sql = "SELECT u.username,u.displayname,r.rid,r.rname\n"
                + ",f.fid,f.url\n"
                + "FROM Users u LEFT JOIN User_Role ur ON u.username = ur.username\n"
                + "LEFT JOIN [Roles] r ON r.rid = ur.rid\n"
                + "LEFT JOIN [Role_Feature] rf ON rf.rid = r.rid\n"
                + "LEFT JOIN Features f ON f.fid = rf.fid\n"
                + "WHERE u.username = ? AND u.[password] = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, password);
            ResultSet rs = stm.executeQuery();
            User user = null;
            Role c_role = new Role();
            c_role.setId(-1);
            while (rs.next()) {
                if (user == null) {
                    user = new User();
                    user.setUsername(username);
                    user.setDisplayname(rs.getNString("displayname"));
                }

                int rid = rs.getInt("rid");
                if (rid != 0) {
                    if (rid != c_role.getId()) {
                        c_role = new Role();
                        c_role.setId(rs.getInt("rid"));
                        c_role.setName(rs.getString("rname"));
                        user.getRoles().add(c_role);
                    }
                    if (rs.getInt("fid") != 0) {
                        Feature f = new Feature();
                        f.setId(rs.getInt("fid"));
                        f.setUrl(rs.getString("url"));
                        f.getRoles().add(c_role);
                        c_role.getFeatures().add(f);
                    }
                }

            }
            return user;
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (connection != null)
                try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }
}

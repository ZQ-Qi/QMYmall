package db;

import org.apache.commons.dbcp2.BasicDataSourceFactory;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
/*
 * DBCP连接池在构建时需要引入
 * commons-collections
 * commons-dbcp2
 * commons-logging
 * commons-pool2
 * mysql-connector
 * 共五个jar包，缺一不可*/


/**
 * 本模块构建了一个DBCP连接池
 * DBCP连接池配置位于config/dbcpconfig.properties中
 * 连接数据库qzqmall user:root password:admin useSSL:false charset:utf8
 */
public class DBCPUtils {
    private static DataSource ds;//定义一个连接池对象
    static{
        try {
            Properties pro = new Properties();
            pro.load(DBCPUtils.class.getClassLoader().getResourceAsStream("config/dbcpconfig.properties"));
            ds = BasicDataSourceFactory.createDataSource(pro);//得到一个连接池对象
        } catch (Exception e) {
            throw new ExceptionInInitializerError("初始化连接错误，请检查配置文件！");
        }
    }


    /**
     * 构造从连接池取出连接的方法
     * @return Connection
     * @throws SQLException
     */
    public static Connection getConnection() throws SQLException {
        return ds.getConnection();
    }

    /**
     * 关闭rs & stmt & conn
     * @param rs ResultSet
     * @param stmt Statement
     * @param conn Connection
     */
    public static void closeAll(ResultSet rs, Statement stmt, Connection conn){
        if(rs!=null){
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        if(stmt!=null){
            try {
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        if(conn!=null){
            try {
                conn.close();//关闭
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 测试类
     * @param args
     */
    public static void main(String[] args) {
        try {
            System.out.println("对DBCP池进行测试");
            Connection con = DBCPUtils.getConnection();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM user");
            System.out.println(rs.next());
            closeAll(rs,stmt,con);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
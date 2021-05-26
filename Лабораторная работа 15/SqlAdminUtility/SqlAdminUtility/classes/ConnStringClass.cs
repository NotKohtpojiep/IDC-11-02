using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlAdminUtility.classes
{
    public static class ConnStringClass
    {
        public static string  connStr { get; set; }
        public static string  dataSource { get; set; }
        public static string trustedConn { get; set; }
        public static string database { get; set; }
        public static string login { get; set; }
        public static string password { get; set; }
        public static string timeout { get; set; }
        public static string CreateConnString(bool isLocal,bool Trusted,string DataSource, string Database, string Login, string Password, string Timeout)
        {
            if(isLocal == true)
            {
                dataSource = "Data Source=(local);";
                if (Trusted == true)
                {
                    trustedConn = "Trusted_Connection=true;";
                }
                else
                {
                    trustedConn = "Trusted_Connection=false;";
                }
            }
            else
            {
                timeout = Timeout;
                dataSource = "" + DataSource + "";
                if (Trusted == true)
                {
                    trustedConn = "Trusted_Connection=true;";
                    login = "";
                    password = "";
                }
                else
                {
                    trustedConn = "Trusted_Connection=false;";
                    login = Login;
                    password = Password;
                }
            }

            if (string.IsNullOrEmpty(Database) == false)
                database = "database = " + Database;
            else
                database = "";
            connStr = $"{dataSource}{database}{trustedConn}{login}{password}";
            return connStr;
        }
    }
}

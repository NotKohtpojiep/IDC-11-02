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
            connStr = $"Data Source={DataSource}; Database={Database}; User Id={Login}; Password={Password};";
            return connStr;
        }
    }
}

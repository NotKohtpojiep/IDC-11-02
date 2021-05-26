using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlAdminUtility.classes
{
    public class MailServer
    {
        public MailServer(int accountId, string serverType, string serverName, int port, string username,
            int credentinalId, bool enableSsl)
        {
            AccountId = accountId;
            ServerType = serverType;
            ServerName = serverName;
            Port = port;
            Username = username;
            CredentinalId = credentinalId;
            EnableSsl = enableSsl;
        }
        public int AccountId { get; set; }
        public string ServerType { get; set; }
        public string ServerName { get; set; }
        public int Port { get; set; }
        public string Username { get; set; }
        public int CredentinalId { get; set; }
        public bool EnableSsl { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Data.SqlTypes;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlAdminUtility.classes
{
    public class HistoryClass
    {
        public string ServerName { get; private set; }
        public string DatabaseName { get; private set; }
        public DateTime BackupStartDate { get; private set; }
        public DateTime BackupEndDate { get; private set; }
        public string BackupType { get; private set; }
        public decimal BackupSize { get; private set; }
        public string DeviceName { get; private set; }
        public SqlString BackupName { get; private set; }

        public HistoryClass(string ServerName, string DatabaseName, DateTime BackupStartDate,
            DateTime BackupEndDate, string BackupType, decimal BackupSize, string DeviceName, SqlString BackupName)
        {
            this.ServerName = ServerName;
            this.DatabaseName = DatabaseName;
            this.BackupStartDate = BackupStartDate;
            this.BackupEndDate = BackupEndDate;
            this.BackupType = BackupType;
            this.BackupSize = BackupSize;
            this.DeviceName = DeviceName;
            this.BackupName = BackupName;
        }

    }
}

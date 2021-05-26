using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlAdminUtility.classes
{
    public class MailAccount
    {
        public MailAccount(int accountId, string name, string description, string emailAddress, string displayName,
            string replyToAddress)
        {
            AccountId = accountId;
            Name = name;
            Description = description;
            EmailAddress = emailAddress;
            DisplayName = displayName;
            ReplyToAddress = replyToAddress;
        } 

        public int AccountId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string EmailAddress { get; set; }
        public string DisplayName { get; set; }
        public string ReplyToAddress { get; set; }
    }
}

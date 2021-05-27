using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlAdminUtility.classes
{
    public class MailProfile
    {
        public MailProfile(int profileId, string name, string description)
        {
            ProfileId = profileId;
            Name = name;
            Description = description;
        }

        public int ProfileId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
    }
}

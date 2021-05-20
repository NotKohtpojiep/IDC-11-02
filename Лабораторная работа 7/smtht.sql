select * from pacient;
select * from reception;

grant select on polyclinic.doctor to doctor@localhost;
grant select, insert, update on polyclinic.reception to doctor@localhost;


show grants for doctor@localhost;
revoke usage for client@localhost;

insert into polyclinic.pacient values 
('1','Миньён','Йонович','Петрович','20.01.2001',1,null,null),
('2','Попс','Йонс','Альбертович','02.01.2001',1,null,null),
('3','Брон','Джорд','Петрович','10.01.2001',0,null,null),
('4','Виви','ГАч','ВуатИзГона','23.01.2001',0,null,null),
('5','Билли','Херрингтон','Бог','16.01.2001',1,null,null);


insert into polyclinic.reception values ('6','1','1','21.02.2020','Sticked finger','1000');


insert into polyclinic.reception values 
('1','1','1','20.02.2020','Sticked finger','1000'),
('2','4','2','19.02.2020','Oooooh yes sir','2500'), 
('3','3','3','21.02.2020','Sorry for what','100'),
('4','5','2','18.02.2020','My fellow brother','300'),
('5','3','1','19.02.2020','Oh, Im sorry','4000');

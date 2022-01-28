create database blog;
\c blog;

create table usuarios (
id serial,
email varchar(255),
nombre varchar(255),
primary key (id));

create table posts (
id serial,
usuario_id int not null,
titulo varchar(255) not null,
fecha date not null,
primary key (id),
foreign key (usuario_id) references usuarios (id));

create table comentarios (
id serial,
usuario_id int not null,
post_id int not null,
texto text not null,
fecha date not null,
primary key (id),
foreign key (post_id) references posts (id),
foreign key (usuario_id) references usuarios (id));

\copy usuarios from 'usuarios.csv' csv header;

\copy posts from 'posts.csv' csv header;

\copy comentarios from 'comentarios.csv' csv header;

select usuarios.email, posts.id, posts.titulo
from usuarios
join posts on usuarios.id = posts.usuario_id
where posts.usuario_id = 5;

select usuarios.email, comentarios.id, comentarios.texto, comentarios.fecha
from usuarios
join comentarios on usuarios.id = comentarios.usuario_id 
where usuarios.email <> 'usuario06@hotmail.com';

select usuarios.email
from usuarios
full outer join posts on usuarios.id = posts.usuario_id
where posts.usuario_id is null;

select posts.titulo, comentarios.texto
from posts
left join comentarios on posts.id = comentarios.post_id;

select usuarios.email, posts.fecha
from usuarios
join posts on usuarios.id = posts.usuario_id
where posts.fecha >= '2020-06-01' and posts.fecha <= '2020-06-30';

-- apply changes
create table rcs_skills (
  id                            varchar(40) not null,
  alias                         varchar(255),
  name                          varchar(255),
  type                          varchar(255),
  description                   varchar(255),
  money_cost                    double not null,
  skill_point_cost              integer not null,
  config                        clob,
  version                       integer not null,
  when_created                  timestamp not null,
  when_modified                 timestamp not null,
  constraint pk_rcs_skills primary key (id)
);

create table rcs_levels (
  id                            varchar(40) not null,
  level                         integer not null,
  total_exp                     integer not null,
  version                       integer not null,
  when_created                  timestamp not null,
  when_modified                 timestamp not null,
  constraint pk_rcs_levels primary key (id)
);

create table rcs_level_history (
  id                            varchar(40) not null,
  level_id                      varchar(40),
  old_level                     integer not null,
  new_level                     integer not null,
  old_exp                       integer not null,
  new_exp                       integer not null,
  data                          clob,
  version                       integer not null,
  when_created                  timestamp not null,
  when_modified                 timestamp not null,
  constraint pk_rcs_level_history primary key (id),
  foreign key (level_id) references rcs_levels (id) on delete restrict on update restrict
);

create table rcs_player_skills (
  id                            varchar(40) not null,
  player_id                     varchar(40),
  skill_id                      varchar(40),
  status                        varchar(8),
  version                       integer not null,
  when_created                  timestamp not null,
  when_modified                 timestamp not null,
  constraint ck_rcs_player_skills_status check ( status in ('ENABLED','DISABLED','ACTIVE','UNLOCKED','INACTIVE','REMOVED')),
  constraint pk_rcs_player_skills primary key (id),
  foreign key (player_id) references rcs_players (id) on delete restrict on update restrict,
  foreign key (skill_id) references rcs_skills (id) on delete restrict on update restrict
);

create table rcs_players (
  id                            varchar(40) not null,
  name                          varchar(255),
  skill_points                  integer not null,
  level_id                      varchar(40) not null,
  version                       integer not null,
  when_created                  timestamp not null,
  when_modified                 timestamp not null,
  constraint uq_rcs_players_level_id unique (level_id),
  constraint pk_rcs_players primary key (id),
  foreign key (level_id) references rcs_levels (id) on delete restrict on update restrict
);

create index ix_rcs_skills_alias on rcs_skills (alias);
create index ix_rcs_skills_name on rcs_skills (name);
create index ix_rcs_player_skills_player_id_skill_id on rcs_player_skills (player_id,skill_id);

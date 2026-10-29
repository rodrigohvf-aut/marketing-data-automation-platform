create table if not exists collection_runs (
  id bigserial primary key,
  source_name text not null,
  status text not null check (status in ('started', 'succeeded', 'failed')),
  started_at timestamptz not null default now(),
  finished_at timestamptz,
  records_processed integer not null default 0,
  error_category text
);

create index if not exists collection_runs_source_started_idx
  on collection_runs (source_name, started_at desc);

create table if not exists daily_channel_metrics (
  id bigserial primary key,
  channel_name text not null,
  metric_date date not null,
  impressions integer not null default 0,
  clicks integer not null default 0,
  conversions integer not null default 0,
  spend numeric(14, 2) not null default 0,
  unique (channel_name, metric_date)
);

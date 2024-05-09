DELETE from A
Where
  rowid not in (
    select
      max(rowid)
    from A
    group by B, C, D
  );

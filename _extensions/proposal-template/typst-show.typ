#show: doc => article(
$if(title)$
  title: [$title$],
$endif$
$if(date)$
  date: [$date$],
$endif$
$if(created-by)$
  created-by: [$created-by$],
$endif$
$if(created-by-company)$
  created-by-company: [$created-by-company$],
$endif$
$if(prepared-for)$
  prepared-for: [$prepared-for$],
$endif$
$if(prepared-for-company)$
  prepared-for-company: [$prepared-for-company$],
$endif$
  doc,
)

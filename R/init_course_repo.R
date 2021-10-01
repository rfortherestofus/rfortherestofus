#' Initialize a new course repository
#' You should set up the course_repo before in rfortherestofus organization
#'
#' @param repo_name Name of the new repo
#' @param instructor Github name of the instructor
#' @param sheet_path The path of the Sheets containing two sheets : Issues and Milestones. Must be public
#'
#' @return Issues and milestones written on Github
#' @export
#'
#' @import dplyr
#' @import tidyr
#'
#' @examples
#' \dontrun{
#' init_course_repo(repo_name = "course_test", instructor = "tvroylandt", course_release_date = "2021-12-23")
#' }
init_course_repo <- function(repo_name,
                             instructor,
                             sheet_path = "https://docs.google.com/spreadsheets/d/1iIX8pGBpyePUVI1iiy89e6pDqrNFa_RXZkRVuB4vjA0/") {
  # init the ref of the repo
  repo_ref <-
    projmgr::create_repo_ref(repo_owner = "rfortherestofus",
                             repo_name = repo_name)

  # import plan
  googlesheets4::gs4_deauth()

  df_course_issues <-
    googlesheets4::read_sheet(sheet_path, sheet = "Issues")
  df_course_milestones <-
    googlesheets4::read_sheet(sheet_path, sheet = "Milestones")

  # clean plan
  plan <- df_course_issues %>%
    left_join(df_course_milestones, by = "Milestone") %>%
    rename(title = Issue,
           assignees = `Assigned To`,
           due_on = `Due Date`) %>%
    mutate(
      assignees = case_when(
        assignees == "David" ~ "dgkeyes",
        assignees == "Instructor" ~ instructor
      ),
      due_on = paste0(as.character(due_on), "T00:00:00Z")
    ) %>%
    group_by(Milestone, due_on) %>%
    nest() %>%
    mutate(data = purrr::map(data, purrr::transpose)) %>%
    rename(issue = data) %>%
    ungroup() %>%
    rename(title = Milestone) %>%
    purrr::transpose()

  # post plan
  projmgr::post_plan(repo_ref, plan)
}

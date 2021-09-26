#' Initialize a new course repository
#' You should set up the course_repo before in rfortherestofus organization
#'
#' @param repo_name Name of the new repo
#' @param instructor Github name of the instructor
#'
#' @return Issues and milestones written on Github
#' @export
#'
#' @examples
#' \dontrun{
#' init_course_repo(repo_name = "course_test", instructor = "tvroylandt")
#' }
init_course_repo <- function(repo_name,
                             instructor) {
  # init the ref of the repo
  repo_ref <-
    projmgr::create_repo_ref(repo_owner = "rfortherestofus",
                             repo_name = repo_name)

  # milestones + issues
  milestone_pre_work <-
    list(title = "Pre-work",
         issue = list(
           list(
             title = "Confirm terms",
             assignees = c("dgkeyes", instructor)
           ),
           list(
             title = "Confirm timing",
             assignees = c("dgkeyes", instructor)
           ),
           list(
             title = "Confirm instructor has access to external microphone and camera",
             assignees = c("dgkeyes", instructor)
           ),
           list(
             title = "Sign contract",
             assignees = c("dgkeyes", instructor)
           ),
           list(title = "Pay advance",
                assignees = c("dgkeyes"))
         ))

  milestone_infrastructure <- list(title = "Set up infrastructure",
                                   issue = list(
                                     list(title = "Set up shared Google Drive folder",
                                          assignees = c("dgkeyes")),
                                     list(title = "Set up course outline spreadsheet",
                                          assignees = c(instructor))
                                   ))

  milestone_curriculum <- list(title = "Curriculum Development",
                               issue = list(
                                 list(title = "Develop course outline",
                                      assignees = c(instructor)),
                                 list(title = "Confirm course outline",
                                      assignees = c("dgkeyes")),
                                 list(title = "Develop course slides",
                                      assignees = c(instructor)),
                                 list(title = "Review course slides",
                                      assignees = c("dgkeyes"))
                               ))

  milestone_recording <- list(title = "Recording",
                              issue = list(
                                list(title = "Record sample lesson video",
                                     assignees = c(instructor)),
                                list(title = "Review sample lesson video",
                                     assignees = c("dgkeyes")),
                                list(title = "Record remaining videos	Recording",
                                     assignees = c(instructor)),
                                list(title = "Upload videos to shared Google Drive folder",
                                     assignees = c(instructor))
                              ))

  milestone_video <- list(title = "Video editing",
                          issue = list(
                            list(title = "Edit videos",
                                 assignees = c("dgkeyes")),
                            # should change it to Rachel account
                            list(title = "Review edited videos",
                                 assignees = c("dgkeyes"))
                          ))

  milestone_marketing <- list(
    title = "Marketing",
    issue = list(
      list(title = "Develop course landing page",
           assignees = c("dgkeyes")),
      list(title = "Develop series of launch emails",
           assignees = c("dgkeyes")),
      list(title = "Develop series of launch tweets",
           assignees = c("dgkeyes")),
      list(title = "Add lessons to course on website",
           assignees = c("dgkeyes")),
      list(title = "Add videos to lessons on course website",
           assignees = c("dgkeyes")),
      list(
        title = "Add additional material to lessons (learn more etc)",
        assignees = c(instructor, "dgkeyes")
      ),
      list(
        title = "Review all material on website",
        assignees = c(instructor, "dgkeyes")
      )
    ),
    list(title = "Course release! (email + tweet thread)",
         assignees = c("dgkeyes"))
  )


  # create plan
  plan <- list(
    milestone_pre_work,
    milestone_infrastructure,
    milestone_curriculum,
    milestone_recording,
    milestone_video,
    milestone_marketing
  )

  # post plan
  projmgr::post_plan(repo_ref, plan)
}
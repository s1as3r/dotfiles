--- @type { dell: HL.MonitorSpec, laptop: HL.MonitorSpec }
return {
  dell = {
    output = "desc:Dell",
    mode = "highres",
    position = "auto",
    scale = 1.00
  },

  laptop = {
    output = "desc:BOE",
    mode = "preferred",
    position = "auto",
    scale = 1.25
  }
}

module HomeHelper
  CHIP_POSITIONS = [
    [  "5%", "12%" ], [ "88%",  "8%" ], [ "72%", "72%" ], [ "18%", "82%" ],
    [ "92%", "38%" ], [  "3%", "55%" ], [ "55%", "88%" ], [ "80%", "22%" ],
    [ "40%",  "5%" ], [ "65%", "55%" ], [ "25%", "35%" ], [ "10%", "68%" ],
    [ "48%", "78%" ], [ "82%", "88%" ], [ "32%", "18%" ], [ "92%", "62%" ],
    [ "58%", "15%" ], [ "15%", "45%" ], [ "70%", "40%" ], [ "45%", "92%" ]
  ].freeze

  def chip_positions
    CHIP_POSITIONS
  end

  def chip_style(cx, cy, color)
    "--cx:#{cx};--cy:#{cy};--chip-c:#{color}"
  end

  def primary_skills
    Skill.find(ExperienceSkill.where(primary: true).pluck(:skill_id)).pluck(:name)
  end# encoding:d
end

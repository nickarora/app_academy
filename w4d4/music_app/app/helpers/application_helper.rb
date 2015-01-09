module ApplicationHelper
	def ugly_lyrics(lyrics)
		lines = h(lines)
		lines = lyrics.split("\n")
		lines.map! { |l| "♫ " + l }
		lines.join("<br>").html_safe
	end
end

from moviepy.editor import *
import pandas as pd

survive_dat=pd.read_csv('survive_frames.tsv',sep='\t',header=0)
fotr_movie=VideoFileClip("/Users/bollo/Documents/Kari/Forritun/fotr_movie.mp4") 
ttt_movie=VideoFileClip("/Users/bollo/Documents/Kari/Forritun/ttt_movie.mp4")
rotk_movie=VideoFileClip("/Users/bollo/Documents/Kari/Forritun/rotk_movie.mp4")  

out_clip = ttt_movie.subclip(0,1)
current_clip=0
for i in range(survive_dat.shape[0]):
    if survive_dat['movie'][i] == 'fotr_subtitles.srt':
        current_clip =fotr_movie.subclip(survive_dat["startTime"][i], survive_dat["endTime"][i])
    elif survive_dat['movie'][i] == 'ttt_subtitles.srt':
            current_clip = ttt_movie.subclip(survive_dat["startTime"][i], survive_dat["endTime"][i])
    elif survive_dat['movie'][i] == 'rotk_subtitles.srt':
        current_clip = rotk_movie.subclip(survive_dat["startTime"][i], survive_dat["endTime"][i])
    out_clip = concatenate_videoclips([out_clip, current_clip], method='compose')

out_clip.write_videofile("survive_edited_firstten1.mp4", codec='libx264', audio_codec="aac")
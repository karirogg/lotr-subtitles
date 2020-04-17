from moviepy.editor import *
import pandas as pd

survive_dat=pd.read_csv('LOTR_subtitles/survive_frames.tsv',sep='\t',header=0)
fotr_movie=VideoFileClip("fotr_movie.mp4") 
ttt_movie=VideoFileClip("ttt_movie.mp4")
rotk_movie=VideoFileClip("rotk_movie.mp4")  

out_clip = ttt_movie.subclip(0,1)
current_clip=0
for i in range(survive_dat.shape[0]-170):
    current_clip =fotr_movie.subclip(survive_dat["startTime"][i], survive_dat["endTime"][i])
    
    out_clip = concatenate_videoclips([out_clip, current_clip])

out_clip.write_videofile("survive_edited_rawcut{}.mp4".format(count), codec='libx264', audio_codec="aac")
count = count +1
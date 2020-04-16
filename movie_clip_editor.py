from moviepy.editor import *
import pandas as pd

matching_dat=pd.read_csv('survive_frames.tsv',sep='\t',header=0)
survive_matchin_dat=matching_dat[matching_dat['songname']=='survive.lrc'][matching_dat['nword']<=176]

survive_dat=pd.read_csv('survive_frames.tsv',sep='\t',header=0)
ttt_movie=VideoFileClip("/Users/bollo/Documents/Kari/Forritun/ttt_movie.mp4") 
fotr_movie = 0
rotk_movie = 0

out_clip = ttt_movie.subclip(0,1)
for i in range(survive_dat.shape[0]):
    movie = ttt_movie
    if survive_dat['movie'][i] == 'fotr2.srt':
        movie = fotr_movie
    elif survive_dat['movie'][i] == 'ttt2.srt':
        movie = ttt_movie
    elif survive_dat['movie'][i] == 'rotk2.srt':
        movie = rotk_movie
    current_clip = movie.subclip(survive_dat["startTime"][i], survive_dat["endTime"][i])
    out_clip = concatenate_videoclips([out_clip, current_clip])

out_clip.write_videofile("survive_edited_full1.mp4", codec='libx264')

from moviepy.editor import *
import pandas as pd

matching_dat=pd.read_csv('matches.tsv',sep='\t',header=0)
survive_matchin_dat=matching_dat[matching_dat['songname']=='survive.lrc'][matching_dat['nword']<=176]
ttt_movie=VideoFileClip("/Users/solviro/Downloads/ttt_movie.mp4")

count=0
tmp_time_stamp=
tmp_images=[]
for timestamp, raw_img in ttt_movie.iter_frames(with_times=True):
    count=count+1
    if count>2900 and count<=3000:
        tmp_images.append(ImageClip(raw_img).set_duration(1.0/24))
    elif count>3000:
        break
concat_clip = concatenate_videoclips(tmp_images, method="compose")
concat_clip.write_videofile("test.mp4", fps=24)

times=[seq(ts1start,ts1end,by=1.0/24),seq(ts2start,ts2end),...,seq(ts2start,ts2end)]
out_video=[]
out_audio=[]
for(t in times):
    out_video.append(ImageClip(ttt_movie.get_frame(t)).set_duration(1.0/24))

for(t in times):
    out_audio.append(AudioClip(ttt_movie.audio.get_frame(t)).set_duration(1.0/24))

concat_clip = concatenate_videoclips(out_video, method="compose")
concat_clip.write_videofile("survive_edited.mp4", fps=24)

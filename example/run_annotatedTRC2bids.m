% Example 
addpath('../trc2bids/')
addpath('../micromed_utils/')
addpath('../external/')

fieldtrip_folder  = '/home/eline/Documents/Git/Utils/fieldtrip/';
fieldtrip_private = '/home/eline/Documents/Git/Utils/fieldtrip/fieldtrip_private/';
jsonlab_folder    = '/home/eline/Documents/Git/Utils/jsonlab/';
addpath(fieldtrip_folder) 
addpath(fieldtrip_private)
addpath(jsonlab_folder)



cfg          = [];
cfg.proj_dir = '/home/eline/Documents/Data/aECoG_temp/';            % folder to store bids files
cfg.filename = '/home/eline/Documents/Data/aECoG_temp/example1.TRC'; % TRC file


[status,msg,output] = annotatedTRC2bids(cfg)
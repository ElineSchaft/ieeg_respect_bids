%% anonymize the TRC file and fill in the RESPect number
% author Dorien van Blooijs
% date: 24-1-2019
% Edited Paul Smits
% Edited Eline Schaft
% August 2020

clc

% respect-folder on bulkstorage
% or other scratch folder
cfg.proj_dirinput = '~/RESPsand/RESPect_scratch/Archive Micromed/PAT_19/';

%% Check input and direction
% Check if files need to be copied and if so, make copy direction
if cfg.proj_dirinput(end) ==filesep; else cfg.proj_dirinput=[cfg.proj_dirinput filesep]; end

files = dir(cfg.proj_dirinput);

cfg.copymethod = contains(files(1).folder,'smb'); % true if samba share
if cfg.copymethod
    cfg.tempdir='~/matlab_temp/'; 
    fprintf('NB: samba share detected, editing in local copy (%s)\n',cfg.tempdir);
    if ~exist(cfg.tempdir,'dir')
        warning('creating temp matlab_temp directory at %s', cfg.tempdir); mkdir(cfg.tempdir);
    end
end

%% Give in RESPect name 
tempName = input('Respect name (e.g. [RESP0733]): ','s');

if strcmp(tempName,'') && ~isempty(respName)
    
elseif contains(tempName,'RESP')
    respName = tempName;
else
    error('Respect name is not correct')
end

%% Anonymize EEG files

for i=1:size(files,1)
    if contains(files(i).name,'EEG_')
        filename = files(i).name;
        pathname = cfg.proj_dirinput;
        fileName = [pathname, filename];
        % create local copy if necessary
        if cfg.copymethod
            assert(copyfile(fileName,cfg.tempdir),'Could not copy file to local directory %s', cfg.tempdir)
            fileName = [cfg.tempdir, filename];
        end
        
        % anonymize the TRC file    
        fprintf('Anonymising: %s\n',filename);
        [status,msg] = anonymized_asRecorded(fileName,respName)
        
        % overwrite and clear temp directory
        if cfg.copymethod && ~status
            assert(copyfile(fileName,pathname),'Could not copy file to remote directory %s',pathname);
            delete(fileName);
        end
    end
end
fprintf('Anonymised files in: %s\n\n',cfg.proj_dirinput);

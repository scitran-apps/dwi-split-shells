function [] = dwisplitshells(bvecPath, bvalPath, dwiPath, ...
                             doNorm, ...
                             outputPath)
if ~exist(doNorm)
    doNorm = 1;
end
if ~exist(outputPath)
    outputPath = fileparts(dwiPath);
end

% Local data for testing
%{
    bvecPath = 'local/testdata/bvec/101915_dwi.bvec';
    bvalPath = 'local/testdata/bval/101915_dwi.bval';
    dwiPath  = 'local/testdata/dwi/101915_dwi.nii.gz';
%}

% Read the files according the provided path
bvecs = dlmread(bvecPath);
bvals = dlmread(bvalPath); 
dwi   = nii_tool('load', dwiPath);

% Obtain the fileparts
[~ ,bvecFileName,bvecFileExt] = fileparts(bvecPath);
[~ ,bvalFileName,bvalFileExt] = fileparts(bvalPath);
[~ ,dwiFileName ,dwiFileExt]  = fileparts(dwiPath);
if strcmp(dwiFileExt,'.gz')
    tmp         = split(dwiFileName,'.');
    dwiFileName = tmp{1};
    dwiFileExt  = ['.' tmp{2} dwiFileExt];
end

% Determine shell
roundedBval  = 100 * round(bvals/100);
paramsShells = unique(roundedBval);
if 0 == min(paramsShells)
    paramsShells = paramsShells(paramsShells ~= 0);
else
    error('It seems that this file have no b0. Check it please.')
end


for ii = 1:length(paramsShells)
    % Obtain the index to the shell we want
    index  = (roundedBval == paramsShells(ii));
    index0 = (roundedBval == 0);
    all_index = or(index, index0);
    if ~isequal(sum(all_index), sum(index0) + sum(index))
        error('The sum of the b0 and bvalue indexes do not coincide.')
    end
    
    % Create the names for the new files
    bvalName = fullfile(outputPath, ...
                        [bvalFileName '_' num2str(paramsShells(ii)) bvalFileExt]);
    bvecName = fullfile(outputPath, ...
                        [bvecFileName '_' num2str(paramsShells(ii)) bvecFileExt]);
    dwiName  = fullfile(outputPath, ...
                        [dwiFileName '_' num2str(paramsShells(ii)) dwiFileExt]);

    % Write the files back
    % Maintain the bValues or normalize depending on the doNorm parameter
    % By default it will normalize since vistasoft needs it normalized
    if doNorm
        dlmwrite(bvalName, roundedBval(all_index), 'delimiter',' ');
    else
        dlmwrite(bvalName,       bvals(all_index), 'delimiter',' ');
    end
    dlmwrite(bvecName, bvecs(:,all_index)     );
    dwi_oneshell = dwi;
    
    dwi_oneshell.hdr.file_name = dwiName;
    dwi_oneshell.img = dwi.img(:,:,:,all_index);
    dwi_oneshell.hdr.dim(5) = size(dwi_oneshell.img,4);
    nii_tool('save', dwi_oneshell, dwiName);
end

% For future reference, compiled used the following command:
% mcc -m dwisplitshells.m


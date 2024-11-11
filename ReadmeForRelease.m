%[text] # Create README.md for module release
%[text] 
%[text] This function can be used to export the README.mlx as defined in module\-template to a README.md formatted for release.
% Note: This script assumes it is running on a Windows system
% If you are not, you will need to update the system command call to fc
% to whatever the local diff tool is for binary files.
%[text] ```matlabCodeExample
%[text] ReadmeForRelease(repository="Vector-Arithmetic",version="2020a",fileexchange="94555-vector-arithmetic")
%[text] ```
function ReadmeForRelease(opts)
arguments
    opts.repository (1,1) string = "REPO_NAME"
    opts.version (1,1) string = ""
    opts.fileexchange (1,1) string = "XXXXX-PROJECTNAME"
    opts.organization (1,1) string = "MathWorks-Teaching-Resources"
    opts.KnownImages (1,1) logical = false
end

% Try load project
try
    proj = currentProject;
catch
    warning("Load project before to run this tool")
    return;
end

try
    Project = dir(fullfile(currentProject().RootFolder,"*.prj")).name;
catch
    Project = "PROJECTNAME.prj";
end

% Go the the project folder
cwd = pwd;
cd(proj.RootFolder);

% Create the new README
export("README.mlx","README.md",EmbedImage=false,AcceptHTML=true,RenderLaTeXOnline="off");

% Fix Hyperlink on image
FixHyperlinkOnImage(opts.organization,opts.repository,Project)

% Move image around
HandleImages(opts.KnownImages)

% Add badges and version
AddVersionInfo(opts.version,opts.organization,opts.repository,opts.fileexchange);

% Change Link to Existing file to Open in MATLAB Online
if opts.repository ~= "REPO_NAME"
    ChangeLocalLink(opts.organization,opts.repository);
    ChangeLicenseLink(opts.organization,opts.repository);
    UpdateOpenProjectLink(opts.organization,opts.repository);
end

% Check if links have not been updated!
ScanForMissedPlaceholders

% Go back to original location
cd(cwd)

end
%%
function out = CheckForNamedImages(NamedImages,img)
out = img;
for k = 1:length(NamedImages)
    [~, result] = system("fc " + fullfile("Images",img) + " " +  fullfile("Images",NamedImages(k).name));
    if contains(result,"FC: no differences encountered")
        out = NamedImages(k);
        break
    end
end
end

function [NamedImages,UnNamedImages] = FindNamedImages(ImagePath)
files = dir(fullfile(ImagePath,"*.??*"));
pat = "image_" + digitsPattern(1);
idxUnNamed = false([length(files) 1]);
for k = 1:length(files)
    idxUnNamed(k) = contains(files(k).name,pat);
end
NamedImages = files(~idxUnNamed);
UnNamedImages = files(idxUnNamed);
end

function FixHyperlinkOnImage(org,repo,Project)
file = string(fileread("README.md"));
% Pattern = "\href{" + wildcardPattern + "}{<img" + wildcardPattern + ">}";
Pattern3 = "\href"+wildcardPattern+"[<img" + wildcardPattern + "](" + wildcardPattern + ")";
HyperlinkImg = extract(file,Pattern3);
for i = 1:length(HyperlinkImg)
    OriginalString = HyperlinkImg(i);
    ImgPattern = "[<img src="+wildcardPattern+">]";
    LinkPattern = "("+wildcardPattern+")";
    FEXURL = "https://www.mathworks.com/matlabcentral/fileexchange/";
    OpenInURL = "https://matlab.mathworks.com/open/github/v1?repo=";
    % StartURL = extractBetween(OriginalString,"\href{","[<img src=");
    EndURL = extract(OriginalString,LinkPattern);
    EndURL = extractBetween(EndURL,"(",")");
    % URL = replace(extract(OriginalString,Pattern),"}","");
    EndURL = replace(EndURL," | ","&");
    % if isempty(URL)
    %     Snippet = extract(OriginalString,PatternLocal);
    %     Script = extractBetween(Snippet,"\href{./Scripts/","}");
    %     URL = "https://matlab.mathworks.com/open/github/v1?repo="+org+"/"+repo+"&project="+Project+"&file="+Script;
    % end
    if contains(EndURL,"fileexchange")
        Repo = extractAfter(EndURL,"fileexchange/");
        URL = FEXURL + Repo;
    elseif contains(EndURL,"v1?repo=")
        Repo = extractAfter(EndURL,"v1?repo=");
        URL = OpenInURL + Repo;
    else
        warning("URL pattern not matched: " + EndURL)
    end
    Img = extract(OriginalString,ImgPattern);
    NewString = Img+"("+URL+")";
    file = replace(file,OriginalString,NewString);
end
writelines(file,"README.md","WriteMode","overwrite");
end


function AddVersionInfo(ver,org,repo,fe)

% Check URL
try
    Project = dir(fullfile(currentProject().RootFolder,"*.prj")).name;
catch
    Project = "PROJECTNAME.prj";
end

file = string(fileread("README.md"));
file = split(file,newline);

URLOMO = "https://matlab.mathworks.com/open/github/v1?repo="+org+"/"+repo+"&project="+Project+"&file=README.mlx";
URLPAGES = "https://"+org+".github.io/"+repo;
if fe ~= "XXXXX-PROJECTNAME"
    URLFE = "https://www.mathworks.com/matlabcentral/fileexchange/"+fe;
else
    AllFELinks = extractBetween(file,"File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](",")");
    if isempty(AllFELinks)
        URLFE = "https://www.mathworks.com/matlabcentral/fileexchange/XXXXX-PROJECTNAME";
    else
        URLFE = AllFELinks(1);
    end
end

% Check version
err = false;
if ver ~= ""
    switch strlength( ver )
        case 3
            pattern = digitsPattern(2) + characterListPattern("a","b");
            if contains(ver,pattern)
                ver = "20"+ver;
            else
                err = true;
            end
        case 5
            pattern = "20" + digitsPattern(2)+characterListPattern("a","b");
            if ~contains(ver,pattern)
                err = true;
            end
        case 6
            pattern = "R20" + digitsPattern(2)+characterListPattern("a","b");
            if contains(ver,pattern)
                ver = replace(ver,"R","");
            else
                err = true;
            end
        otherwise
            err = true;
    end
else
    err = true;
end

if err
    ver = string(version("-release"));
    warning("Setting initial version to "+ver);
end

idInfo = find(contains(file,"# Information"));
fileOut = [file(1:idInfo-1); ...
    "";...
    "[![View on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)]("+URLFE+") or "+...
    "[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)]("+URLOMO+")";...
    "";...
    "[![MATLAB Versions Tested](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2F"+org+"%2F"+repo+"%2Frelease%2FImages%2FTestedWith.json)]("+URLPAGES+")";...
    "";...
    "**Curriculum Module**";...
    "";...
    "_Created with R"+ver+". Compatible with R"+ver+" and later releases._";...
    "";...
    file(idInfo:end)];

fileOut = join(fileOut,newline);
writelines(fileOut,"README.md","WriteMode","overwrite");
end

function HandleImages(flag)
if ~flag
movefile README_media\* Images
end
rmdir README_media s

file = string(fileread("README.md"));
file = replace(file,"README_media","Images");
[NamedImages,UnNamedImages] = FindNamedImages("Images");
for j = 1:length(UnNamedImages)
    OldIm = CheckForNamedImages(NamedImages,UnNamedImages(j).name);
    if ~strcmp(OldIm,UnNamedImages(j).name)
        file = replace(file,UnNamedImages(j).name,OldIm.name);
        delete(fullfile("Images",UnNamedImages(j).name));
    end
end

writelines(file,"README.md","WriteMode","overwrite");
end

function ChangeLocalLink(org,repo)
file = string(fileread("README.md"));
Pattern = "Scripts/"+wildcardPattern+".mlx";
OldLink = extract(file,Pattern);
Project = dir(fullfile(currentProject().RootFolder,"*.prj")).name;
for i = 1:length(OldLink)
    Script = extractAfter(OldLink(i),"Scripts/");
    URL = "https://matlab.mathworks.com/open/github/v1?repo="+org+"/"+repo+"&project="+Project+"&file=Scripts/"+Script;
    file = replace(file,OldLink(i),URL);
end
Pattern = "FunctionLibrary/"+wildcardPattern+".mlx";
OldLink = extract(file,Pattern);
Project = dir(fullfile(currentProject().RootFolder,"*.prj")).name;
for i = 1:length(OldLink)
    Script = extractAfter(OldLink(i),"FunctionLibrary/");
    URL = "https://matlab.mathworks.com/open/github/v1?repo="+org+"/"+repo+"&project="+Project+"&file="+"&file=FunctionLibrary/"+Script;
    file = replace(file,OldLink(i),URL);
end
file = replace(file,"./https","https");
writelines(file,"README.md","WriteMode","overwrite");
end

function ChangeLicenseLink(org,repo)
file = string(fileread("README.md"));
Pattern = "[LICENSE.md](https://github.com/MathWorks-Teaching-Resources/REPO_NAME/";
OldLink = extract(file,Pattern);
for i = 1:length(OldLink)
    Script = extractBefore(OldLink(i),"MathWorks-Teaching-Resources/REPO_NAME/");
    URL = Script+org+"/"+repo+"/";
    file = replace(file,OldLink(i),URL);
end
writelines(file,"README.md","WriteMode","overwrite");
end

function UpdateOpenProjectLink(org,repo)
file = string(fileread("README.md"));
Pattern = "(matlab: openProject(" + wildcardPattern + "))";
OldLink = extract(file,Pattern);
Project = extractBetween(OldLink,'"','"');
URL = "https://matlab.mathworks.com/open/github/v1?repo="+org+"/"+repo+"&project="+Project+"&file=README.mlx";
NewLink = "(" + URL + ")";
file = replace(file,OldLink,NewLink);
writelines(file,"README.md","WriteMode","overwrite");
end


function ScanForMissedPlaceholders
    file = string(fileread("README.md"));
    PatternRepo = "REPO_NAME";
    PatternProject = "PROJECTNAME";
    PatternModule = "MODULE_NAME";
    if contains(file,PatternRepo)
        warning("The README still contains "+PatternRepo+".")
    end
    if contains(file,PatternProject)
        warning("The README still contains "+PatternProject+".")
    end
    if contains(file,PatternModule)
        warning("The README still contains "+PatternModule+".")
    end
end

%[appendix]
%---

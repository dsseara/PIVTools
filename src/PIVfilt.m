function [upix,vpix] = PIVfilt(xpix,ypix,upivpix,vpivpix,snrout,filtspec)

unan = find(isnan(upivpix)==1);
vnan = find(isnan(vpivpix)==1);
[su,sv] = snrfilt(xpix,ypix,upivpix,vpivpix,snrout,filtspec.snr);
[gu,gv] = globfilt(xpix,ypix,su,sv,filtspec.globfiltstd);
[lu,lv] = localfilt(xpix,ypix,gu,gv,filtspec.locfiltstd,filtspec.locfiltmeth,filtspec.kernal);
[upix,vpix] = naninterp(lu,lv,xpix,ypix);
upix(unan) = nan;
vpix(vnan) = nan;

end


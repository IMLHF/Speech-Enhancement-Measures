function [ ref_data, ref_sampling_rate, nbits ] = wavread( ref_wav )
	[ ref_data, ref_sampling_rate ] = audioread( ref_wav );
	info = audioinfo(ref_wav);
	nbits = info.BitsPerSample;
end

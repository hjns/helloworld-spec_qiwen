### Compression and decompression commands.

### .tar
(Note: tar is packaging, not compression!)

tar decompression: tar xvf xxx.tar

Packaging: tar cvf xxx.tar DirName


### .gz

decompression 1: gunzip FileName.gz

Decompression 2: gzip -d FileName.gz

Compression: gzip FileName

### .tar.gz and .tgz

decompression: tar zxvf FileName.tar.gz

Compression: tar zcvf FileName.tar.gz DirName

### .bz2

decompression 1: bzip2 -d FileName.bz2

Decompression 2: bunzip2 FileName.bz2

Compression: bzip2 -z FileName

### .tar.bz2

decompression: tar jxvf FileName.tar.bz2

Compression: tar jcvf FileName.tar.bz2 DirName

### .bz

decompression 1: bzip2 -d FileName.bz

Decompression 2: bunzip2 FileName.bz

### .tar.bz

decompression: tar jxvf FileName.tar.bz

Compression: unknown

### .Z

decompression: uncompress FileName.Z

Compression: compress FileName

### .tar.Z

decompression: tar Zxvf FileName.tar.Z

Compression: tar Zcvf FileName.tar.Z DirName

### .zip

decompression: unzip FileName.zip

Compression: zip FileName.zip DirName
.rar decompression: rar x FileName.rar
Compression: rar a FileName.rar DirName
.lha decompression: lha -e FileName.lha
Compression: lha -a FileName.lha FileName
.rpm decompression: rpm2cpio FileName.rpm | cpio -div

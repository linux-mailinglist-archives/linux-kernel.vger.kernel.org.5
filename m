Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF957FEA7A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbjK3I0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344895AbjK3I0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:26:18 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64C010C2;
        Thu, 30 Nov 2023 00:26:08 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.48.240]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MRT6b-1qwjer3KPF-00NUzZ; Thu, 30 Nov 2023 09:20:13 +0100
Received: from localhost.fjasle.eu (unknown [IPv6:fdda:8718:be81:0:eadf:70ff:fe12:9041])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id BB89D3EC8D;
        Thu, 30 Nov 2023 09:20:05 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 5422E22F1; Thu, 30 Nov 2023 09:20:05 +0100 (CET)
Date:   Thu, 30 Nov 2023 09:20:05 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Simon Glass <sjg@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tom Rini <trini@konsulko.com>,
        lkml <linux-kernel@vger.kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Will Deacon <will@kernel.org>,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v7 2/2] arm64: boot: Support Flat Image Tree
Message-ID: <ZWhFtcrZV2FYQ_D6@bergen.fjasle.eu>
References: <20231129172200.430674-1-sjg@chromium.org>
 <20231129172200.430674-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Pvx5wNU6b2IwuyjJ"
Content-Disposition: inline
In-Reply-To: <20231129172200.430674-3-sjg@chromium.org>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:XnS6fVsgbU/wvbl/VaS2Rkiz1qshjFzLsV9miZckKXWaGT1fei5
 3D8It2r74nsnUnzGK8LCjutb2Ga7/kyYGd0WA3x0tMCuST/KsEu+pQlswKjQI+/yb9JDIIO
 FpkaNa3XC+fsdVlEytmaaqfenB+8r09Jq2pxfvH9Cywe60v8Ds7A/Y1eFRrB6qRUe69zBJu
 xfvZ+q2qsTyGQu7GfFhjQ==
UI-OutboundReport: notjunk:1;M01:P0:Ib+tXR8wLg8=;WU13iGw422RKh3+dwd8djPqjgPi
 Wgowt2SbOLYOf0QY/2i0rS+4GM7mnM1wuq3W0mWe75b9GdmYNoDtk+ZuYZ3TMvvOhfU5VVcnu
 IrQtQXszy5HaCQP/tw28XchSG4cj4PwkGbvHgJr+4cV5wYQxyRgilnvgKgPBXZzmknO5JoAhC
 jfJcrJC6iWCeUzd/7Pp0Ocqz3klKAe26hEWezj1TOPb+ySk0bhj1NP4+VHMn/Pkoggs+p4Fg+
 NRT90M7UTawLt+7eqQOQtNpcmBhXzrMcp4eU0mNCJua6BjFDbIC5q6PTzIiPJ8ZxiBle7MBNk
 IG8fXt4i4u7YwqgbhEzrDlrTNU5l5V+oIu/qHuvl+2op3LeGG+AJR21SE6QCGHXBHV3rVM9mv
 qLyqqXOqDPz6PKACAIUtANrM8C/0hCHEfVzrWJA/ZmHzZYK6DEiAHRNtZ3NGN2Ucnlzg72oUl
 aRovJ/4oF/1aElSZnbNtVgIErN/v2kDIXO04x3PzNKIsXw1LudyTFlDjwJNstqi/FoNUk31kC
 LlnmjY5iPR7RiuwI39CqUOmQMw8bF2UBHeJh+zhL2Se/MjsZCYMkNZCPVychjtMdyueheBSan
 491dIEOcpMgGozyjrdeD42f3P8QqrjRL0k2uk1oc8xcx/f8PYU04hFfU+yJSSgtq1neOrO7i9
 SStbdPJ6n9bIpkMzcpiosufbcTSHjtzIbONulFUTYzzfXGRYj1ODag02ZESReDwmlml4/8bK4
 QfIYXhojn8CWMNifgPL5rGtccLWD3dz6Zy3x0OIPrgYYc0OepQNi8GSdxgLfn40BRCRuSGf3O
 EyyOa13EFRwGgQmXYdJGwgNfDBHvUMQGJvdis0pAasBqAxC3dphWcUFWy7AphilgOH/+ro/eA
 qgL3jZ2RLi9wHdQ==
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pvx5wNU6b2IwuyjJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Simon,

thanks for the patch!  Below are some nitpicks and bike-shedding=20
questions.

On Wed 29 Nov 2023 10:21:53 GMT, Simon Glass wrote:
> Add a script which produces a Flat Image Tree (FIT), a single file
> containing the built kernel and associated devicetree files.
> Compression defaults to gzip which gives a good balance of size and
> performance.
>=20
> The files compress from about 86MB to 24MB using this approach.
>=20
> The FIT can be used by bootloaders which support it, such as U-Boot
> and Linuxboot. It permits automatic selection of the correct
> devicetree, matching the compatible string of the running board with
> the closest compatible string in the FIT. There is no need for
> filenames or other workarounds.

Have you thought about updating the arch/mips ITB rules to also use the=20
new scripts/make_fit.py?  Or is the FIT/ITB format for mips different=20
=66rom the one for arm64?

> Add a 'make image.fit' build target for arm64, as well.
>=20
> The FIT can be examined using 'dumpimage -l'.
>=20
> This features requires pylibfdt (use 'pip install libfdt'). It also
> requires compression utilities for the algorithm being used. Supported
> compression options are the same as the Image.xxx files. For now there
> is no way to change the compression other than by editing the rule for
> $(obj)/image.fit
>=20
> While FIT supports a ramdisk / initrd, no attempt is made to support
> this here, since it must be built separately from the Linux build.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v7:
> - Add Image as a dependency of image.fit
> - Drop kbuild tag
> - Add dependency on dtbs
> - Drop unnecessary path separator for dtbs
> - Rebase to -next
>=20
> Changes in v5:
> - Drop patch previously applied
> - Correct compression rule which was broken in v4
>=20
> Changes in v4:
> - Use single quotes for UIMAGE_NAME
>=20
> Changes in v3:
> - Drop temporary file image.itk
> - Drop patch 'Use double quotes for image name'
> - Drop double quotes in use of UIMAGE_NAME
> - Drop unnecessary CONFIG_EFI_ZBOOT condition for help
> - Avoid hard-coding "arm64" for the DT architecture
>=20
> Changes in v2:
> - Drop patch previously applied
> - Add .gitignore file
> - Move fit rule to Makefile.lib using an intermediate file
> - Drop dependency on CONFIG_EFI_ZBOOT
> - Pick up .dtb files separately from the kernel
> - Correct pylint too-many-args warning for write_kernel()
> - Include the kernel image in the file count
> - Add a pointer to the FIT spec and mention of its wide industry usage
> - Mention the kernel version in the FIT description
>=20
>  MAINTAINERS                |   7 +
>  arch/arm64/Makefile        |   9 +-
>  arch/arm64/boot/.gitignore |   1 +
>  arch/arm64/boot/Makefile   |   6 +-
>  scripts/Makefile.lib       |  13 ++
>  scripts/make_fit.py        | 289 +++++++++++++++++++++++++++++++++++++
>  6 files changed, 322 insertions(+), 3 deletions(-)
>  create mode 100755 scripts/make_fit.py
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 14587be87a33..d609f0e8deb3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1585,6 +1585,13 @@ F:	Documentation/process/maintainer-soc*.rst
>  F:	arch/arm/boot/dts/Makefile
>  F:	arch/arm64/boot/dts/Makefile
> =20
> +ARM64 FIT SUPPORT
> +M:	Simon Glass <sjg@chromium.org>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	arch/arm64/boot/Makefile
> +F:	scripts/make_fit.py
> +

I'm afraid that the location does not match the requested sorting, it=20
should be right before "ARM64 PORT".

>  ARM ARCHITECTED TIMER DRIVER
>  M:	Mark Rutland <mark.rutland@arm.com>
>  M:	Marc Zyngier <maz@kernel.org>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 1bd4fae6e806..18e092de7cdb 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -36,6 +36,8 @@ ifeq ($(CONFIG_BROKEN_GAS_INST),y)
>  $(warning Detected assembler with broken .inst; disassembly will be unre=
liable)
>  endif
> =20
> +KBUILD_DTBS      :=3D dtbs

Might you want to use tabs here as in the lines below?

> +
>  KBUILD_CFLAGS	+=3D -mgeneral-regs-only	\
>  		   $(compat_vdso) $(cc_has_k_constraint)
>  KBUILD_CFLAGS	+=3D $(call cc-disable-warning, psabi)
> @@ -150,7 +152,7 @@ libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firmw=
are/efi/libstub/lib.a
>  # Default target when executing plain make
>  boot		:=3D arch/arm64/boot
> =20
> -BOOT_TARGETS	:=3D Image vmlinuz.efi
> +BOOT_TARGETS	:=3D Image vmlinuz.efi image.fit
> =20
>  PHONY +=3D $(BOOT_TARGETS)
> =20
> @@ -162,7 +164,9 @@ endif
> =20
>  all:	$(notdir $(KBUILD_IMAGE))
> =20
> -vmlinuz.efi: Image
> +image.fit: $(KBUILD_DTBS)
> +
> +vmlinuz.efi image.fit: Image
>  $(BOOT_TARGETS): vmlinux
>  	$(Q)$(MAKE) $(build)=3D$(boot) $(boot)/$@
> =20
> @@ -215,6 +219,7 @@ virtconfig:
>  define archhelp
>    echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Im=
age.gz)'
>    echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/=
Image)'
> +  echo  '  image.fit     - Flat Image Tree (arch/$(ARCH)/boot/image.fit)'
>    echo  '  install       - Install uncompressed kernel'
>    echo  '  zinstall      - Install compressed kernel'
>    echo  '                  Install using (your) ~/bin/installkernel or'
> diff --git a/arch/arm64/boot/.gitignore b/arch/arm64/boot/.gitignore
> index af5dc61f8b43..abaae9de1bdd 100644
> --- a/arch/arm64/boot/.gitignore
> +++ b/arch/arm64/boot/.gitignore
> @@ -2,3 +2,4 @@
>  Image
>  Image.gz
>  vmlinuz*
> +image.fit
> diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
> index 1761f5972443..8d591fda078f 100644
> --- a/arch/arm64/boot/Makefile
> +++ b/arch/arm64/boot/Makefile
> @@ -16,7 +16,8 @@
> =20
>  OBJCOPYFLAGS_Image :=3D-O binary -R .note -R .note.gnu.build-id -R .comm=
ent -S
> =20
> -targets :=3D Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo Ima=
ge.zst
> +targets :=3D Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo \
> +	Image.zst image.fit

Do you introduce the first lower-case image.* target by intention? =20
(All others have a capital 'I'.)

> =20
>  $(obj)/Image: vmlinux FORCE
>  	$(call if_changed,objcopy)
> @@ -39,6 +40,9 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
>  $(obj)/Image.zst: $(obj)/Image FORCE
>  	$(call if_changed,zstd)
> =20
> +$(obj)/image.fit: $(obj)/Image FORCE
> +	$(call cmd,fit,gzip)
> +
>  EFI_ZBOOT_PAYLOAD	:=3D Image
>  EFI_ZBOOT_BFD_TARGET	:=3D elf64-littleaarch64
>  EFI_ZBOOT_MACH_TYPE	:=3D ARM64
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 1a965fe68e01..e1c06ca3c847 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -496,6 +496,19 @@ quiet_cmd_uimage =3D UIMAGE  $@
>  			-a $(UIMAGE_LOADADDR) -e $(UIMAGE_ENTRYADDR) \
>  			-n '$(UIMAGE_NAME)' -d $< $@
> =20
> +# Flat Image Tree (FIT)
> +# This allows for packaging of a kernel and all devicetrees files, using
> +# compression.
> +# ----------------------------------------------------------------------=
-----
> +
> +MAKE_FIT :=3D $(srctree)/scripts/make_fit.py
> +
> +quiet_cmd_fit =3D FIT     $@
> +      cmd_fit =3D $(MAKE_FIT) -f $@ --arch $(UIMAGE_ARCH) --os linux \
> +			--name '$(UIMAGE_NAME)' \
> +			--compress $(UIMAGE_COMPRESSION) -k $< \
> +			$(dir $<)dts

Alternatively, you could use '$(<D)/dts' instead of '$(dir $<)dts'=20
(bike-shedding).

> +
>  # XZ
>  # ----------------------------------------------------------------------=
-----
>  # Use xzkern to compress the kernel image and xzmisc to compress other t=
hings.
> diff --git a/scripts/make_fit.py b/scripts/make_fit.py
> new file mode 100755
> index 000000000000..e1059825de9c
> --- /dev/null
> +++ b/scripts/make_fit.py
> @@ -0,0 +1,289 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright 2023 Google LLC
> +# Written by Simon Glass <sjg@chromium.org>
> +#
> +
> +"""Build a FIT containing a lot of devicetree files
> +
> +Usage:
> +    make_fit.py -A arm64 -n 'Linux-6.6' -O linux
> +        -f arch/arm64/boot/image.fit -k /tmp/kern/arch/arm64/boot/image.=
itk
> +        /tmp/kern/arch/arm64/boot/dts/ -E -c gzip
> +
> +Creates a FIT containing the supplied kernel and a directory containing =
the
> +devicetree files.
> +
> +Use -E to generate an external FIT (where the data is placed after the
> +FIT data structure). This allows parsing of the data without loading
> +the entire FIT.
> +
> +Use -c to compress the data, using bzip2, gzip, lz4, lzma, lzo and
> +zstd

Lost a dot at EOL?

> +
> +The resulting FIT can be booted by bootloaders which support FIT, such
> +as U-Boot, Linuxboot, Tianocore, etc.
> +
> +Note that this tool does not yet support adding a ramdisk / initrd.
> +"""
> +
> +import argparse
> +import collections
> +import os
> +import subprocess
> +import sys
> +import tempfile
> +import time
> +
> +import libfdt
> +
> +
> +# Tool extension and the name of the command-line tools
> +CompTool =3D collections.namedtuple('CompTool', 'ext,tools')
> +
> +COMP_TOOLS =3D {
> +    'bzip2': CompTool('.bz2', 'bzip2'),
> +    'gzip': CompTool('.gz', 'pigz,gzip'),
> +    'lz4': CompTool('.lz4', 'lz4'),
> +    'lzma': CompTool('.lzma', 'lzma'),
> +    'lzo': CompTool('.lzo', 'lzop'),
> +    'zstd': CompTool('.zstd', 'zstd'),
> +}
> +
> +def parse_args():
> +    """Parse the program ArgumentParser
> +
> +    Returns:
> +        Namespace object containing the arguments
> +    """
> +    epilog =3D 'Build a FIT from a directory tree containing .dtb files'
> +    parser =3D argparse.ArgumentParser(epilog=3Depilog)
> +    parser.add_argument('-A', '--arch', type=3Dstr, required=3DTrue,
> +          help=3D'Specifies the architecture')
> +    parser.add_argument('-c', '--compress', type=3Dstr, default=3D'none',
> +          help=3D'Specifies the compression')
> +    parser.add_argument('-E', '--external', action=3D'store_true',
> +          help=3D'Convert the FIT to use external data')
> +    parser.add_argument('-n', '--name', type=3Dstr, required=3DTrue,
> +          help=3D'Specifies the name')
> +    parser.add_argument('-O', '--os', type=3Dstr, required=3DTrue,
> +          help=3D'Specifies the operating system')
> +    parser.add_argument('-f', '--fit', type=3Dstr, required=3DTrue,
> +          help=3D'Specifies the output file (.fit)')
> +    parser.add_argument('-k', '--kernel', type=3Dstr, required=3DTrue,
> +          help=3D'Specifies the (uncompressed) kernel input file (.itk)')
> +    parser.add_argument('srcdir', type=3Dstr, nargs=3D'*',
> +          help=3D'Specifies the directory tree that contains .dtb files')
> +
> +    return parser.parse_args()
> +
> +def setup_fit(fsw, name):
> +    """Make a start on writing the FIT
> +
> +    Outputs the root properties and the 'images' node
> +
> +    Args:
> +        fsw (libfdt.FdtSw): Object to use for writing
> +        name (str): Name of kernel image
> +    """
> +    fsw.INC_SIZE =3D 65536
> +    fsw.finish_reservemap()
> +    fsw.begin_node('')
> +    fsw.property_string('description', f'{name} with devicetree set')
> +    fsw.property_u32('#address-cells', 1)
> +
> +    fsw.property_u32('timestamp', int(time.time()))
> +    fsw.begin_node('images')
> +
> +
> +def write_kernel(fsw, data, args):
> +    """Write out the kernel image
> +
> +    Writes a kernel node along with the required properties
> +
> +    Args:
> +        fsw (libfdt.FdtSw): Object to use for writing
> +        data (bytes): Data to write (possibly compressed)
> +        args (Namespace): Contains necessary strings:
> +            arch: FIT architecture, e.g. 'arm64'
> +            fit_os: Operating Systems, e.g. 'linux'
> +            name: Name of OS, e.g. 'Linux-6.6.0-rc7'
> +            compress: Compression algorithm to use, e.g. 'gzip'
> +    """
> +    with fsw.add_node('kernel'):
> +        fsw.property_string('description', args.name)
> +        fsw.property_string('type', 'kernel_noload')
> +        fsw.property_string('arch', args.arch)
> +        fsw.property_string('os', args.os)
> +        fsw.property_string('compression', args.compress)
> +        fsw.property('data', data)
> +        fsw.property_u32('load', 0)
> +        fsw.property_u32('entry', 0)
> +
> +
> +def finish_fit(fsw, entries):
> +    """Finish the FIT ready for use
> +
> +    Writes the /configurations node and subnodes
> +
> +    Args:
> +        fsw (libfdt.FdtSw): Object to use for writing
> +        entries (list of tuple): List of configurations:
> +            str: Description of model
> +            str: Compatible stringlist
> +    """
> +    fsw.end_node()
> +    seq =3D 0
> +    with fsw.add_node('configurations'):
> +        for model, compat in entries:
> +            seq +=3D 1
> +            with fsw.add_node(f'conf-{seq}'):
> +                fsw.property('compatible', bytes(compat))
> +                fsw.property_string('description', model)
> +                fsw.property_string('fdt', f'fdt-{seq}')
> +                fsw.property_string('kernel', 'kernel')
> +    fsw.end_node()
> +
> +
> +def compress_data(inf, compress):
> +    """Compress data using a selected algorithm
> +
> +    Args:
> +        inf (IOBase): Filename containing the data to compress
> +        compress (str): Compression algorithm, e.g. 'gzip'
> +
> +    Return:
> +        bytes: Compressed data
> +    """
> +    if compress =3D=3D 'none':
> +        return inf.read()
> +
> +    comp =3D COMP_TOOLS.get(compress)
> +    if not comp:
> +        raise ValueError(f"Unknown compression algorithm '{compress}'")
> +
> +    with tempfile.NamedTemporaryFile() as comp_fname:
> +        with open(comp_fname.name, 'wb') as outf:
> +            done =3D False
> +            for tool in comp.tools.split(','):
> +                try:
> +                    subprocess.call([tool, '-c'], stdin=3Dinf, stdout=3D=
outf)
> +                    done =3D True
> +                    break
> +                except FileNotFoundError:
> +                    pass
> +            if not done:
> +                raise ValueError(f'Missing tool(s): {comp.tools}\n')
> +            with open(comp_fname.name, 'rb') as compf:
> +                comp_data =3D compf.read()
> +    return comp_data
> +
> +
> +def output_dtb(fsw, seq, fname, arch, compress):
> +    """Write out a single devicetree to the FIT
> +
> +    Args:
> +        fsw (libfdt.FdtSw): Object to use for writing
> +        seq (int): Sequence number (1 for first)
> +        fmame (str): Filename containing the DTB
> +        arch: FIT architecture, e.g. 'arm64'
> +        compress (str): Compressed algorithm, e.g. 'gzip'
> +
> +    Returns:
> +        tuple:
> +            str: Model name
> +            bytes: Compatible stringlist
> +    """
> +    with fsw.add_node(f'fdt-{seq}'):
> +        # Get the compatible / model information
> +        with open(fname, 'rb') as inf:
> +            data =3D inf.read()
> +        fdt =3D libfdt.FdtRo(data)
> +        model =3D fdt.getprop(0, 'model').as_str()
> +        compat =3D fdt.getprop(0, 'compatible')
> +
> +        fsw.property_string('description', model)
> +        fsw.property_string('type', 'flat_dt')
> +        fsw.property_string('arch', arch)
> +        fsw.property_string('compression', compress)
> +        fsw.property('compatible', bytes(compat))
> +
> +        with open(fname, 'rb') as inf:
> +            compressed =3D compress_data(inf, compress)
> +        fsw.property('data', compressed)
> +    return model, compat
> +
> +
> +def build_fit(args):
> +    """Build the FIT from the provided files and arguments
> +
> +    Args:
> +        args (Namespace): Program arguments
> +
> +    Returns:
> +        tuple:
> +            bytes: FIT data
> +            int: Number of configurations generated
> +            size: Total uncompressed size of data
> +    """
> +    fsw =3D libfdt.FdtSw()
> +    setup_fit(fsw, args.name)
> +    seq =3D 0
> +    size =3D 0
> +    entries =3D []
> +
> +    # Handle the kernel
> +    with open(args.kernel, 'rb') as inf:
> +        comp_data =3D compress_data(inf, args.compress)
> +    size +=3D os.path.getsize(args.kernel)
> +    write_kernel(fsw, comp_data, args)
> +
> +    for path in args.srcdir:
> +        # Handle devicetree files
> +        if os.path.isdir(path):
> +            for dirpath, _, fnames in os.walk(path):
> +                for fname in fnames:
> +                    if os.path.splitext(fname)[1] !=3D '.dtb':
> +                        continue
> +                    pathname =3D os.path.join(dirpath, fname)
> +                    seq +=3D 1
> +                    size +=3D os.path.getsize(pathname)
> +                    model, compat =3D output_dtb(fsw, seq, pathname,
> +                                               args.arch, args.compress)
> +                    entries.append([model, compat])
> +
> +    finish_fit(fsw, entries)
> +
> +    # Include the kernel itself in the returned file count
> +    return fsw.as_fdt().as_bytearray(), seq + 1, size
> +
> +
> +def run_make_fit():
> +    """Run the tool's main logic"""
> +    args =3D parse_args()
> +
> +    out_data, count, size =3D build_fit(args)
> +    with open(args.fit, 'wb') as outf:
> +        outf.write(out_data)
> +
> +    ext_fit_size =3D None
> +    if args.external:
> +        mkimage =3D os.environ.get('MKIMAGE', 'mkimage')

Do we need to add a 'mkimage' line in=20
Documentation/process/changes.rst?

Kind regards,
Nicolas


> +        subprocess.check_call([mkimage, '-E', '-F', args.fit],
> +                              stdout=3Dsubprocess.DEVNULL)
> +
> +        with open(args.fit, 'rb') as inf:
> +            data =3D inf.read()
> +        ext_fit =3D libfdt.FdtRo(data)
> +        ext_fit_size =3D ext_fit.totalsize()
> +
> +    comp_size =3D len(out_data)
> +    print(f'FIT size {comp_size:#x}/{comp_size / 1024 / 1024:.1f} MB', e=
nd=3D'')
> +    if ext_fit_size:
> +        print(f', header {ext_fit_size:#x}/{ext_fit_size / 1024:.1f} KB'=
, end=3D'')
> +    print(f', {count} files, uncompressed {size / 1024 / 1024:.1f} MB')
> +
> +
> +if __name__ =3D=3D "__main__":
> +    sys.exit(run_make_fit())
> --=20
> 2.43.0.rc2.451.g8631bc7472-goog
>=20

--Pvx5wNU6b2IwuyjJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmVoRbQACgkQB1IKcBYm
Emmfcg//Sq2hh52/spuR7FbJdMBljSoqG9ZgKn9PQm4xL3cwnTzZOXb4pi+8d531
xcHF4QShkm5X2gC8cgShlorIqEBp+8G8cEFE+ns7s5MuI1FQtwwTyNxswUOyO4qN
/WMTMHx2MdVvuVGtGTNooYkh+mRAiKUOS9vl5bNA64FTMqDpWT4mjc+Bqa9jYtfS
Kg1BIXNyVw+ZmYyliBTCUBojKflSHbLE2TrN3xYS9Oxxt5ZDqXevfMp1qncWOeEU
W+7eXpHuBl8iQ6Ql2skbqvERPxTT0aoLvGKuPUqvzS6XeSFMFg3yyEU61vIku8de
qLGV0I3HJPTEDD14uGQl8RLQoctYT++honum0FSyNHcTqZMW6SPsUZMil2I4qlK3
7sV5TmUASHy57ScnwIG0rt1pLv7h91JJSsUR2LY4ofjf6znCWcBhqEaJa0H+jDA5
es1U7Ih/fq1Rh3GAG8PTfv23I+vQ+zDgvt4KpI0ORZKrm1gsMehedeidRreG5fJ6
K/2Vu2ALqzj/KlMOLcXvn3aZPYPTeOokBuonRBFMsb1gLIjIKHIdyEWwTcllnSBa
MFGvPZHzTL5EMLJSbiyt7imJbLmlZqwBBTAl1o2+42v4QNgEQmNajNmXvHf3x+yU
w6QgS28wBpaNrmRwYpG9yDgociMRwbSQduPAkCfthoUwqtG6RLw=
=GPim
-----END PGP SIGNATURE-----

--Pvx5wNU6b2IwuyjJ--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DC678E1B7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjH3V71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjH3V70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:59:26 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42ECCF7;
        Wed, 30 Aug 2023 14:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693432666;
        bh=brDmPgNNgvT/WZn90dt3uv4Xf3ucseU6T7DcS8sefvQ=;
        h=Date:From:To:Cc:Subject:From;
        b=CN4XOY3M7h5WFbVo+h/FqcUtj56c+kIpzp47ESFyifT4UMeV1AH4hrcMWEBOxy3S2
         bfVCgMlNsIpGbj6Y/WeMGoW25M4exeaJmzQpkd5/D5Q04/+XYtGEGzBgnlpimh0QAu
         qGCDfr3ZwRX6yjb3lkkFvt1ySFGfMjRMAnmy7Ixqx2ltkUVFBpc90b3ieiKRNksN35
         URlE85wwIgFFNUJbnMWGVxaTDsHsZn8CDeN2WT5M0eYGv5WX+kBF3nOUNKUdqb/fbE
         3fzYYMLv6oi4aQomSuh9J9Njrgj7C+Wtit8oo+cHKB9v5uFiKT4x3ObUt86RV6ByKM
         vdXYBBe9/vCPQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RbdSl6Kx2z4wbP;
        Thu, 31 Aug 2023 07:57:43 +1000 (AEST)
Date:   Thu, 31 Aug 2023 07:57:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the risc-v tree
Message-ID: <20230831075730.0dd941dd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hGLyYFpB7CgDYtxzWc95Emy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hGLyYFpB7CgDYtxzWc95Emy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  dbe46b094026 ("RISC-V: Add ptrace support for vectors")
  ed1a8872ff83 ("soc: renesas: Kconfig: Select the required configs for RZ/=
Five SoC")
  f508b0175578 ("cache: Add L2 cache management for Andes AX45MP RISC-V cor=
e")
  555dd72bc06e ("dt-bindings: cache: andestech,ax45mp-cache: Add DT binding=
 docu  dbe46b094026 ("RISC-V: Add ptrace support for vectors")
  ed1a8872ff83 ("soc: renesas: Kconfig: Select the required configs for RZ/=
Five
SoC")
  f508b0175578 ("cache: Add L2 cache management for Andes AX45MP RISC-V cor=
e")
  555dd72bc06e ("dt-bindings: cache: andestech,ax45mp-cache: Add DT binding=
 docu
mentation for L2 cache controller")
  30bc090f40f8 ("riscv: mm: dma-noncoherent: nonstandard cache operations s=
upport")
  f2863f30d1b0 ("riscv: errata: Add Andes alternative ports")
  93e0e2419b65 ("riscv: asm: vendorid_list: Add Andes Technology to the ven=
dors list")
  eb76e5111881 ("riscv: dma-mapping: switch over to generic implementation")
  14be7c16d420 ("riscv: dma-mapping: skip invalidation before bidirectional=
 DMA")
  fbfc740ced8f ("riscv: dma-mapping: only invalidate after DMA, not flush")
  b6e3f6e009a1 ("RISC-V: alternative: Remove feature_probe_func")
  b98673c5b037 ("RISC-V: Probe for unaligned access speed")
  26ba042414a3 ("perf: tests: Adapt mmap-basic.c for riscv")
  60bd50116484 ("tools: lib: perf: Implement riscv mmap support")
  57972127b20e ("Documentation: admin-guide: Add riscv sysctl_perf_user_acc=
ess")
  cc4c07c89aad ("drivers: perf: Implement perf event mmap support in the SB=
I backend")
  50be34282905 ("drivers: perf: Implement perf event mmap support in the le=
gacy backend")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/hGLyYFpB7CgDYtxzWc95Emy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTvu0oACgkQAVBC80lX
0GyCHwf/W5NotX5wB2/Fq3lY+jtZxyUsVQqRidE4C7iOJccgZ1NLom56Z52hX0W4
W5klcFIZdsKXZAZIMrpn0LUBRbKvxAK6Si6LvCjBpLs0CtvKqhQuD0arN0AYNcOT
0DAjBuYjBkdtb8nYep0Wtmt9oE5h2FWaclXxvbUH/TkLWW9cBWE8SWiP9+ejAaPO
0zt++R9v930T6rW1jYGttaZEUkoKJwZ/Nzj1o/+jtvd6VfjW/KsfSrwVkT9v68VB
SGCVU1VzXgIt1s/1RsQVvLuzTqXl6tr3phR3m60aw1PBTtr10OzdMJMUIIBCtDbI
G2nooA/AVWipxTp9s8RFYUmCN2ghGw==
=R5Bk
-----END PGP SIGNATURE-----

--Sig_/hGLyYFpB7CgDYtxzWc95Emy--

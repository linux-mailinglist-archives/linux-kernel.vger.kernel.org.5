Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90253791F0F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 23:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbjIDVoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 17:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjIDVoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 17:44:05 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4A71B4;
        Mon,  4 Sep 2023 14:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693863835;
        bh=voAoM6CYvpZr+FmVVytnP2EqVOXt41NImBFsk08U9Vc=;
        h=Date:From:To:Cc:Subject:From;
        b=fslWcuANGiAbSl8aD0YSOCNe7yrHR7yucJsZa8zTqKyRedNvPMtLNG8Z1/z7+bOuW
         5vwm4pjY8B87zz6NH10HFLAQGfaOzU17BYqMWlScvxK7vwJYMuHi+/b51FATUHpEYx
         I1aOdoEHlUP0+atxKz+ZznbcCBzPHUwE08Ndbjz25oj50wCFzXHSxrLGQWH2eRmLTV
         zdrl8rvOVUVI6crLAhgXGLJ0F2/O49OvFtbmGSZ85l13EYt2cR4hlY0ylYncZhMzwv
         Tq1lyPCgykJXVFDJ9pVQEtS0cs9NYYti+Gn3Ul4VwDWJNJkRu86/JL5MpaUOf+0IXx
         Wky1QyQ1Y1wAA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfhwV6rDBz4wb1;
        Tue,  5 Sep 2023 07:43:54 +1000 (AEST)
Date:   Tue, 5 Sep 2023 07:43:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the perf-current tree
Message-ID: <20230905074350.6a9c81f2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vGfoc9ZMDsdcTIKH2i+0BJ1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vGfoc9ZMDsdcTIKH2i+0BJ1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  10da1b8ed79f ("perf tests mmap-basic: Adapt for riscv")
  159a8bb06f7b ("libperf: Implement riscv mmap support")

These are commits

  26ba042414a3 ("perf: tests: Adapt mmap-basic.c for riscv")
  60bd50116484 ("tools: lib: perf: Implement riscv mmap support")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/vGfoc9ZMDsdcTIKH2i+0BJ1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT2T5cACgkQAVBC80lX
0GzXYQf8DTnpUL7XuPwxnVwlYf2lMrHsueznOpFpxt4e6V40aLeqW6bti85dhTOi
x6oHxDypMMhCnllMwlPq70DjhG7bt2GZ3we5DbrFMlYuymGwSOuAsns/twhay+Z/
GyU4Os2UX04CaxBORj0XE9Fc1x57cfFCgXWYqISCNz0oPVembXzqLWivs27e0Jpe
MekaIKoY0z2R0W4VQHHMyeX4AFQwNxUBngN1Z0FFFBb2fEqsQZvLRlZORDYlBshR
NaQOEHoLB1BLW4Zxkq1/S3afmbr5B7fz9ILM1tqRpq0+9I73i6+fjTiIAyF15PBZ
8rY3iFSHx8lPLnvfzlF8zyaMe2yXTA==
=LSmR
-----END PGP SIGNATURE-----

--Sig_/vGfoc9ZMDsdcTIKH2i+0BJ1--

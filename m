Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B2C7DFBBF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345753AbjKBUzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBUzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:55:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C88185;
        Thu,  2 Nov 2023 13:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698958527;
        bh=gZcASZKHoKWdU9NDR1Pm1mQhrahpEg1RI5BeppjS5+E=;
        h=Date:From:To:Cc:Subject:From;
        b=l1HWhaGkneH3W8B0pbdPmofcLZ4Jk2kHHUfPeCaqspA42pstPyBiNXPUSqB+0ymDd
         o/WyAMmgaO0z5nJb4mC0PNG4g7KIiMMIDgEFSg1VzzQpA7d2eKyt2EsYpkLvVHhOiw
         ZX4VxFYObCUNFqn9BAEJkQUWG+XnwN8sH6YRPvgjEORWpDA5qHPCcGdLgtz0oZFxNV
         sogs35aJmeKTRlnDJearNt07eo7tGIsAJKcoLKz4a0VFC1a/nuzSdZruPubOYqTbzM
         u+u2NGvSOCBC1NZ4U1kB01IyREcXzee03pp+0yFwe1MLoZsRUIvTYOa44yJeJXoz0q
         tPoNjerYJObVA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SLx3H73Ttz4x5k;
        Fri,  3 Nov 2023 07:55:23 +1100 (AEDT)
Date:   Fri, 3 Nov 2023 07:55:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the risc-v tree
Message-ID: <20231103075521.74a94ee2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/g_HS5V6Q8KKzaeiITI+VD3k";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/g_HS5V6Q8KKzaeiITI+VD3k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  c1c99e5f1b13 ("riscv: errata: prefix T-Head mnemonics with th.")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/g_HS5V6Q8KKzaeiITI+VD3k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVEDLkACgkQAVBC80lX
0Gx6Nwf/cy+YYQWeRhE5jo0rO/YMdL+UTF0XWte+xMm+bDsBxiqzjjk3NcSSpd+s
WBDCHDJS1OdUwWNgdir5EqIHVX35ncu5YEE28PxzT4wcla8iD4duByKCttvfxoCH
51JbrpC6UjhPFfZRgRy+S7LizZiUSgn1V6bCSoxhgHyyh9FbUx7LSl1mAXwoE0VF
bmLLyQcqhRddT8qmLEJeqvmDyhMZ7zHyqnmPoCz5jNB9SYeOPgvHBx8ycsbopUtz
xq8DJOxlahDgeKyNYExa4dpcle6RcDrHfcTP1ayrFPl03hVEpjIt2xnlZx/i1Ifd
4cIkaQcgbA/pajExG5aQnKOXfc/Utg==
=tJEG
-----END PGP SIGNATURE-----

--Sig_/g_HS5V6Q8KKzaeiITI+VD3k--

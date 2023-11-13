Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E947D7EA527
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 21:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjKMU63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 15:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjKMU63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 15:58:29 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675DA189;
        Mon, 13 Nov 2023 12:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699909105;
        bh=S8GKVidekCTz5YQyshWVhExuAgu8Ma3k8Ik+ACdCWDg=;
        h=Date:From:To:Cc:Subject:From;
        b=hcP8aZ5kodJIKKbMDHC+HmZYM59IvPcvg2iIzwWSzrf3Mfuot0kRUvCl0/xeRcTP+
         bSseJkWeHEu7gAFao2p1k8qDAzBQWkakKfS4AJjujADs+SNF0NfpCX2NHMeQQRQd/O
         p2e23JR8PIiq6VKb/Wy9RTVVAXmmm6051/m0/BvRmPcftQ/TQNOH7GedNMQEDUqBNi
         iyiRNqoOA+HnHyy1BMxIJDqsdbwFvcOq4jI4DYpNoqh8DfwXFV3ox18YZkqyntIrxw
         uYAca+ycv8GYeylEWrPcukzx2qFFE081HiPeW/OV5Za82H6Sj+SKQ15JaIJkkCzKof
         rPNrrL4b1dHPw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SThbj0hY5z4xFR;
        Tue, 14 Nov 2023 07:58:25 +1100 (AEDT)
Date:   Tue, 14 Nov 2023 07:58:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the sound-asoc tree
Message-ID: <20231114075824.41584faa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RhMk1Ln9F3sXcRbTUKfEOly";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RhMk1Ln9F3sXcRbTUKfEOly
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  60b4a86cc6b8 ("ASoC: amd: acp: Fix for indentation issue")

Fixes tag

  Fixes: e84db124cb21 (ASoC: amd: acp: Add pci legacy driver support

has these problem(s):

  - Subject has leading but no trailing parentheses

Please do not split Fixes tags over more than one line and keep all the
commit message tags together at the end of the commit message.

--=20
Cheers,
Stephen Rothwell

--Sig_/RhMk1Ln9F3sXcRbTUKfEOly
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVSjfAACgkQAVBC80lX
0GxqAAf7BXBw0fao85v6x7XMToRR/ASRn1VLYpctXteFtJ59MIXkQ8/PKEwmVbOc
nKGZw+OkHlnMhPddfrnlY5O0grl56DqyW0xNRVjf3kOlG+bcIY8Ri+9OvpEciE4X
L7+NvuQwGY3B8IhyLxL6rNsmuQoMaxsszCNV/Oj/Mn32tVG0omOGbqtrSFTfJWQ5
IgkPs0PQ2M+h/P+ozyYF5DEeZi8Mi7T0xpQlU4BiE5hSe/ZsNNLs7/rvcaFJgcWL
tuh3fLFf2XTbmtti/bHCCxj6czgY/OWP5LfZuOO8ycSxaw8xsRq9tIBf6MxclITx
3B/x/4q4r8EH+p2hMBEvJ3VX6wCiJQ==
=63VU
-----END PGP SIGNATURE-----

--Sig_/RhMk1Ln9F3sXcRbTUKfEOly--

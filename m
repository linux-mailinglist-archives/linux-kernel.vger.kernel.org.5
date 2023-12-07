Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D748094E1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbjLGVsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjLGVsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:48:01 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDC010D8;
        Thu,  7 Dec 2023 13:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701985680;
        bh=X4YTdhqhYGZhla9xm2lKDRZhCpTvNfgHqPxqimBLQcI=;
        h=Date:From:To:Cc:Subject:From;
        b=f7U6djFrY7Lfec5Yg7KzsqwaRWtjKKz9CIdTIr1UXkLbMvAcg5GuyBmMx5/ADGk7f
         WJvbuSXE60dhZETBCDo/IfgmQ51WSjtOrr3E+JIJTE48M/ORlgbZ6iVtFko6JRLAVc
         +QKGqxKkxa1j72X9t3c2slUYkAR+ZE4ZsIef+K4f+aDRV6C8LfUOJYK7sOqxzPcurG
         v+hU5muKW2v0r4uSU3Et9wg23tSLiABdSoe1h+8ot8yzLduG7W0DJbAZEiEbrn0pO1
         8UlRSE4BdFu9P+IyZNP2hbQHUdzmlcyhGKyb8En6Pq8Bo/kJUBGPq6Kq+bnRjNWdCc
         dF63vU0bfyJIA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SmSYr3WpLz4wbQ;
        Fri,  8 Dec 2023 08:48:00 +1100 (AEDT)
Date:   Fri, 8 Dec 2023 08:47:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Andrei Matei <andreimatei1@gmail.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the bpf-next tree
Message-ID: <20231208084758.67fbd198@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2nANb0jHZuV8Ax4TDOEWvFz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2nANb0jHZuV8Ax4TDOEWvFz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  ec32ca301faa ("bpf: Add verifier regression test for previous patch")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/2nANb0jHZuV8Ax4TDOEWvFz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVyPY4ACgkQAVBC80lX
0Gzw1wf+OpNcMLk3Rm7RzEKa6h9k7RoQ/Bp0koSb2U2ZAIcSH2VC8qtaLvKEHggh
PghXq14ESp8gAuCZZ0FoxzNN5AB6z/539yHTavCR86u08XuFRvWHVAfPKopjquTZ
jeawhj4h/FzSTTqjIFOtZM6UMH0pQ3Nqahr2wKVPMGidw6+V9WZ48Y3L+F+SMfv0
QdJS9Mxy03nS6SDq27g1HvawhvURMf1nGNFQ95oABprvWxjvSX0klb5ie6dNSsrT
1F6rpWDTb+pacLpVeQviSTXhE1zAQRdOULrG/uoCyIS1sIXsVTkBEMTBW4dlED8W
jzG2mY5OOfF0yrt+38VLJURgLZ7C2A==
=RWTj
-----END PGP SIGNATURE-----

--Sig_/2nANb0jHZuV8Ax4TDOEWvFz--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44BA755A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 06:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjGQEWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 00:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQEWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 00:22:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918F5E43;
        Sun, 16 Jul 2023 21:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689567769;
        bh=Mtn7eFx1vPmcWDswDmPMTHG5cPK42JFQQtaRdxJCBCM=;
        h=Date:From:To:Cc:Subject:From;
        b=D55LrytywGypr5i+k57BtmL6wiqtLnkjKcoft8SaddaFT6ZpPid7VV6/cmeWHIo+q
         pPdCoNjQCt1Wz2wBvgw0wTI6Ck+Yz8lQBrvG0lTsmnRaNtdBMq2syj/WozNcthlHi6
         9kDMTVExnBR0bWsLoAIkE8UvNUCbWg6SISBUphcyzKinF2d7nUYBxb4GlfzK54AAD+
         AVMl7kM9aQhUkXSpTxQwyW58FRFGxYGzJ7n+3LIRSa/hBy2InlX+IDxIEAAzQRd8oQ
         TrvfaduiWzkGhAdH0fEAzu+Rjr5c6567//G8ZdSrh09dQdpxeZB7Wx8HvycG1UUIOc
         Y5oCOvoZ7tgkQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R487s5cVDz4wZn;
        Mon, 17 Jul 2023 14:22:49 +1000 (AEST)
Date:   Mon, 17 Jul 2023 14:22:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: error while fetching the v4l-dvb-fixes tree
Message-ID: <20230717142248.281e3668@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/72NiNTytFO+qySTv9+k4Nar";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/72NiNTytFO+qySTv9+k4Nar
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Fetching the v4l-dvb-fixes tree produces this error:

fatal: couldn't find remote ref refs/heads/fixes

--=20
Cheers,
Stephen Rothwell

--Sig_/72NiNTytFO+qySTv9+k4Nar
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS0whgACgkQAVBC80lX
0Gxg7wf/VETyXoDwR+OmWp20EAU+kH30abTp+mYpjw2GgXs9rWrOsECCBr71xqgK
jQrkc0ZGtN1bdg/3KI4DdVT8kidLEiH49nHIjWO8SrexySlMbcb7D1+e26SH+d7P
uTS0NaHmaX0kfe4Y6MnwYtF2VJHw4qAmsvARVMC40N2whecmmN3rM3cuvnmwg5kW
pAEaNI4gphG8elFj4MPI9p5Txf08XoHBHPDniWvSR9BLfykpw9Y4cYI86W+K9cfM
xGDhvapnw+71g8m4a9oTNCiwgufhyR8Q3UDakCf+qps8gYGloF9cyNaBUthwoZYu
OTX9fiGK6+ptxU2p9jJAJco+0Dpg1w==
=9XMU
-----END PGP SIGNATURE-----

--Sig_/72NiNTytFO+qySTv9+k4Nar--

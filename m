Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78397BF272
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 07:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442138AbjJJFtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 01:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjJJFtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 01:49:19 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E349A9E;
        Mon,  9 Oct 2023 22:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696916955;
        bh=t15fnIt0tpiMUPAuf8jfVDNlK1gRXinedc/IrU5VPtQ=;
        h=Date:From:To:Cc:Subject:From;
        b=UdmXCO9vC/x/7Ozaoz/VY4lp5nahonNtnsIjDP9Lli9/iXkTe6X/6nIGblmo1k0ZZ
         KqXCy0iZvSj7KtT7hPTN3fwAeh3tmMY5QQ6P2j28cVxG34bGWLk4lM76fpInFA6KHK
         JHYPqGUQySvlQDXD0YocRT8LLBZ2OJv1ZuAFIDaaLOd0n47Ap/KUjmkO69VuQblpZw
         SgSTm0Swu2NEkI3RGc3Y3B1lRO8VCzbFkW/2QOofCzFilq2llvrx/UhNET9aL9WRF4
         taFWXVzeskWx6fdH4HjfUPGtBvKCyryj60eOkeb6I4diOdQotD3SdRgYP4OzEpGoE1
         OCF7Ab47srywA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S4Q2L6sWXz4xM4;
        Tue, 10 Oct 2023 16:49:14 +1100 (AEDT)
Date:   Tue, 10 Oct 2023 16:49:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the imx-mxs tree
Message-ID: <20231010164914.4683ca7c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QjD4FlsDjerN=Xj1tE6mtoe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QjD4FlsDjerN=Xj1tE6mtoe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  c0e3c76a8be0 ("ARM: dts: vfxxx: Write dmas in a single line")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/QjD4FlsDjerN=Xj1tE6mtoe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUk5doACgkQAVBC80lX
0Gz8uwf9Ey0/sphFhzzaxeVYGTHUZ/HnovtMRdj3ptuh7iUMLdnmoYRTDAp+kFI1
j8zwLhw/ifCpm8ht4K0Uyg9Nws3+mDYnKe46KMe6wVXoRGJiceDibJ7WqA1L9GLo
HxR58jq1/g/H1WdrY0D4UI5FVj/4VzpbPiw/0O2eTXCH9wWGjh55ZOEtd8fif5o2
YS3DO+/AIpxN2tZO0Qi50BNVmyP77NrbYaSQFxLaVtljHtCmvzAfspKDR1asPWvY
TXE1qLHAO7jbHEo4QNgtisqVqbQ/bNOk6VyFtjZ0sFOezC8fh5aGWooBY8gB7+Tz
fUXdQU4c3dyfqvxP3YTCc2GsHonbtw==
=b2FY
-----END PGP SIGNATURE-----

--Sig_/QjD4FlsDjerN=Xj1tE6mtoe--

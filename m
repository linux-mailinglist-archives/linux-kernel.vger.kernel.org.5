Return-Path: <linux-kernel+bounces-18987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1A182660F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6EB1F21510
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 21:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4373A1173F;
	Sun,  7 Jan 2024 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gGOhn+7u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0AD1171F;
	Sun,  7 Jan 2024 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704662650;
	bh=2n/aRwotdnmcqK0ic0NDBxAQmo5uIhClUYXIvrG9UxA=;
	h=Date:From:To:Cc:Subject:From;
	b=gGOhn+7uiso6Xczir3XXO61njOj30ZSnmb4mL561QWCLFnQBKvWorxP4j9aZii+Vq
	 5SrYTmiO1p81MR/bVL04ig2nb3j4FwzS/0sdSynIEMa6B07V3i4XZ44Lfm5pAk+W02
	 umbNaf2+2H4d3nJ14tK7xXlAeIvrVm5yysdzTroB4ERORzHr39i5d5yJkb3ZvgUDvb
	 2TWVftN+LZucsK16V/WUo7+kFTocS1LlC1ohkMOTywjEdvHj+hSr2Ka614rAN1/TT+
	 QLlhLMxi6e31vEfZ3naKUTjqrVy8cX3HTKHJVNaUhP7ZIVbbX3VBlUHH++aQnEAcG/
	 Y2l7aTNBUYRig==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T7VZ161j0z4wcd;
	Mon,  8 Jan 2024 08:24:08 +1100 (AEDT)
Date: Mon, 8 Jan 2024 08:24:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the i2c tree
Message-ID: <20240108082408.75eff37e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rqcKFSOCd1JdU6yUHWZ_KIs";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/rqcKFSOCd1JdU6yUHWZ_KIs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  ba6181152308 ("i2c: core: Fix atomic xfer check for non-preempt config")
  e3bcb32ffc10 ("Documentation/i2c: fix spelling error in i2c-address-trans=
lator

These are commits

  a3368e1186e3 ("i2c: core: Fix atomic xfer check for non-preempt config")
  5cb23af38916 ("Documentation/i2c: fix spelling error in i2c-address-trans=
lators")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/rqcKFSOCd1JdU6yUHWZ_KIs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWbFngACgkQAVBC80lX
0Gx7XAf/Y9Sl1iTXCCGqxWMEI5qjvxW8Y7bdMq/nFFOXmGzICAsHqlHjuWpWpRwA
fwnAPG0xWJxmAxJVRcraLmD3W9qi27PUW6JAgJYlnry1MltnuuE5Svys2dnzmh8F
VhYVxkvwx5Uzd4OKhq3k+lvniigyM+JvvXAQnp98SfJVRJhdnQieWNVHV3ZffJSt
mAScpQpKwycXdF9pq8YMISCpgcvB2OoT3jDsvZYeI+Y92N/1JSL3smHB+KpPtNuG
m50knvsXHcEoo87k/DbS0k0KQl1t42bV/J1vibCW8yYGh5240OrnT36MVR3X+aHI
Yr51qimVhbFAi04htkEl703ci28enw==
=ZsVr
-----END PGP SIGNATURE-----

--Sig_/rqcKFSOCd1JdU6yUHWZ_KIs--


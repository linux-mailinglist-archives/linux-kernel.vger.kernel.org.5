Return-Path: <linux-kernel+bounces-19055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5377C826754
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 04:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1310B2133C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 03:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A024846B;
	Mon,  8 Jan 2024 03:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VXHvqpVQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2E479CD;
	Mon,  8 Jan 2024 03:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704682976;
	bh=IS89/SkN86WNNdQRLDW8trsgzd/IVCxj3T7Ic2G2CVA=;
	h=Date:From:To:Cc:Subject:From;
	b=VXHvqpVQAsSI3PyrecpmFrw+a98dOo+Dc8kP7HL3FIvNK6KLFm88fwovJbNS9ASFT
	 c67XHdAWkdraBenjW+pmzPnI33o4pRMJGZD2hE/cIgAylmPH6CdB4m3N5ik6ZE3wyt
	 PJFetoki2y2iNhHr8QvZVuFxfQFvZyEtFVpTXt+qZGhtZwcekC+r+cAaF35lEdzj7p
	 meF3L6c4HNTPbZczqC8wsGeJ24qlSRw8qeF8QvdRLClkH1PJezPazUYfoToqmaCZcW
	 uylPYpBRpGuAa+521MU1qacAUgpkgk+XCF5kdHk3aUnKkJ0xWkYKGtmEGZJHLJdjOX
	 hQESdjiEcB6eQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T7f4w1Xwsz4wcg;
	Mon,  8 Jan 2024 14:02:56 +1100 (AEDT)
Date: Mon, 8 Jan 2024 14:02:54 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla
 <sudeep.holla@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the char-misc tree
Message-ID: <20240108140254.6def2dc7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/La/UTwjNqCFaMe7Dk.TjP2t";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/La/UTwjNqCFaMe7Dk.TjP2t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the scmi tree as different commits
(but the same patches):

  259566503782 ("firmware: arm_scpi: Convert to platform remove callback re=
turning void")
  927e11300d8e ("firmware: arm_scmi: Convert to platform remove callback re=
turning void")

These are commits

  8b12056b2cbf ("firmware: arm_scpi: Convert to platform remove callback re=
turning void")
  66926739f592 ("firmware: arm_scmi: Convert to platform remove callback re=
turning void")

in the scmi tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/La/UTwjNqCFaMe7Dk.TjP2t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWbZd4ACgkQAVBC80lX
0GzKgQf/eyLiTSfjg4adrHtwlxpYK5TgKKcmAXzC2XpQYSKQh46NeZOyOyZ6FQ4W
6fAuY+JYZsgJ/9Q4JdRQJOsnEi2Jt5QSMtkRblTSHB5DSFeiCgwSvu+qXuTlfVxn
OeU1J8qPZkGNNrJkkj7c4kmzjDPoqkD0eiU7zmQt59AFsuwmLRitKLkuMsbcEYgU
zCpribJumbpJjZASjiDlxeQXMLE2hIUZUOtLlQ7YE/IIG0mgp9YWKcoSaocEvzbu
jxjX3rSgNsmMsvACjo8IdhA5IgXVejFDhjWRIv0iocFMQ6h5zoHsjJcUeKSkV4Cu
f1fAY0lkGf82L+MUBVoVM2w78gnXuA==
=lD7/
-----END PGP SIGNATURE-----

--Sig_/La/UTwjNqCFaMe7Dk.TjP2t--


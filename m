Return-Path: <linux-kernel+bounces-9084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F0D81C02F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2874E1C24938
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA25576DC4;
	Thu, 21 Dec 2023 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QISh8r0/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05FD76DAC;
	Thu, 21 Dec 2023 21:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703194406;
	bh=ROgN9h3o+UMyHN9oVG+Riyd5yJvuM05ZwS4D+mUqzLI=;
	h=Date:From:To:Cc:Subject:From;
	b=QISh8r0/GnRE78Do+Phcq95YZUf0R/a6BXnj4rn+3NT0GOo6uBPAshvQ2JhGmdsU+
	 Fuj0UrqIbO0VFO5qsoDW2eDkUWfyYuMQpbdkG6s4N+Cq1VYozIgpVy2AIhxnsNjlvK
	 rFA2iZ4s5HnnI9imMIzf1AZSzuFKj51LPETTosZnd7sTgLUwbLqZr894MQqA4nDamE
	 cszCIN2ViUARV24NGJll8messdsaddYEvsnv1JJLigLZR00YopTOsbQRDI06k4+dmr
	 8CKwo9qmP8QxIBmVp6+Bl+/iVATaCaeMRqPtMiYNTc+2y0gMJX5myIRLzKhtfym4Od
	 tIPb589q9WaXw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sx3ZZ0KGhz4wcH;
	Fri, 22 Dec 2023 08:33:26 +1100 (AEDT)
Date: Fri, 22 Dec 2023 08:33:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Steven Whitehouse <swhiteho@redhat.com>, Bob Peterson
 <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the gfs2 tree
Message-ID: <20231222083325.65755cc4@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/b584IAyaqMhiiF2wwgA2==o";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/b584IAyaqMhiiF2wwgA2==o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  1c47c16d9bde ("gfs2: Use wait_event_freezable_timeout() for freezable kth=
read")
  6650ff05e56f ("gfs2: Add missing set_freezable() for freezable kthread")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/b584IAyaqMhiiF2wwgA2==o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWEryUACgkQAVBC80lX
0Gw/vQf/cUGxKHBHo992dKTip5hXTJ+vGbegBCdxSJ2T2cUhjdYn6ecjLtIQIsaF
dmE3pWqI74DBbh8+No1rqvWz4i3w3ydUgv72xVtsaYtfn3mYOg+g3yV5k8QVqVgG
Amjx62DBk7lyyc2jXF9gieltbiV18V5aBC66UWrzA47+8FOEvml5BhdBfIKl5upd
3jSXhxJhVn5jvY119buRa2yt/m3hJT8/4zWhAgJzRm/OwhQNYTNUZD7PzymxsVvz
SALNZJ7iUmhtcOqDB9zSKK5hlTdGrQ5gVDb280UiKwWp00nqXC68xoIuOGW4J1fQ
QAnzjK/OJY+BBjRYW+zx92VIGN67Kg==
=Xdyy
-----END PGP SIGNATURE-----

--Sig_/b584IAyaqMhiiF2wwgA2==o--


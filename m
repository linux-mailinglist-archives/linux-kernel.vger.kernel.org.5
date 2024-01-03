Return-Path: <linux-kernel+bounces-15152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5252C8227D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 05:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A291F23992
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 04:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B0C17984;
	Wed,  3 Jan 2024 04:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rsgKeuDp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA5517980;
	Wed,  3 Jan 2024 04:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704255827;
	bh=Hwd+zZvXse8ub3U4HOeLtDqAnCuwL6bTlXAfwEOFs94=;
	h=Date:From:To:Cc:Subject:From;
	b=rsgKeuDpFkXLQwsBRFVOn4SutO7hrlDkPf299OUvNVjITS1+Lar7rHh8WgFPANJIg
	 PcyKmIrvYRpujTXrAPDEFatNAmSSay1So5Q3Yc3Uz5b6TzzI9NCEf5PBNzwZTo0fEQ
	 XTelELDUhUExNApC0NJZ1BzBZ0ngMpd6oS1vZhH2tUxBGA/U/IB9BLN5hNmTeiL0xq
	 u3sW3F7wZuB1pjQPgQbe14OD/FuH7ORwhdz1tWfpQ2bky20AglOoPijRBmuxJ65eJ0
	 qMW1ypr4JKEr63LqRJAsLOEdf9UwiWodYZv3r63kGoxKMyAP4NlM9ejJXDmv3VylUR
	 l6FBF+ihZPLjA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T4c6W3GTNz4wx5;
	Wed,  3 Jan 2024 15:23:47 +1100 (AEDT)
Date: Wed, 3 Jan 2024 15:23:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the nvdimm tree
Message-ID: <20240103152345.116ce8c7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kZXfMmgQ2cjzId+.O0AkMK5";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/kZXfMmgQ2cjzId+.O0AkMK5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the char-misc tree as a different commit
(but the same patch):

  ce2fa3e597dd ("tools/testing/nvdimm: Add compile-test coverage for ndtest=
")

This is commit

  fddd9e3e4e71 ("tools/testing/nvdimm: Add compile-test coverage for ndtest=
")

in the char-misc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/kZXfMmgQ2cjzId+.O0AkMK5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWU4VEACgkQAVBC80lX
0Gyeywf/Y9L0oS99M2ZJryUkm6UqSedWuLdn7IxbnWMkxhAd9UJ4eQXieQxxdV43
zKXnqyrNmXZOLuBP/K9D9M7k3pFTUkwZxlDFKs/K7PldAYMUza7YVdB0cvN29VtI
v0ChBCZCOdWf5jmEhLwb2GwRfSVtWQQK+4GvcsZUQYVzgdxMQkkyV+JQuTnV12Tx
sK8BlJrYt5ZvZ5Sz6kWZUdhYc0GLuL7qRq8RmMXk4d0vTfhrO3NUQgDGgmbK6a3L
5nhnv4W1qNgCjQTiyZIGwTgGV7Oh3lWpOd6b/t5lmundXPbgH+dumhKtr3r4d06F
S6ryBUf3AKDTnkRizJ8PBLHlTRoeJg==
=nWI2
-----END PGP SIGNATURE-----

--Sig_/kZXfMmgQ2cjzId+.O0AkMK5--


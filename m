Return-Path: <linux-kernel+bounces-18986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0C482660C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E5FEB21072
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 21:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EA31173E;
	Sun,  7 Jan 2024 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bYeQZhoK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1411171C;
	Sun,  7 Jan 2024 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704662394;
	bh=+fD53AH3a1V+XLZIZelxRHEvG5WWityY0cTZdrLFVCU=;
	h=Date:From:To:Cc:Subject:From;
	b=bYeQZhoKZ5l8CcxSdBS6pI5190QnSe4BKfPEoD+hEjWOqzu4uAxYwIihyZcBPfOHJ
	 ElhwiFw2lV5Xy0E562swPT6DASiMO8zfNQ7PRoyuVSj3NJOinWzWUFWL2UkAzsvghz
	 To6nOiY9SrieoItzTFg3FpV1RSQlhYlhc2+XE731/dtJt3FBJ7ZDAJx+AcvnNfyh5j
	 h1rBjQ0QSKkGcli/THpV7W09QfTyr8ckRZl1Bjj5s9JF1Xkq7XhoYfXLeGnEevziZd
	 STkZ++VrbJjBstXJLC2wHQg5rEQ9Q/WkJhSO99oNVKd5dCiDiuWHODrX8GUY6ExwNu
	 fGbJslSyFsFjA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T7VT60BBmz4wcg;
	Mon,  8 Jan 2024 08:19:53 +1100 (AEDT)
Date: Mon, 8 Jan 2024 08:19:30 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the nfsd tree
Message-ID: <20240108081930.78bad29a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Oi8Xv6STdE3Msa6aU4IpUYA";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Oi8Xv6STdE3Msa6aU4IpUYA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  76d296a82657 ("nfsd: drop the nfsd_put helper")

This is commit

  64e6304169f1 ("nfsd: drop the nfsd_put helper")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Oi8Xv6STdE3Msa6aU4IpUYA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWbFWMACgkQAVBC80lX
0GxgPwf/Z1BFpdBQJCbWnjt0goXc5Ubt4n8PAM/TCq3ndX3ZQ6AnKC7ewlr1jAZO
ef/BPONdPHRwkQQPkbCqDl+WaZn5aPCtYCV1d0rmR517i5NKkh6xO398YuvGM0PB
SfKc7BopJ0Z6jGgJVqMPu9u13OOj4QyYnLah75M28nrJBMEUq6NzKM2S4/NbvUkk
yyp9kx1BRgIldVNCCqh8S5aYAfIZoTqS1IUnPIIC2iXU4g22eiCIELPXNtmlbInk
LBs0Pr04Fw9pIz5Kux+JxzPW06T1XXZDK+tKxWXEUxVW3gnq2ks24pck0Mqop+7H
AW3M8/+T8jF8cZqIb9lZPVNTjqt4Mg==
=m4Ak
-----END PGP SIGNATURE-----

--Sig_/Oi8Xv6STdE3Msa6aU4IpUYA--


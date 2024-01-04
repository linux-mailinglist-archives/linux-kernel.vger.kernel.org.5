Return-Path: <linux-kernel+bounces-16278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C407823C18
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B210B24E50
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C2E1A73E;
	Thu,  4 Jan 2024 06:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RhlfrsAE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1ED18EA8;
	Thu,  4 Jan 2024 06:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704348709;
	bh=hAIaB898xe/wnXvNzE2oxDe/9/uI6RykAPXZrSe/qUU=;
	h=Date:From:To:Cc:Subject:From;
	b=RhlfrsAE9IkDXXIn8eu1GeIKz3xDHXbMINIcxWpgcB8Pq6uEvVK3ITodb7QMTCZUQ
	 N6ZB3afhC5/TBoLPMPR4TSMWjaAbcHAv5o7UsO0X3aP/d+6phw1r3QhycOZfOtbGfH
	 s0HZ8aycD49Y6Akxz5PcNiJtKgsYMdU+A3EE40MuJ0QdcubzbJNgQd277f7/TYqnmW
	 sQgiOQpAh7jhF1sRf4DYF/hzH6vn7qdG3jcetpFQWRmlZviTqMz8Gx4E16dU9oYFOq
	 UMoctBw++cb8vFv40r+A56KqD7R5XycMpP53Oj2EA/H2/qk4x3/0KUXh/Os4x9h+zH
	 mR2JZ+p8YdChw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T5GSj47Wpz4wbr;
	Thu,  4 Jan 2024 17:11:49 +1100 (AEDT)
Date: Thu, 4 Jan 2024 17:11:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the jc_docs tree
Message-ID: <20240104171148.5ad4dfdf@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QtnQbPZY5tULpZ/HyF99b1W";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/QtnQbPZY5tULpZ/HyF99b1W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  8fce865c2eea ("A reworked process/index.rst")

is missing a Signed-off-by from its author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/QtnQbPZY5tULpZ/HyF99b1W
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWWTCQACgkQAVBC80lX
0GyZKgf+NEWCn0kcNnbXAesg+eqc0Zc7tXf8XiTkGfxy1t5MsOHaEd7YQjV77GyF
KEQrk7SAe07X8YKJ+XrUrQkDPAL89feygh/El4vxPzCv4lkTCD+9I5yfNS7u0i7X
cg72Wg2eb7vCoOsJrvRG5t9/bgqVH4oSXQ9KEAhgyro8VlEEXif7W2mbgVEYJOhE
kcYHAcfPINPNFtAJxD7XoatZ5Ri6OjHk20PtR9e7X7xmwOk1DTQpM39Bu5Luo0Xt
rXC8aJCsCTr/bTjiiHBDy/xUgJitdCFanrVBWnC6gpi8CNsBs/ZC7u39Z7CSW/F4
wF/18eIYmFZNsCeheSskqg+dof+4rQ==
=6JEN
-----END PGP SIGNATURE-----

--Sig_/QtnQbPZY5tULpZ/HyF99b1W--


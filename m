Return-Path: <linux-kernel+bounces-13886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF50182143D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 16:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1246281C4F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 15:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BC863C3;
	Mon,  1 Jan 2024 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="a4tQRYGN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9906107;
	Mon,  1 Jan 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704123319;
	bh=D6Jimca1ki/Zt/pPbHd/s6KTJ3H9Gnnwp/PlULhpxNk=;
	h=Date:From:To:Cc:Subject:From;
	b=a4tQRYGNNHT6URDIOLDf9PZ9v3ndIE8AoCHjb1RJ8NkZrVzYGz0BEN42kCVsxDoLl
	 d2aIatKa701+uArriYgJukl2hjnHDnSlSBgjR6KBz2GRW9QHeJxC35N7YLB/MiiHfZ
	 A/K2fX8VYpzQDqwA7kwECThLZwr7rfPj97514XHFf/QIarWuTXEnHP/QT/aAnkl1bH
	 ZnUNTX0HLR7H2TWoxHWfwj0HmNKKz47gBW4oY4EeP7gZalQ/nI/2Rz28Sv0yIJEajy
	 tZLtgwclSCuM6TYn9mbfbIycJcZzlfjTGH+xd5cIdkhg3re5lxGMaGIIvGlzlhRjSI
	 IX2rwRxUQfgRQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T3g6H27Xdz4wd0;
	Tue,  2 Jan 2024 02:35:19 +1100 (AEDT)
Date: Tue, 2 Jan 2024 02:35:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Howells <dhowells@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the afs tree
Message-ID: <20240102023518.50c7f729@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j6ahBeaeukeb8xe7ia+_tKF";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/j6ahBeaeukeb8xe7ia+_tKF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  9174b2995e9b ("afs: Add some more info to /proc/net/afs/servers")

is missing a Signed-off-by from its author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/j6ahBeaeukeb8xe7ia+_tKF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWS27YACgkQAVBC80lX
0GxveQf/f79DHcuUr0SpK7ERJhlh/7hDf4b5MF65gq64Gs98AC1uxmqsPu6IDMi+
MxWbw+FD5GYV11QnSbKxVtE5SGSVQ9IzLBHBOfejPQd0n9epVmn4ehwRTIWiPYWw
1im+GdPo+C+MgR2X0WN+Nx/FiUqe2gXK3i3AuYC8i1gciK8WvJd+gO2Ov0NaPZDU
F67/N8hunnvCw1gLxGrETG38qY2Yv87irDQGRW9myL4uzC96GeETT7dSX0rjOLWc
d1ZVpYpTetZsPwUSbVK5Zu9rc1NuRbq4V4dOMnR3p+NveOW4WR6PNZW99PvEmxAa
2vruso+NN8vABh/e6SFXsaGXmb3HZQ==
=pn7Y
-----END PGP SIGNATURE-----

--Sig_/j6ahBeaeukeb8xe7ia+_tKF--


Return-Path: <linux-kernel+bounces-9268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B703E81C32D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573B01F25413
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E1115AA;
	Fri, 22 Dec 2023 02:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iSlkTf+V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEADEB8;
	Fri, 22 Dec 2023 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703213358;
	bh=zHqTfqRrRkkRH3Pd/RJXPiz8CB8Mnx6eLDRXlFc1HUU=;
	h=Date:From:To:Cc:Subject:From;
	b=iSlkTf+Vl59y4uE6jcqYPpauXi0DJ1y6aaU2yXX3GwpwRF1rdKUPGHeeCRt3KkEXe
	 2ZiSNto8g+TZHOp6JiB6Ue8dnIXWUC0lnVMUrfErmE5xafBUZE/f0taBTqzFPAflJ3
	 oOz+6PS8yHKAUZWeNs/Knais4dMlZtD3xtfW6QZpD9OgYijXmxMMsBNMr9Ql2zdQPj
	 zZCyMEfOtH9DhWZOnf9PfqvW+ACAfXGEU3V9+R7vYDClzAWH+5yyhpzd3LWWiggrIv
	 7DXRM1h8240DJWeegDgriHrbWz5Q4lNSN/PsSHQDHpFYS50bIeO1b7bNwZxgI7SRdB
	 2ghaTqHugONxg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SxBb06jZpz4wd4;
	Fri, 22 Dec 2023 13:49:16 +1100 (AEDT)
Date: Fri, 22 Dec 2023 13:49:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Olof Johansson
 <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc: ARM <linux-arm-kernel@lists.infradead.org>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the v4l-dvb tree
Message-ID: <20231222134914.74698b92@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oD+pfR4cs_eJ43hrjqgqE/C";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/oD+pfR4cs_eJ43hrjqgqE/C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the arm-soc tree as a different commit
(but the same patch):

  a60577cef7de ("media: dt-bindings: mediatek: Add phandle to mediatek,scp =
on MDP3 RDMA")

This is commit

  a17cf4c6de2d ("media: dt-bindings: mediatek: Add phandle to mediatek,scp =
on MDP3 RDMA")

in the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/oD+pfR4cs_eJ43hrjqgqE/C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWE+SoACgkQAVBC80lX
0GxmMwf/XOV/MD4iZy3Ahg8Ao7vdCa2pMZwblBVsIpqiECtHovO2mLlLBpXn6lCP
y3X3uZk5yhZGSardQgaDE0vpWWeMGNpRUX6lBA/HUXzMA8VMdB+PmKWjHoPrkY0Q
iqt3OrfRC3tmVS2mFrPcLH6cayO8bAG7e2vLqmDi5jRLHNvNKsXgLXwntXeXz1XU
YVJpnHT767Bm84bZy/TroEAfs04C24Ja4UAOyri2PpU9VVRWJLsg0hwmtdX+VcUn
ZBLNiPyHP74DP27tx+fCtY8frw5DY+XuU1O1Z2njd1/B76VX6ZUbCt/ysKgm5CqI
ZFDKQOTHNpmWodRdqK1aju1GnQQmYQ==
=xB7c
-----END PGP SIGNATURE-----

--Sig_/oD+pfR4cs_eJ43hrjqgqE/C--


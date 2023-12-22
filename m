Return-Path: <linux-kernel+bounces-9279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0B381C350
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA9A285E08
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF79B322B;
	Fri, 22 Dec 2023 03:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="URSL9moc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD8C23AD;
	Fri, 22 Dec 2023 03:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703215002;
	bh=9Tb4PEOaphA9H1d8fJSoVdGfWYQsVFAle+iUF3HvgFw=;
	h=Date:From:To:Cc:Subject:From;
	b=URSL9mocAq0Mx8Rhnuh6fL6vU/Dc4he2NFgEsRHjcmRZCZX8INN4ocYLJzRtHVoX0
	 7bZBkjuoeiFalB69dN5Ww3GLmtj8QchS1frpYaGBusAK/eEx5KSXfDm3CCK1t12HyH
	 F2di773H5c4R9Gsa2CMhBQfNdqlUHus7Znq369D8ZFdyZtJr//leyytXHCSiDBAGPZ
	 2Kst755SqKmYPL69mQhafRcnBBnFFhzARJ53jkOx3Rw8EwjWDCRHGTHn6QfFepV/PU
	 cNp5PqBxCHL7HmgyPWHhIDxdUS5IfD+IEHFn2OQ9jixbsB53qLEooEGqIqX2BqCUKH
	 gL1JEg8yF+FnQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SxCBd2vCTz4wcH;
	Fri, 22 Dec 2023 14:16:41 +1100 (AEDT)
Date: Fri, 22 Dec 2023 14:16:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
 <rui.zhang@intel.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann
 <arnd@arndb.de>
Cc: ARM <linux-arm-kernel@lists.infradead.org>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the thermal tree
Message-ID: <20231222141640.5d21be60@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.8nzwvpvQUK3BR+c4UbF7_G";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/.8nzwvpvQUK3BR+c4UbF7_G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the arm-soc tree as a different commit
(but the same patchs):

  4d8d0704a46e ("dt-bindings: thermal: convert Mediatek Thermal to the json=
-schema")

This is commit

  10bbf22de75a ("dt-bindings: thermal: convert Mediatek Thermal to the json=
-schema")

in the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/.8nzwvpvQUK3BR+c4UbF7_G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWE/5gACgkQAVBC80lX
0GxsSgf/ZKTxpqTj2ahlx4GT5DXe6vx+E57p17FEGPJ2iTbd0HvUrZmYbuqCG/42
zuOhVXOVIiH5JyXbWKPuxIxpNtyyNR79ChK0TEE5ZPDHlln+M6KRbbefbfdGBvJc
p9fd0UQE/sSYfdUA95YVWLS9TSpGYkXhxYCdiULxubCiYpW9dTXYYU3HeGXmaXq1
VMTucOS8gr51e27wtmAu++6lusx42aWpWr+mjs8UIIjyMaA9Hl31K+x+LUQPJkru
RvfTYCJXxq4kr8n0+xnOATt6aJ4Fatx8P4J8KZ8nKnQWp+A7smjwtGhjhN6ZtKsY
E5ib03EgZZcDxmFI3/3j5VPVPqXzjA==
=QfQp
-----END PGP SIGNATURE-----

--Sig_/.8nzwvpvQUK3BR+c4UbF7_G--


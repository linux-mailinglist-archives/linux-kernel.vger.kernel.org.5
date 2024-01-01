Return-Path: <linux-kernel+bounces-13883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B97821435
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 16:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1D81F216DD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 15:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FAD63DF;
	Mon,  1 Jan 2024 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rP4k+Ji9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9B76108;
	Mon,  1 Jan 2024 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704122804;
	bh=hJu8Ajw47RLmWRYP6jdwoMUC6VuLpb6xCgkW7TDCe+s=;
	h=Date:From:To:Cc:Subject:From;
	b=rP4k+Ji9Y7faL4v62IebWFO/xN/2Y7uZvCYJ57L7/tmkVu0t+qPOXJ354vhSIsnMu
	 40z1bIO+MTq6DmA3DTCXG1M1hBk+QgsTwbTCWJl5e2JpglWvPvppLTUb+yqYBK+tpn
	 iB4CxbSL7RljKelmkNdeJ6M2G7AHpxY+pavVrcxPyIfixRZYfz1VNFT7bhxMtNjI+T
	 3+EDEi7BdB+Nu7LMArWvm/7F4xR3jLr3B91OTJKyNAzhV5X8rFDRXlLK2aKqlSEIOW
	 Zwooz5uneMMohdhksvUFX4IWAOuLalsO5pxaCEZt8ia5ug0OA4TMNMRyuClfxqhwVc
	 NmwC7tet5lkjA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T3fwN2gDdz4wbk;
	Tue,  2 Jan 2024 02:26:43 +1100 (AEDT)
Date: Tue, 2 Jan 2024 02:26:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Sagi Maimon
 <maimon.sagi@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the net tree
Message-ID: <20240102022610.3e23e82c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/l+MbdyZD3uwsMZgwz/k33.Q";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/l+MbdyZD3uwsMZgwz/k33.Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  97417cd79ce1 ("ptp: ocp: fix bug in unregistering the DPLL subsystem")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/l+MbdyZD3uwsMZgwz/k33.Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWS2ZIACgkQAVBC80lX
0Gw4Ngf9Gq1SXyEZKygFN/xi1x6PlahX4MO5I0gxGtWMWtdijIoGEGuz29420hAa
HlMpUyaGRhYxOOSQ6DYEgrjUL81IwsaJeZjhcQ8hnJkCc8yCLcGWlCa99L6584/Y
Lj2wudw9fzb9xclk0IhJ7v2g75FX/ElgUFFW4vUdrR4rN+/nR/HC7f2rWLf6eOgL
3KDXq3QSTTi1Mj3yBKBQKk5XHkiCHUbjxpwcKPdEiv74KnKlis3+LfDIMyJEE1Zt
UBsxV+2Yc5uTttz47MXHE0LjHjCqdroc8T22SC85xyHr+ZTF462MfT16EK3mKvWU
3f+ufvcQ7OuyqxpPEcbgh6W4JaY1FA==
=4SIt
-----END PGP SIGNATURE-----

--Sig_/l+MbdyZD3uwsMZgwz/k33.Q--


Return-Path: <linux-kernel+bounces-17230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6599D824A2A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1FADB23CAB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A87A2C6AD;
	Thu,  4 Jan 2024 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lOwG5ZF/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9CF2C69A;
	Thu,  4 Jan 2024 21:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704403178;
	bh=fujCdHQHv0NgQ2SbS9qqMKryEJ+V2cKmbOSdWeBXIEE=;
	h=Date:From:To:Cc:Subject:From;
	b=lOwG5ZF/h5D/smG2QSXd/ytq8vvFK3b0itD+CcSTA8odqR79gMS3dz5BZq3PTf1Gd
	 q5YIyaVsj/AVD1U9/rxZ+cZpMZcEvU4TLnouOhHmWYSNiypmQuyxjEdVfE4RADK9Wh
	 cAN73yNFFKw8gpJcFa6thvHsfg3/i18P57BNzJHr3kMBF/ZM4HrAleVXMVgs4+9hZh
	 rUz4cHAyn/1Tacn4asDX7BTE2wBRV9UJ9PriQttd8fUH63RY9uz/XFXEiN9uJF1inV
	 QJ/a7m9PcjimbWsZ11eA5qMTDincHfkw11Z94hcisu5ccqNSJY4mMjFpDltKEAbCSC
	 rcnHtLBNlELlQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T5fcB473sz4xCp;
	Fri,  5 Jan 2024 08:19:38 +1100 (AEDT)
Date: Fri, 5 Jan 2024 08:19:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: David McFarland <corngood@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the pm tree
Message-ID: <20240105081937.25076977@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Sl2CPoQSajVgk3aiN.EZ8=l";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Sl2CPoQSajVgk3aiN.EZ8=l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  e2605d4039a4 ("ACPI: resource: Add Infinity laptops to irq1_edge_low_forc=
e_override")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/Sl2CPoQSajVgk3aiN.EZ8=l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWXIOkACgkQAVBC80lX
0GzPsAf/XTCKWl8iym9GiQlzoTrl+cxUwrK2ki6SHXZ9oNuKjexfict/sNyE2ql0
CVHqGFhEut3mZyE7uKh4QlQbCKROTZHu2HVOjKEJ/l+M7vmnxLNk/dsP9uVxx26l
987cEc4qUIsq9ZNlLJES5IzaUOy8PmTvpYsICjQqeeNKwDb8Pqwx3EPLfTswEG0U
wG681g+rxNstHPzonOz5y3bOHkKBP+OgyNhgVWMJMiB6roQI9MhIeBjHCfw7iZQ1
MRlyO80nXiax2ANYOQN7v2kN5zHUNIT6Py/mG1rPUm2ZsYiQucDuGl4xm8+gT83I
8m2iPdKrf0ZnasZlPnv+x1OSv/ugbQ==
=s5Vz
-----END PGP SIGNATURE-----

--Sig_/Sl2CPoQSajVgk3aiN.EZ8=l--


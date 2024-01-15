Return-Path: <linux-kernel+bounces-26488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ED882E1EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B03828398A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2714C1B273;
	Mon, 15 Jan 2024 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nf66qED8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775221B263
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 20:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1858C433F1;
	Mon, 15 Jan 2024 20:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705351385;
	bh=+eQ0kF1MwZjHgJQa48LmF5DC4WqnFHtOw230BvYc0aU=;
	h=Date:From:To:Cc:Subject:From;
	b=nf66qED8hosljTU5luuloxRXLdZeaklVCMisE3vgP1pUSYC5zbVc4CAUOLv+nbZCx
	 s6ep1k9eppm7mSF1hbLPbcsXwoaYB1+txLDmsuoDlfFlVzZoSW6aAc4GYCo2olDePX
	 0wrijGkhfwrN/StgvIleSVldSMxhK6OYmeIs4djOvIPznYH/IEOAaz+APyIhwD4hKm
	 0SOCan+LvQwUSBPWWW6eDnV6fs6OzLUllwPnwiuQ8xvbJp+Js2oUyxy2SNoU44dSV1
	 Nn5EWeJNMlBRj3aOb0vVJ2oViVziCV8AbN5C562nXm9n+nqLAHCDn1aqdo7q45DTF7
	 UGx8lCMdShFFA==
Received: by mercury (Postfix, from userid 1000)
	id 3C23F10644D4; Mon, 15 Jan 2024 21:43:00 +0100 (CET)
Date: Mon, 15 Jan 2024 21:43:00 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] hsi changes for hsi-6.8
Message-ID: <xnu4qtvu45nm2eu5kq5lkyvfizbiaibtjag7mela6gmisxfu73@zlhfjzqbcmyl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r4pubg7ukyhd3onc"
Content-Disposition: inline


--r4pubg7ukyhd3onc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.8

for you to fetch changes up to fa72d143471d04ce3055d8dad9743b08c19e4060:

  HSI: omap_ssi: Remove usage of the deprecated ida_simple_xx() API (2023-11-13 21:48:46 +0100)

----------------------------------------------------------------
HSI changes for the 6.8 series

 * modernize IDA API

----------------------------------------------------------------
Christophe JAILLET (1):
      HSI: omap_ssi: Remove usage of the deprecated ida_simple_xx() API

 drivers/hsi/controllers/omap_ssi_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--r4pubg7ukyhd3onc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmWlmM8ACgkQ2O7X88g7
+pra5BAAg617YEgAhDXAFA5BHwoCd9qPMc5ySfI1MF08HPlBxr8YJiZslcgKdkVi
rNZomQQQEDOXQ2ZeNNiuoJr2w/fTB4SsKofK8DTnlqZlC8l2cFj0RpvJa3BjbEo5
JWqzR4PGEEoLqVD0E61S112WRkjNAoYVlbnzYnSW1Azn9YoKFV+KpsvObAIowk5a
JXACi/FAQzxXfynLK9OcKzV/RIm+LFHl2rx9YvWhvOch4wEAewsQunvoT4Jrk+zC
mpmSYppmZbsuiCnqUinRGB9Brpa00AzSdlk8fk33JYF3MhVTmfidnbf+yQ3tjleb
irqa0snJAmPYz5G09+RmfS7n5bvs/OHEiDzdGVcUHdpl+8EI7ZGgDEubzt1Nmcj8
lAU6bYgHqZKFZHZ2MVq0uU17iiYNLnNy0CShR7kdmfbGO/cm82LASKsKDxIpRFFS
iv37ZfnLuo+cIrbve1ZQeZhf5wlent3LmmxgmN55Bf5GYjC/jatUAgT9CYx6IGp0
WLy9d6cUYnb2yNUYkGrwXm3i98oIFv5Qsh8JvPcJ8eQigC5vEQQcJCJ5cnfcIWNE
pyjJu7Z6T4nEVwfOu4olgxbSmPg0Xg5Zlg4fLgjma12xIZqmhQ3BLizbmMu9HLI+
2r7VkM+msh2xRih/Wn846txK9Gq6Z5PSgIVslYn5MrpH5Ui16cE=
=Tz35
-----END PGP SIGNATURE-----

--r4pubg7ukyhd3onc--


Return-Path: <linux-kernel+bounces-13888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF253821441
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 16:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B85281DB8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6248F5B;
	Mon,  1 Jan 2024 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JxHRPZFm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3428BE0;
	Mon,  1 Jan 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704123629;
	bh=sTNPU00RZdL+kGV/+OIsP9cSnvAS+K8KYC7jYkrJS9E=;
	h=Date:From:To:Cc:Subject:From;
	b=JxHRPZFml0vI9v0qMQnJNqv5qoZ/l+51qioIO4hXSN0Cur1mkjDaOtBuerEHgv7P6
	 YZaFWL946LPElGD2ESBspAjXTSGIwd+DO2sGrklhBnlUqA2aOTzbDjvkkZBDrMl+Rv
	 7QnsvhrOpomi1h0MjwWlqXGHUXixyAdpJM0nqG4ByTg+R4C/6gzdstoVCfNVgV7QlA
	 4TC1TnBzmc5OiFGPYjsNUALpJ7zEmfUphNwWvxE0ZDmiX78jNp455cUit7ZLRiM5v8
	 S+WoS92F5FepUGAR0CQsXi0cgGGFJkzbCVcxkcOrYvAWJv49KYicyU9Jre+ehfUOQf
	 aPwERGHraJ8HA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T3gDD6W6Tz4wbh;
	Tue,  2 Jan 2024 02:40:28 +1100 (AEDT)
Date: Tue, 2 Jan 2024 02:40:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Yury Norov <yury.norov@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the bitmap tree
Message-ID: <20240102024028.143385f4@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mLswZ3w1ZasX=VzAXT+gNuA";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/mLswZ3w1ZasX=VzAXT+gNuA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  6ae0831c4b17 ("bitmap: Step down as a reviewer")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/mLswZ3w1ZasX=VzAXT+gNuA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWS3OwACgkQAVBC80lX
0GxVPwf+PqMpUv8iK00kHLoTReCYZTvBgzmPqXoQup5tBBBMiLN6i+fHNYav2zt6
7dw4ULjnKHFefH03iuLF+zWmt7zOWbzNZ1guxVPgcz1iYxq+uvacgo2PGBXjSaWM
MhthJa8aqQWz1mizUeHlaxaeolyTXASk6oGf8pnAM1xUr/Jagxr8XmdT1EaJ8LJQ
MMaxfLmfcXN6oBd8qgDM8qdMAeN6w48ThOZKdMHK7sbyPpJ6lcMApJCe1fHWUmaY
xAW8O027xfcLEaAQq72CKY29tZmTKCK+Golh/lGi0i5SxH2yPXfbbFgVGdOnNc/x
QKHweIeT1td94J0k60E4dgp+JrGOag==
=yl37
-----END PGP SIGNATURE-----

--Sig_/mLswZ3w1ZasX=VzAXT+gNuA--


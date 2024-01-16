Return-Path: <linux-kernel+bounces-27113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE72B82EAAA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3279C2827B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31CF1171E;
	Tue, 16 Jan 2024 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="g14Iud0B"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63133125AF;
	Tue, 16 Jan 2024 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 271DE1C0050; Tue, 16 Jan 2024 09:05:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1705392353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=WBGF4gVOv/ed+hiuKKPnVWXHf5Olduk3NAKcNQHFWI8=;
	b=g14Iud0BTZHwcMztQksSJ/I1rbO6CZCNN83gTEIUFpOh+fmjYRnLcQ0fD5nqVeOuY7Rwwd
	zypw45YcVdLnYYqxN6QmNsPps6OL9DQ3t4Kf5eeuiEZLCC8zUXw9BUefS52iTvkalOmM96
	kSYtoO7ZshCFd8vv3of8aansPysPUXs=
Date: Tue, 16 Jan 2024 09:05:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: fiona.klute@gmx.de, phone-devel@vger.kernel.org, icenowy@aosc.xyz,
	martijn@brixit.nl, megous@megous.com,
	kernel list <linux-kernel@vger.kernel.org>
Cc: alain.volmat@foss.st.com, sakari.ailus@linux.intel.com,
	linux-media@vger.kernel.org
Subject: Front camera on pinephone
Message-ID: <ZaY44AHISMIh8fHM@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNK15uz8i9vCbNLg"
Content-Disposition: inline


--PNK15uz8i9vCbNLg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

In 6.8-rc0, driver for gc2145 (front camera on pinephone) was merged,
but we don't have corresponding dts entries. Does anyone have setup
where they can fix it easily?

[If you have hints how to set-up pinephone for kernel development,
that would be welcome. Currently I have mobian with rather old 6.1
kernel on it, and lack of keyboard/ethernet makes things tricky.]

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--PNK15uz8i9vCbNLg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZaY44AAKCRAw5/Bqldv6
8ur/AKC40reoiBx4FnM0vZDQviPtq1ZgzACgu0KdCzOKe5l/sx0jz9kLmwuwBO4=
=uUgw
-----END PGP SIGNATURE-----

--PNK15uz8i9vCbNLg--


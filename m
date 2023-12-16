Return-Path: <linux-kernel+bounces-2157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D588158C2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC606284561
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 11:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA9D156EE;
	Sat, 16 Dec 2023 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="azyNhW2M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD38134AD
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 83D161C006F; Sat, 16 Dec 2023 12:06:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1702724774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=Gde4oM+psdKiVr4K3YMK61om0tk4TTO4qeppoReXLjw=;
	b=azyNhW2MwyO4zDKtu2fGFwn3WX3YtEZs/45Ec6riIy02LNt/8cpzo+C9PvGhAbpZYgvB56
	eRoaveb76KvRAAX/lC9ual2unOCo93keL9zlx+tjUrphlsCsudBTccaqOjoTeeKwIA+vne
	G1dWI07TbnNc+OhcvxDckf2+PxCanuI=
Date: Sat, 16 Dec 2023 12:06:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: megi@xff.cz, megous@megous.com, samuel@sholland.org, maxime@cerno.tech,
	kernel list <linux-kernel@vger.kernel.org>
Subject: pinephone camera work, video out in the bundled docking station
Message-ID: <ZX2EpkwlCdrHaa3v@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aKVPw8CyPIdkKDdP"
Content-Disposition: inline


--aKVPw8CyPIdkKDdP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm currently playing with PinePhone, and I'm hitting some issues with
camera (like libcamera not working without workarounds, and only
working at 8fps with them). I run kernel from Mobian so far, but I
wanted to ask if there's some more suitable tree than mainline I
should look at?

And second thing, I believe that bundled USB-C-dock has some hw
problem, and that Megi had a workaround for that. Could I ask for a
patch?

Thanks and best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--aKVPw8CyPIdkKDdP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZX2EpgAKCRAw5/Bqldv6
8tXaAJ9yr96HYz2H1G4lPzH/qGgN1Zy2rgCeNH1jmKWUDPZbiZHXqTjcGWlOxm8=
=V8oW
-----END PGP SIGNATURE-----

--aKVPw8CyPIdkKDdP--


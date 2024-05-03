Return-Path: <linux-kernel+bounces-167435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 187138BA992
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755E02827A8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A169B14F9CE;
	Fri,  3 May 2024 09:13:41 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1C6146D4B;
	Fri,  3 May 2024 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727621; cv=none; b=sVdRoV+YQaY5QhuiBwyawOSeB74hVe3+pxySKf6v4ejzGBatqAQv1b5kKb6gEudFovmQ4PoC5yzOPp8lfOJyew6Y6NCLXHRLzBsPNQE89reCDBB4UBSYQOLGKLtdnooBX/jlxnAIkoCRZUOfxdx9OCIQhyHPLvZYB8vb8q5ZcMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727621; c=relaxed/simple;
	bh=5kmcDvndxpWJvK1j+kbwiA6maVn0FHPqXzkdAWGp8dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWvYW05mU5mZs5fEjHIp6R9XiNUw5c+8iztcT9SW9G9sxr18RddCHkGoI9CAY+FdyvhHgCsqOGzOBuoK+QB8/LPzWN5XM2ZXeNRuOZ/7mSCJ3H0/x5n0SqrO6qVj4kkBQlCFTtPzbmSiOlUAye6YPGO3+VVfFC9GULQ0H6bwgwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C07031C0093; Fri,  3 May 2024 11:03:55 +0200 (CEST)
Date: Fri, 3 May 2024 11:03:55 +0200
From: Pavel Machek <pavel@denx.de>
To: Daniel Wagner <wagi@monom.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>, Pavel Machek <pavel@denx.de>
Subject: 4.19-rt in May? Re: [ANNOUNCE] 4.19.269-rt119
Message-ID: <ZjSoeyEnkJPY7ST3@duo.ucw.cz>
References: <167144069993.3503.13484547425689613996@beryllium.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kK4r9iCG4K6XU96T"
Content-Disposition: inline
In-Reply-To: <167144069993.3503.13484547425689613996@beryllium.lan>


--kK4r9iCG4K6XU96T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'd like to do 4.19-cip-rt release "soon". Is there chance to get
updated -rt tree? Last I see is:


commit 4790d0210f1929d981659cd4e7ecfb34e0a6889c (tag: v4.19.307-rt133-rc1, =
tag: v4.19.307-rt133, rt/v4.19-rt)
Author: Daniel Wagner <wagi@monom.org>
Date:   Tue Feb 27 13:10:41 2024 +0100

    Linux 4.19.307-rt133

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--kK4r9iCG4K6XU96T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZjSoewAKCRAw5/Bqldv6
8siIAKC5tweAMGwlBuQs+Z56ORnUuQ2C0ACghD4KFUP8cfvm6MJ12TtTz9Lf0m0=
=RA2y
-----END PGP SIGNATURE-----

--kK4r9iCG4K6XU96T--


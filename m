Return-Path: <linux-kernel+bounces-14306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAD6821B20
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5043D281206
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E777EADE;
	Tue,  2 Jan 2024 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HzJRxHYT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E7E57E;
	Tue,  2 Jan 2024 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704195641;
	bh=MpPHydD9ZIIX01FNM+Nq91LUgvlpmfH+QdJMYety9OI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HzJRxHYT7EuxuxhaoDFqTjkIvtw4kgvtj7t0dcdToCd0tNci8eLp0DfHuAkg2Y/r8
	 CSpSwWFUvCNyYUQYil4fhxhgWercJkxZ2jrTsYuwqtbJNVdZ0/bKTJc/jzsEoxRuwk
	 v+cTQTwC/MrC4SvGshfHZF61z3ji9hL74yXvAbcSgtY7f5u1+S9uxs06H5nzSGcTKx
	 a02F+6kGix5oSXpei7kQCdKWkJN7kY89nIPWyQJ9jotWgMrQWDQl0qcmkh+DLdD+WO
	 ewWdNCTl24HDj4FHX06T4+Fn6OPRE31W92Xf2u+1CV1rwjqM4xQF2bOIhwb2jEkYuC
	 PfJFKUbd9K+lw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T49s554Rcz4wch;
	Tue,  2 Jan 2024 22:40:41 +1100 (AEDT)
Date: Tue, 2 Jan 2024 22:40:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marc Zyngier <maz@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: errors fetching the irqchip trees
Message-ID: <20240102224027.0804f167@canb.auug.org.au>
In-Reply-To: <87ttnwt432.wl-maz@kernel.org>
References: <20240102080233.20aca3ec@canb.auug.org.au>
	<87ttnwt432.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z9PmyM.UFFT07zDHr/CDV+v";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Z9PmyM.UFFT07zDHr/CDV+v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Marc,

On Tue, 02 Jan 2024 10:36:01 +0000 Marc Zyngier <maz@kernel.org> wrote:
>
> Ah, my bad. I have recently removed myself from the irqchip
> maintenance (see commit b673fe1a6229), and forgot to let you know,
> apologies for that.
>=20
> Please drop these two branches from -next, as it is unlikely I will
> resume any significant activity on that front in the near future. You
> probably already pull from tip anyway.

No worries, I will remove them tomorrow.

--=20
Cheers,
Stephen Rothwell

--Sig_/Z9PmyM.UFFT07zDHr/CDV+v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWT9isACgkQAVBC80lX
0GwAvQf/buMQu3JQ9vfFtne/vz/+KbSBYT9MITW7ImQW/SE5gw/ZhaWWWqlHVh6x
I+/QBBypLUbDq9IgYzHM39c0lCy3y8Rc1C3sGzeZ+VpxWnrYQDEsmg8tmD9Y5LQj
7f6dEZpu+i7MnA6A6OtKHHAQAVxrZr1I45NxoHTYOaGwakOsW1mfuYC6d/lpPhXj
8OQeMnHf88XW3UAbLwOyKJqeCHKuFPuQoKtidCtiyyh+iKO96NrlQH6pZ2zaDqiD
GY8nTWHIxdQ6XeEyEdxODThJ+FcnH2zFVd92vLTJ4ZiblFCQk+kI981r+4OiZICe
sBtumfSWDV731SOp3t4mk0yLxFqLJw==
=G+hY
-----END PGP SIGNATURE-----

--Sig_/Z9PmyM.UFFT07zDHr/CDV+v--


Return-Path: <linux-kernel+bounces-2339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA711815B43
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 20:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631B71F23B0A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 19:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEAB31A8A;
	Sat, 16 Dec 2023 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="rVEOu3Pu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F157C31A68;
	Sat, 16 Dec 2023 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CBCC11C006B; Sat, 16 Dec 2023 20:22:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1702754542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=48TS7fFspkyRUVj7fHTaXs6eF4rnhuG1B3PrPjzxDxs=;
	b=rVEOu3PuGhOOqC3TofZaZVWdPliObgE+zzuOw1Ml+ynDweXb9rRtnhA3AaBhoxTui9iFUL
	fT799Xevn7RtaXvSC942lsLnQ4VofLORDPZc7qT4OL75nkcyAGbM1D1w61c3FvAotx1PQR
	62gsxn7A5Po0A1wmMb2AZVA22iUlTlk=
Date: Sat, 16 Dec 2023 20:22:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alain Volmat <alain.volmat@foss.st.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: media: i2c: add galaxycore,gc2145
 dt-bindings
Message-ID: <ZX347j0PfHe3SV+b@duo.ucw.cz>
References: <20231122075154.789431-1-alain.volmat@foss.st.com>
 <20231122075154.789431-3-alain.volmat@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AACX42QGkFbBuH/N"
Content-Disposition: inline
In-Reply-To: <20231122075154.789431-3-alain.volmat@foss.st.com>


--AACX42QGkFbBuH/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2023-11-22 08:51:48, Alain Volmat wrote:
> Introduction of the Galaxy Core GC2145 XVGA CMOS camera sensor.
>=20
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

BR,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--AACX42QGkFbBuH/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZX347gAKCRAw5/Bqldv6
8o+YAJ9G22eeJf3KnGwV8ESc7SX5hjSEeACfXpbj/JZZZBVR57qgOXSgCtvakco=
=ofcY
-----END PGP SIGNATURE-----

--AACX42QGkFbBuH/N--


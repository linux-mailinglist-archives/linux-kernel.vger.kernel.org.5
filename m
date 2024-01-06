Return-Path: <linux-kernel+bounces-18573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23597825F86
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 13:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48AC31C2134A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 12:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A086E7482;
	Sat,  6 Jan 2024 12:46:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E756FC3
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rM62x-0002jz-SX; Sat, 06 Jan 2024 13:45:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rM62u-000oJI-JD; Sat, 06 Jan 2024 13:45:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rM62u-0040D8-1Y;
	Sat, 06 Jan 2024 13:45:00 +0100
Date: Sat, 6 Jan 2024 13:45:00 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Fabio Estevam <festevam@gmail.com>, Robert Foss <rfoss@kernel.org>, David Airlie <airlied@gmail.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Jonas Karlman <jonas@kwiboo.se>, Liu Ying <victor.liu@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Daniel Vetter <daniel@ffwll.ch>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	linux-arm-kernel@lists.infradead.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, 
	Shawn Guo <shawnguo@kernel.org>, Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH V5 1/2] dt-bindings: display: imx: add binding for
 i.MX8MP HDMI PVI
Message-ID: <6sgtepzkc74n6pxbbhzxnngba6sxt3kmzlnmalzj2m6xoumbk7@pjjxdlyd2hxh>
References: <20240106015623.193503-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="obswwz3a5ig4f6nw"
Content-Disposition: inline
In-Reply-To: <20240106015623.193503-1-aford173@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--obswwz3a5ig4f6nw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Adam,

On Fri, Jan 05, 2024 at 07:56:21PM -0600, Adam Ford wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
>=20
> Add binding for the i.MX8MP HDMI parallel video interface block.
>=20
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Without looking at the patch's content: This lacks a Signed-off line by
you.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--obswwz3a5ig4f6nw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWZS0sACgkQj4D7WH0S
/k5kEAf+Lpw58sawnK1oJ8ogItqt06RWvgtzj8d+2/FmvQhJKFmCCjCNTM5ULZC3
GYHgY8kcLNemfGdQnLFgxXVquBFK0PNg18WzqWJLobJ6eDf7hF9aNsNZvmvpJWR1
u6GJTAfaFYjyAoNRGkAi9U8xtT3LOGXcItqzq7epj/BbX34rwpMeGVi531fB8QSw
UkSstTOowG2sbJP5usDSEdmhe6ZmSUwVTSqfgyVyeZ9Le+9Dzck6LoUKqEi0OusI
j+Iaoi152n5EbQLFWoXHLppYNeFAlrCcJetgx5lyY+g2z2bjMyY1tV5JjUxAmA7b
CVq+fAJWs3xU5VfPweUIBXY3n/xvPw==
=Hn2F
-----END PGP SIGNATURE-----

--obswwz3a5ig4f6nw--


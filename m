Return-Path: <linux-kernel+bounces-7315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B77D81A58D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1C31C2256C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D9C46447;
	Wed, 20 Dec 2023 16:44:48 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D815B46431;
	Wed, 20 Dec 2023 16:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B65AC433C8;
	Wed, 20 Dec 2023 16:44:46 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:44:43 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: fabrice.gasnier@foss.st.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] tools/counter: Remove unneeded semicolon
Message-ID: <ZYMZ-6BQIWbwAO9j@ishi>
References: <20231220005143.84987-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jl8dtxLNd6HF6E1W"
Content-Disposition: inline
In-Reply-To: <20231220005143.84987-1-yang.lee@linux.alibaba.com>


--jl8dtxLNd6HF6E1W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Dec 2023 08:51:43 +0800, Yang Li wrote:
> ./tools/counter/counter_watch_events.c:233:3-4: Unneeded semicolon
> ./tools/counter/counter_watch_events.c:234:2-3: Unneeded semicolon
> ./tools/counter/counter_watch_events.c:333:2-3: Unneeded semicolon
>=20
>=20

Applied, thanks!

[1/1] tools/counter: Remove unneeded semicolon
      commit: b7760cf94d4f2665bf40d08dd69aa5d0b4aa593f

William Breathitt Gray

--jl8dtxLNd6HF6E1W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZYMZ+wAKCRC1SFbKvhIj
K/OrAP9n0e0yPsOD8vivS06OXr8QRyQF9yuqH+0V6WVKP/KbxgD/cwfTXRIRw6un
XJut1NRNBdlrYZSi5k6aS56xbyGqEgs=
=Bl1n
-----END PGP SIGNATURE-----

--jl8dtxLNd6HF6E1W--


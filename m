Return-Path: <linux-kernel+bounces-3813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 324EA8172C8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C602D1F23626
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A804FF7E;
	Mon, 18 Dec 2023 14:10:04 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688A74FF74;
	Mon, 18 Dec 2023 14:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F3DC433CA;
	Mon, 18 Dec 2023 14:10:03 +0000 (UTC)
Date: Mon, 18 Dec 2023 09:10:01 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] tools: counter: add counter_watch_events
Message-ID: <ZYBSuYFJxrB35dWv@ishi>
References: <20231213173117.4174511-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A2lP8TohNjdXxZ+d"
Content-Disposition: inline
In-Reply-To: <20231213173117.4174511-1-fabrice.gasnier@foss.st.com>


--A2lP8TohNjdXxZ+d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Dec 2023 18:31:15 +0100, Fabrice Gasnier wrote:
> Introduces a new tool that can be used for testing. Also
> add MAINTAINERS entry as per William's recommendations.
>=20
> Changelog:
> Changes in V4:
> - Specify linux-iio mailing list in MAINTAINERS
> - Revisit error path and handling in counter_watch_events
>=20
> [...]

Applied, thanks!

[1/2] tools/counter: add a flexible watch events tool
      commit: 1e73427f66353b7fe21c138787ff2b711ca1c0dd
[2/2] MAINTAINERS: add myself as counter watch events tool maintainer
      commit: 8e21e4693d8502ee31ef7984e16c3d9cab6c926a

Best regards,
--=20
William Breathitt Gray <william.gray@linaro.org>

--A2lP8TohNjdXxZ+d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZYBSuQAKCRC1SFbKvhIj
K9gSAP0RG0UhlRKT9wnoi8jza4fKM8q1uCcClJ94Ed431gL+zgEA0z+e62MqVtVX
cnpBZxF6tbxiJdtrnGTYcPDkil5wZw0=
=FnWo
-----END PGP SIGNATURE-----

--A2lP8TohNjdXxZ+d--


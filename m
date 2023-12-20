Return-Path: <linux-kernel+bounces-6961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB9E819FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320001F228DD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9B82D63D;
	Wed, 20 Dec 2023 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGDvqVQp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986F636AED;
	Wed, 20 Dec 2023 13:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D17C433C8;
	Wed, 20 Dec 2023 13:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703079096;
	bh=+HI2Gbam+kAC/Z1mpnR3OKn1FsThU430v/f4Gkbo2zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGDvqVQp/YjiHgACt1kWrEH5F5tjGq9pVZgwTlz89ru+Phx8f2Yv9sftDQS5AAA14
	 uIR9CLnOHXpQqA63EVe5DcmxhpSVBi04vZFBEqg/6qqx5+fcmjc5bSaKsGLr90Rwog
	 Bowv5OTntFapQcZ7Z6TntLssRLKsOd/RD/lFqSSDrxkbyjCTih/KTfxQOGYuUIiqIl
	 r6jT90Yy4aRTbid25Yom8nA/bAMAWtR/yc9QzMpWO7w+abI8hHbQC/kfJWmg1L5q+v
	 iWfitRSc+VdvUb81lMKcPMIEW35bXasQklz4kH5kTl+5oIAIvB12rPw0dFK7Eo7zLF
	 ywnFeSJiZ2zOQ==
Date: Wed, 20 Dec 2023 13:31:31 +0000
From: Mark Brown <broonie@kernel.org>
To: yang.guang5@zte.com.cn
Cc: lgirdwood@gmail.com, jiang.xuexin@zte.com.cn, chen.haonan2@zte.com.cn,
	cgel.zte@gmail.com, perex@perex.cz, tiwai@suse.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] ASoC: soc-topology: Switch to use
 dev_err_probe() helper
Message-ID: <52c7028b-bff5-4654-af6a-9d325fbe4c31@sirena.org.uk>
References: <202312201057082362118@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g5O2fxfjeOuRImDE"
Content-Disposition: inline
In-Reply-To: <202312201057082362118@zte.com.cn>
X-Cookie: Apply only to affected area.


--g5O2fxfjeOuRImDE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 10:57:08AM +0800, yang.guang5@zte.com.cn wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
>=20
> dev_err() can be replace with dev_err_probe() which will
> check if error code is -EPROBE_DEFER.

This doesn't apply against current code, please check and resend.

--g5O2fxfjeOuRImDE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWC7LIACgkQJNaLcl1U
h9DFRAf/RtpdJ6miha+/P651xzQ/yPrS1O3sNmpK8I7ZP/hzTIjVKAXK/zrTkLSF
us+7NJxS3m1HeKgNPw8GMqufIIrfe8Z7vJn6YZYbiOelpSGMBz3ljSnJbjxJ7tjb
ziC40VidCDfruDEVtvr7t8ywnIEp803gqVw9rIofLhHzKYNBQCR+DOiXUdsYW5DY
cCm6AspjuQl2o5jAxzq2N6IuVx0jJitrRDIFSxkl+D2KMVD1eNsaOt0mPi2+lOzQ
/0WBVtB+eSD0QfJY5O2/oPa+5ikKU4RxhKgQ+/VdKR1H2puFDgfjhXOJyRCKlSGf
q+iMqhqHJb4cjrQbXKd6hZKXyNcL5g==
=NjUk
-----END PGP SIGNATURE-----

--g5O2fxfjeOuRImDE--


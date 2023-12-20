Return-Path: <linux-kernel+bounces-7311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4E881A57A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06904B2666B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1FC41875;
	Wed, 20 Dec 2023 16:41:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E9341867;
	Wed, 20 Dec 2023 16:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9B3C433C7;
	Wed, 20 Dec 2023 16:41:12 +0000 (UTC)
Date: Wed, 20 Dec 2023 11:41:10 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] tools/counter: Fix spelling mistake "componend" ->
 "component"
Message-ID: <ZYMZJgbFh_1wMIQb@ishi>
References: <20231219133015.365943-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kARUZ4yEyaeixqWd"
Content-Disposition: inline
In-Reply-To: <20231219133015.365943-1-colin.i.king@gmail.com>


--kARUZ4yEyaeixqWd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Dec 2023 13:30:15 +0000, Colin Ian King wrote:
> There are two spelling mistakes in the help text. Fix them.
>=20
>=20

Applied, thanks!

[1/1] tools/counter: Fix spelling mistake "componend" -> "component"
      commit: 0647537df442e0ec818fc0bca347f13c11268202

William Breathitt Gray

--kARUZ4yEyaeixqWd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZYMZJgAKCRC1SFbKvhIj
K/KyAP9bCW7bDGsWDfAjuWEdZtbaVvDlhyvvrjWeRzIG3DLScQEA/wV0dWQaY4Q/
E4cz3FC2dbMxDFp4ZQxINteaXDyELgo=
=ZkIE
-----END PGP SIGNATURE-----

--kARUZ4yEyaeixqWd--


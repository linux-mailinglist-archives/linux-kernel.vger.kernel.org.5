Return-Path: <linux-kernel+bounces-3171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B738B816839
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F307B218B1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04061079C;
	Mon, 18 Dec 2023 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhoT0Z2U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E4010799;
	Mon, 18 Dec 2023 08:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73571C433C7;
	Mon, 18 Dec 2023 08:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702888716;
	bh=lxS8hMZ1dXht82U8cpnLcif0aGlwHIaUESGxT3NDlLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bhoT0Z2UMgQfdCyxM3nZASu2omLnvIufE0XXfWAYW2bItZ9m6X0glvITBh4aqUvuE
	 M97/de6rQxxtEaTfU/S2QTR2CRICRDTWg6TtlDCVvp0E4zYxlr/+YSjAl6DC6nuPU4
	 D39izpCI0Kg5ckXWSJdhu7AbpYchFZZ2xl6YyvhRG33urheUX+y4pap1m5A53Oey77
	 HjRFtAGbadf/VaZQpG75PeVIsOalzJSCe1Nwvo53jov4MX4/u+Q5e5J/byy9AQUj0s
	 RFGB3QNoFS9Mx6iPSMK+VJOBNB/RlX5zrtshNcPERztSDx9/iXgi6V0WQmVFWVym4I
	 rXqrCqJLkmISw==
Date: Mon, 18 Dec 2023 09:38:33 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andyshrk@163.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/27] drm/rockchip: inno_hdmi: Remove useless
 mode_fixup
Message-ID: <2dzoew242wpbmxx6bnhoe27rugtcgwz4xxcsytsshkcotmyry5@5voq5jrwxww7>
References: <20231216162639.125215-1-knaerzche@gmail.com>
 <20231216162639.125215-5-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q2lhm6ovzh5lkxky"
Content-Disposition: inline
In-Reply-To: <20231216162639.125215-5-knaerzche@gmail.com>


--q2lhm6ovzh5lkxky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Dec 16, 2023 at 05:26:15PM +0100, Alex Bee wrote:
> From: Maxime Ripard <mripard@kernel.org>
>=20
> The mode_fixup implementation doesn't do anything, so we can simply
> remove it.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> Tested-by: Alex Bee <knaerzche@gmail.com>

Generally speaking, when you're sending patches you should always have
your SoB. That is true for the commit you authored, but also for the
commits you applied and are sending on the author's behalf.

This applies to all the other patches

Maxime

--q2lhm6ovzh5lkxky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZYAFCQAKCRDj7w1vZxhR
xbH2AP0fhSTnAOnzCnV/Tv6BswVP6vcqipu0iW8olLDlAXPGtQEA1o9l1iRrt09t
4dndGGxNNPImDviWL7SYWs3i2TPLmwA=
=jzCp
-----END PGP SIGNATURE-----

--q2lhm6ovzh5lkxky--


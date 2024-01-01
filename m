Return-Path: <linux-kernel+bounces-13875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAC98213E1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 14:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009241C20AFF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 13:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F57846AF;
	Mon,  1 Jan 2024 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inc5WUqs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FCC46A2;
	Mon,  1 Jan 2024 13:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5299AC433C8;
	Mon,  1 Jan 2024 13:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704117523;
	bh=t+f4Znj3FNYbBCxfo60vMjy20/W1jFBDpQMRsFjVBuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=inc5WUqsf/Vw/W+FtcWbnloAfe2/VDN5sVHInSg5AR0Oyp18cPiuyGwcB6ul2pTO+
	 OrioZ2G0Ke49+WgjcKhAEckVWVMSZsOIJO38eni5SXzfnwzT6TYWEd6NoiVygrlRo6
	 0INsqNnn1ng4cInW3xssTisviDkbp+4bQkDrqE85+J1P6bv6x5BZpTku/ZT8eP4B7V
	 ltwg8DbbfhdEx5z/8mLfqao5n33rNQZlLv3rwAFJzTPmlSJowAvQNW/Iw9Ox/MDaRz
	 kGmBF7+UEs0/hqxmchcCRUwd6h/8SQU1GPGR/yN0kxwZfL3I6DSrj9byCj3dl8ODss
	 zpIoszdNlfWjQ==
Date: Mon, 1 Jan 2024 13:58:38 +0000
From: Conor Dooley <conor@kernel.org>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, heiko@sntech.de, ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de, mchehab@kernel.org, sfr@canb.auug.org.au,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, sigmaris@gmail.com,
	knaerzche@gmail.com
Subject: Re: [PATCH v3 2/2] dt-bindings: media: rockchip-vpu: Add rk3588 vpu
 compatible string
Message-ID: <20240101-subsystem-clinking-d3b1a1dcf640@spud>
References: <20231231151112.3994194-1-liujianfeng1994@gmail.com>
 <20231231151112.3994194-3-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KyxL4TV6V4aWT69C"
Content-Disposition: inline
In-Reply-To: <20231231151112.3994194-3-liujianfeng1994@gmail.com>


--KyxL4TV6V4aWT69C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2023 at 11:11:12PM +0800, Jianfeng Liu wrote:
> Add Hantro G1 VPU compatible string for RK3588.
> RK3588 has the same Hantro G1 ip as RK3568, which are both
> known as VDPU121 in TRM of RK3568 and RK3588.
>=20
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--KyxL4TV6V4aWT69C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZLFDQAKCRB4tDGHoIJi
0krIAP4x33KV2Y2E1cOYB1TgS8jK9biNoJfRtKdWrA2G3rLj7QD9GDgJCPMBn59S
ECEYH9sl7zdG8Bid60MeDGWnzLyv5Aw=
=36Vr
-----END PGP SIGNATURE-----

--KyxL4TV6V4aWT69C--


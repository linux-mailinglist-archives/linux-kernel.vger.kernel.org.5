Return-Path: <linux-kernel+bounces-19871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 407768275F3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8186B21564
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542F053E25;
	Mon,  8 Jan 2024 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5KcmNz2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5C353E2A;
	Mon,  8 Jan 2024 17:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF68C433C9;
	Mon,  8 Jan 2024 17:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704733276;
	bh=v2/TiwSdHE2DinFIJYw+TSu7bM/JscJjrxVzVNK8vfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i5KcmNz2ENOnpeTzk/m22X5gOXVhvAWDjNQM+0UYi5EgPCenTbEq0e0iuF1V8y2fs
	 rEwMPjk3uDtpIMVoxnn2AZm5rNblf3HZeKC8GpbLJsYP5yr+KY+FBM09MrJ/NAtfd/
	 yAXKV83twJ3nPpudg8zU7SLglFwwqfBpnPmzv32d3MUtwRKt8sJXTKkZclPylLkLi7
	 Sp2Z7Q3PZA4ywn+4vQcoBDUkrWsI6mXnut1dsFKejk/oNDjXL/mp6nOnSXMNVwJ5VT
	 4A52FD7+7BQ2zEGZkIPdKmMGt7ZrMTp22F7mM3A2aOcHGjKkxQyl7sk5lxg9DNz3MC
	 nEF2yJm0V7D8w==
Date: Mon, 8 Jan 2024 17:01:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:INA209 HARDWARE MONITOR DRIVER" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: hwmon: ina2xx: Describe ina260 chip
Message-ID: <20240108-generous-expediter-1f4ed78077d8@spud>
References: <4c82dc4d412e91d1601c1da5bca1cdf1a91cd9b8.1704724242.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="65zwX83nMVPDOCON"
Content-Disposition: inline
In-Reply-To: <4c82dc4d412e91d1601c1da5bca1cdf1a91cd9b8.1704724242.git.michal.simek@amd.com>


--65zwX83nMVPDOCON
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 03:30:51PM +0100, Michal Simek wrote:
> Describe ina260 chip which is precision digital current and power monitor
> with precision integrated shunt resistor.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--65zwX83nMVPDOCON
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZwqVwAKCRB4tDGHoIJi
0he8AQCbN5mPbIoEbzBQ7asM/7ZMjkwb6lp47o9BdzsSYkSyGAD/QXPa5TwZRbhb
nRM6eDm54N35V7rofzPN+dbKuzk/QQo=
=Yv7k
-----END PGP SIGNATURE-----

--65zwX83nMVPDOCON--


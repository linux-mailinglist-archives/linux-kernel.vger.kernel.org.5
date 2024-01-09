Return-Path: <linux-kernel+bounces-21151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBDE828ACF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E118D1C243FB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1810F3A8FD;
	Tue,  9 Jan 2024 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbN6CCuK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6BF3A8C7;
	Tue,  9 Jan 2024 17:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548BCC433C7;
	Tue,  9 Jan 2024 17:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704820476;
	bh=siOZC4wOuNDoVWsdLiyPsbZnkPF7a7ofovZKE/nAX/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SbN6CCuK5NChl9458MDDbcbs1SdUAG1Fd/5ItykQxgrlxYOt8DA2J14s9SYA8usPM
	 m5ylQNkriV3WnFbF7c+AFAqUyUAktzZbK3wZoEFB2gKpzmpeF0rHc7zyicWESv7X7n
	 dFWPf/MH+vgH1EU05HcjMtBdgGFIcA6QVLQ3Zn0XdIe4dg9+PM0H4lp6ZCNA14vqCf
	 K/XKUGrO0ohFsnTQfU0uJ8mF4pDjRqdZdIN0U0URwMfdzjeGtd6+Jr23csiXdPwDN/
	 UtmTiCgQlFnX6thWpQcgXP0b9vy5yRfx4+iNclwxUJ8xcjZnZYEPVHPpBX19d0ZaiH
	 M9/ChPwWdY3CQ==
Date: Tue, 9 Jan 2024 17:14:29 +0000
From: Conor Dooley <conor@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: Guenter Roeck <linux@roeck-us.net>, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, peterhuewe@gmx.de,
	jarkko@kernel.org, jgg@ziepe.ca, keescook@chromium.org,
	tony.luck@intel.com, gpiccoli@igalia.com,
	johannes.holland@infineon.com, broonie@kernel.org,
	patrick.rudolph@9elements.com, vincent@vtremblay.dev,
	peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com,
	bhelgaas@google.com, naresh.solanki@9elements.com,
	alexander.stein@ew.tq-group.com, festevam@denx.de,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
	geissonator@yahoo.com
Subject: Re: [PATCH v1 7/8] tpm: tis-i2c: Add more compatible strings
Message-ID: <20240109-pep-coerce-2a86ae88753d@spud>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-8-ninad@linux.ibm.com>
 <20231212-avid-grill-dbead068fac8@spud>
 <73381bb0-7fa7-4a9e-88df-ab0063058e26@roeck-us.net>
 <20231212-mouth-choice-40a83caa34ec@spud>
 <2946fbb1-2a47-4d21-83dc-8e45bf6ba5a9@roeck-us.net>
 <60c8bbdb-4e08-44f0-88d4-ab164d4843b5@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OEamGw2PREjDYnc1"
Content-Disposition: inline
In-Reply-To: <60c8bbdb-4e08-44f0-88d4-ab164d4843b5@linux.ibm.com>


--OEamGw2PREjDYnc1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 02:05:53PM -0600, Ninad Palsule wrote:
> Hello Guenter,
>=20
> On 12/12/23 13:50, Guenter Roeck wrote:
> > On 12/12/23 10:51, Conor Dooley wrote:
> > > On Tue, Dec 12, 2023 at 10:00:39AM -0800, Guenter Roeck wrote:
> > > > On Tue, Dec 12, 2023 at 05:15:51PM +0000, Conor Dooley wrote:
> > > > > On Tue, Dec 12, 2023 at 10:40:03AM -0600, Ninad Palsule wrote:
> > > > > > From: Joel Stanley <joel@jms.id.au>
> > > > > >=20
> > > > > > The NPCT75x TPM is TIS compatible. It has an I2C and SPI interf=
ace.
> > > > > >=20
> > > > > > https://www.nuvoton.com/products/cloud-computing/security/trust=
ed-platform-module-tpm/
> > > > > >=20
> > > > > >=20
> > > > > > Add a compatible string for it, and the generic compatible.
> > > > > >=20
> > > > > > OpenBMC-Staging-Count: 3
> > > > >=20
> > > > > Delete this from every patch that it appears from.
>=20
>=20
> I have send it as a separate commit. https://lore.kernel.org/linux-kernel=
/20231214144954.3833998-1-ninad@linux.ibm.com/

Why did you do that? It now just adds undocumented compatibles to the
driver. Please, as Rob requested, work with Lukas on his series to make
sure that these devices are documented.

Thanks,
Conor.

--OEamGw2PREjDYnc1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ1+9AAKCRB4tDGHoIJi
0htZAP9a2iXLaNyt9gp80dOzXMKedooH9x1JxCeLqDSn/jQ4FAD7BmzWTG2ck+GX
6HtPX7JRe5C0eqmAl9taPHOuxon4HQw=
=q6NZ
-----END PGP SIGNATURE-----

--OEamGw2PREjDYnc1--


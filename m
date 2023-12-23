Return-Path: <linux-kernel+bounces-10410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B554581D410
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 13:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E704C1C2149B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 12:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A06DDA2;
	Sat, 23 Dec 2023 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srbYoYpg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F531D52F;
	Sat, 23 Dec 2023 12:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299A9C433CB;
	Sat, 23 Dec 2023 12:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703335765;
	bh=NhhSHGhmXm/1FOYx4JZTc0xBFK4D7PbuCyyVW6Zl5XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=srbYoYpg/WiWm6FP7gsVwlrsz837jn5FQJmmWgEjEZ1TOBSAJgurQEr6uJXUq4nT/
	 hXPNVaEHJ2KEx4GIW1aheN+Jn8ECeiFR3Zq2LIl4nWc7Cv4huMxxpFFoMtYvKj5nKu
	 aYhCgA3eYFG1IF6Rj7dLyJKBoe8XyRUy64JTOphtH6vJrh8McN1+R4RCF3Qd+kftr9
	 yABSqgDWl40eXXlOuiD3n8cGtD2nxLbUx7H0agKRbUYL6QfXo1vPnZkRZUjZH9VK4q
	 W3FAJpciVGENwYl5GAD4majaS8BcciIvQHuZ5AnCE+aTB/mINoyTxNiF/uAAVga7LT
	 QsU6RziDTvP/w==
Date: Sat, 23 Dec 2023 12:49:20 +0000
From: Conor Dooley <conor@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Christian Eggers <ceggers@arri.de>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: as73211: add support for
 as7331
Message-ID: <20231223-nucleus-taps-7ba9d371c84a@spud>
References: <20231220-as7331-v1-0-745b73c27703@gmail.com>
 <20231220-as7331-v1-1-745b73c27703@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MOSQ+IDtmMJ7WSwL"
Content-Disposition: inline
In-Reply-To: <20231220-as7331-v1-1-745b73c27703@gmail.com>


--MOSQ+IDtmMJ7WSwL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 11:46:13AM +0100, Javier Carrasco wrote:
> This device has the same properties and I2C addresses as the as73211.
> The only difference between them is the photodiodes they use internally,
> which in this case is irrelevant for the bindings.
>=20
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--MOSQ+IDtmMJ7WSwL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYbXPQAKCRB4tDGHoIJi
0nr8AP47Rocj53EtEcbKvty78vpjqelINcySkbcixMVrYkqz8AD9EypPzD+i8WHk
Ovq17Q8r7REOFc/NjD9v0vbbHt1XPAk=
=Xx3z
-----END PGP SIGNATURE-----

--MOSQ+IDtmMJ7WSwL--


Return-Path: <linux-kernel+bounces-2169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1968158E4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAEC284D2A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B851E19BA7;
	Sat, 16 Dec 2023 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEoXliKl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D392D24B51;
	Sat, 16 Dec 2023 12:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D13EC433C8;
	Sat, 16 Dec 2023 12:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702728402;
	bh=ymcicKWMiCxCMT8U9JeNofoguzL2CsM6z3lDqO7opc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NEoXliKlLKZM+VPPvJGFQ0cDl/+XWHpmp3v9vaTCZtHZ5MSA8XD70wSnh0d1d+ce0
	 cl+7suhC3o+jVhNEJmJnY1KnKTHwT/LCzM0MQIrkq5/OBK1SFxVwHyXKzsQVnN2MSf
	 /QWKdDyzCnvbwg29G83bCUleui3Z9GriILDkA8e+82yIENzPap5UU9PXnkqtsY5/cD
	 vhu5FFDdLoQNbmIwenotNbd9HmU/523SXXir3f+R9wZaLHO9T2WhdoooZglPZF8DoJ
	 LVSIvZIzL+6I+HzaLBM6yKZcRoxVsklWtAyXERd+TtgBMK3uqjFotH0qJZLeCBsigg
	 wzRplkWCImdpQ==
Date: Sat, 16 Dec 2023 12:06:35 +0000
From: Conor Dooley <conor@kernel.org>
To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	"kernel@esmil.dk" <kernel@esmil.dk>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"krzk@kernel.org" <krzk@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"anup@brainfault.org" <anup@brainfault.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"michal.simek@amd.com" <michal.simek@amd.com>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	"drew@beagleboard.org" <drew@beagleboard.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 2/6] dt-bindings: riscv: Add StarFive JH8100 SoC
Message-ID: <20231216-unknown-shakiness-8c4a5cd53006@spud>
References: <20231214-platonic-unhearing-27e2ec3d8f75@spud>
 <mhng-fb85106d-c0bf-4f6f-8351-10d4a4da6eb6@palmer-ri-x1c9>
 <ab8bb47cbcca40649ff1e115ed34d3c1@EXMBX066.cuchost.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xnZVKVuLE9iuntqZ"
Content-Disposition: inline
In-Reply-To: <ab8bb47cbcca40649ff1e115ed34d3c1@EXMBX066.cuchost.com>


--xnZVKVuLE9iuntqZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 15, 2023 at 01:49:02AM +0000, JeeHeng Sia wrote:
> Thank you everyone. I think I get your point. Is it possible to send "RFC"
> patches for things like DT, clk&reset, and pinctrl? Please note that
> these have been tested on FPGA/Emulator.

For sure you can send them as RFC, yes.

--xnZVKVuLE9iuntqZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZX2SywAKCRB4tDGHoIJi
0i7tAQDWY8CCVBgjwFAM48GbHbn6JwBmS6Odm7A3xAHVilTqcAD+JLVOfmzJi/Pg
YQekZntg/l4zEsu7HjxVLj9axaNDvgQ=
=mrO6
-----END PGP SIGNATURE-----

--xnZVKVuLE9iuntqZ--


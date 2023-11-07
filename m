Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5DF7E4A72
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343971AbjKGVSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbjKGVSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:18:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9873410C1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:18:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCACC433C8;
        Tue,  7 Nov 2023 21:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699391900;
        bh=ERY6UoPM1GU+DApAE6GlRP0eE5/JGMTXNItE6V115wA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hDJAeHguvCHh9PnNxdYfWKpS3BeRZVKZHNNj3AofUcu6WTNBu5vyAl+fzuzBKDBGL
         TMftQr7ws8l27wuaVsrB2xI8SGzVcJJK7HfNQ1Uv7LuvqGQDEnOpVXaZrq1FACn8L6
         iksu1TvG2EbSL3u6XxXXr8RJ+iH5qiDZxzFIrWXpfx7R7ahSGdmGJN7jefI5yf5AQP
         Mq+ZjrPN1SxVTXgM06oGGmn9IOdNu0VVdiLBt1If5RcXj2XlVTIAXGzV494IXPkP21
         viz2kFv8dYWcqueZMoscfNB5qtwMwcpU/3fiG5pHqkmJPXwRgHThZM9gqxS7+IoZ2C
         ZLu/X0tHLQA9w==
Date:   Tue, 7 Nov 2023 21:18:16 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: Add new board description for
 MicroBlaze V
Message-ID: <20231107-expensive-jitters-92e454f77ea8@spud>
References: <50c277c92c41a582ef171fb75efc6a6a4f860be2.1699271616.git.michal.simek@amd.com>
 <20231106-hangnail-prankster-a04e713bed35@spud>
 <4223470c-5596-4168-9c89-e701559fbbed@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l64Ovq0UtbQtisQg"
Content-Disposition: inline
In-Reply-To: <4223470c-5596-4168-9c89-e701559fbbed@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l64Ovq0UtbQtisQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 12:09:58PM +0100, Michal Simek wrote:
>=20
>=20
> On 11/6/23 18:07, Conor Dooley wrote:
> > On Mon, Nov 06, 2023 at 12:53:40PM +0100, Michal Simek wrote:
> > > MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V processor IP.
> > > It is hardware compatible with classic MicroBlaze processor. Processo=
r can
> > > be used with standard AMD/Xilinx IPs including interrupt controller a=
nd
> > > timer.
> > >=20
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > ---
> > >=20
> > >   .../devicetree/bindings/soc/amd/amd.yaml      | 26 ++++++++++++++++=
+++
> >=20
> > Bindings for SoCs (and by extension boards with them) usually go to in
> > $arch/$vendor.yaml not into soc/$vendor/$vendor.yaml. Why is this any
> > different?
>=20
> I actually found it based on tracking renesas.yaml which describes one of
> risc-v board. No problem to move it under bindings/riscv/

That one is kinda a special case, as it contains arm/arm64/riscv.

--l64Ovq0UtbQtisQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUqpmAAKCRB4tDGHoIJi
0sWaAP4q1cECiBH/VWu1Z2ske7bzSK4pWDsxCedqUlVDPzU2GwD/TfyjYTvKNOov
Sg/a6SEckcmadodqQO0MZ0ca30P0bQA=
=DNsf
-----END PGP SIGNATURE-----

--l64Ovq0UtbQtisQg--

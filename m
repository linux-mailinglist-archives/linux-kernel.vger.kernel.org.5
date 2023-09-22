Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CE07AB909
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjIVSV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjIVSV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:21:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F1AC2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:21:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E29C433C7;
        Fri, 22 Sep 2023 18:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695406880;
        bh=SJcH9WWUC7b4icS4mYzsgIi5682dqbrCHyF82Gm43a4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d8gs3/mY6Sf+oS/SUeaP2Jr42tQw1grzspJHmvAh0xv4/+drpEjIlsXppZcRi7KdK
         H1xlDY+5Jmqc350YgZ7s6/KjEMpRr+IuBZ72LbFd9JXI1PEgD+32dQcBfMFlOg6StE
         eJVTLbJwx0SQxQIYCQEBuN98pStC4Aw+jowy/I8t8vTk84nQXTJckh7RvlU2XicOa9
         6rfz7Ywp5RXslfiTwqe3jlbCfReheshhS0PhfbfYGj4+umuwO5qtaRnb/kF1jNEmuR
         3jRzhBYdCS86IkHBLADgzu6gsL2OujwgGAGNPW9myq2JtxWCGAFWKgliszWbwcFz8a
         byzboUiwmGsuw==
Date:   Fri, 22 Sep 2023 19:21:16 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: dt-bindings: tfa9879: Convert to dtschema
Message-ID: <20230922-scoreless-battalion-8b33e36066eb@spud>
References: <20230921183313.54112-1-bragathemanick0908@gmail.com>
 <20230922-unmindful-anyplace-f1da73ab168c@spud>
 <c6f795f1-2832-c282-5819-f8f402a312bd@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rF2zpNVePdlmTHic"
Content-Disposition: inline
In-Reply-To: <c6f795f1-2832-c282-5819-f8f402a312bd@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rF2zpNVePdlmTHic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 10:53:06PM +0530, Bragatheswaran Manickavel wrote:
>=20
> On 22/09/23 20:56, Conor Dooley wrote:
> > On Fri, Sep 22, 2023 at 12:03:13AM +0530, Bragatheswaran Manickavel wro=
te:
> > > Convert the tfa9879 audio CODEC bindings to DT schema
> > > No error/warning seen when running make dt_binding_check
> > >=20
> > > Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.co=
m>
> > > Changes:
> > > V1 -> V2: Fixed DT syntax errors and doc warning
> > These should be under the --- line, not above it.
> > Perhaps Mark will change it on application.
> > Otherwise,
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> Thanks for reviewing it.
> Do I need to send a new patch by addressing the above comments ?

To be clear, it's the changelog, not the sign off, that needs to go
under the ---. It'd look like:

Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
---
Changes:
V1 -> V2: Fixed DT syntax errors and doc warning

Mark often fixes these things when he applies patches, but sending a v2
w/ the changelog fixed might make his life easier.

Cheers,
Conor.

--rF2zpNVePdlmTHic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQ3bHAAKCRB4tDGHoIJi
0o6LAP9Vq8grg9fJf5i45dQtQG833qk7XMbr9PXVfnfcitVhBgD/b/LHnihKc99a
Ei0JpNNTNhBFWQLwjwosqqdeiWJJFgI=
=xq4J
-----END PGP SIGNATURE-----

--rF2zpNVePdlmTHic--

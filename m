Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D2877E7FA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345301AbjHPRzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345288AbjHPRzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:55:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1A72717;
        Wed, 16 Aug 2023 10:55:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B511664CDE;
        Wed, 16 Aug 2023 17:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DEDC433C7;
        Wed, 16 Aug 2023 17:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692208509;
        bh=I+lSIZWGoXi55IVZPRG0vPCphER0alUE3nMtkYVX6gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nk2H/zUuGto+900FV0DVKBKsSpGW7aVbXgKPZJGU/WtZFpD0hRjdcG8tfjL19FfAL
         33cwm0neZsVXXjJxUrkMhT+hirnuFoAmUZCvjPlrqtJmAOvNZpSKO+Nq+FjjNzsBNp
         rDa11mIYhFK4EgtFUiX3gX3R4aT/cSX2w8AxJ6h1MBRgwal0MfxZIkTs9gYU8xBc57
         RM3GQ8GdpR/vRcKJC5mkYlH+oTEcXGDZiwboLz3/3y+vzJw92b1U2kXTBwljzA9eW9
         TeBkj1zGgbzfc+yvg1v02a1au11tmsv8oP4cVBRe58KQs/P/2E9reoYDv4X7dcAbod
         7YPnhnpLZPUIA==
Date:   Wed, 16 Aug 2023 18:55:03 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, rydberg@bitmath.org,
        u.kleine-koenig@pengutronix.de, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, heiko@sntech.de
Subject: Re: [PATCH 1/4] dt-bindings: touchscreen: convert neonode,zforce to
 json-schema
Message-ID: <20230816-operation-curator-e9ab3159d9c4@spud>
References: <20230815182948.212575-1-andreas@kemnade.info>
 <20230815182948.212575-2-andreas@kemnade.info>
 <20230816-customary-service-8d9c5e5dbf1b@spud>
 <20230816192049.630fbf6c@aktux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J+9iqmHLWvb13iO/"
Content-Disposition: inline
In-Reply-To: <20230816192049.630fbf6c@aktux>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J+9iqmHLWvb13iO/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 07:20:49PM +0200, Andreas Kemnade wrote:
> On Wed, 16 Aug 2023 15:52:16 +0100
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Tue, Aug 15, 2023 at 08:29:45PM +0200, Andreas Kemnade wrote:
> > > Convert Neonode infrared touchscreen controller binding to DT schema.
> > >=20
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > >  .../input/touchscreen/neonode,zforce.yaml     | 67 +++++++++++++++++=
++
> > >  .../bindings/input/touchscreen/zforce_ts.txt  | 34 ----------
> > >  2 files changed, 67 insertions(+), 34 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/input/touchscre=
en/neonode,zforce.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/input/touchscre=
en/zforce_ts.txt
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/neon=
ode,zforce.yaml b/Documentation/devicetree/bindings/input/touchscreen/neono=
de,zforce.yaml
> > > new file mode 100644
> > > index 000000000000..1c45adb2407a
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/input/touchscreen/neonode,zfo=
rce.yaml
> > > @@ -0,0 +1,67 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/input/touchscreen/neonode,zforce.=
yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Neonode infrared touchscreen controller
> > > +
> > > +maintainers:
> > > +  - Heiko Stuebner <heiko.stuebner@bqreaders.com> =20
> >=20
> > It;d be good to CC the person you're volunteering! I've done so.
> >=20
> well, apparently my get_maintainer.pl | confirm_and_add_addresses | git s=
end-email
> script did not run in the kernel checkout I applied the patch to, so it d=
id
> not catch that address. Sorry.

> BTW: What is common practice for the maintainer address
> in the binding in conversions? Here I looked at the commits of the plaint=
ext binding.

Yeah, that seems reasonable to me.

--J+9iqmHLWvb13iO/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZN0NdwAKCRB4tDGHoIJi
0rBHAP0asQP/9+46aWItDl5XgvW5fAIVD6sf70nmci07F9z4XgEA1SF1/UyaWI/h
KJsRYfqvyukvn7hO0faEMzXwz1+VZw8=
=Grf5
-----END PGP SIGNATURE-----

--J+9iqmHLWvb13iO/--

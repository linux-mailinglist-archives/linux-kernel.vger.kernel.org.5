Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283457581A3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjGRQE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjGRQE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:04:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618B8EE;
        Tue, 18 Jul 2023 09:04:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2F5A61636;
        Tue, 18 Jul 2023 16:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B152C433C8;
        Tue, 18 Jul 2023 16:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689696266;
        bh=KpLtuC/owlDra2MRE8Ta8/1qVd8xTu4USdwqr246vPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hGzvBXN2It4iW5ZVxE7FEZIkGeWmc1fn75D/PIR1wyodsQn2eG5agjcGTZ8veMOlW
         I+9bIX6Tii3Ym69X5c3jj6DbzBQL+L9LocKNFFHS9QWwEboflAxZBLv+Xi07xoIwZG
         NAaIRkWSnjS+fn+UOAyOH/T050pgXpXzmygkCUPcq1AVfb9pYFwMAUGVFIKJMpGyfx
         NeCP3WaCKKqoNtnTzw99NNy9rpvLENWV4oyTYAj5dsW9lcDy38m5rBWzmaTP4JtDIo
         SvIFGsewl9EB14iQyxS1wCIbg4t3oSsD4/Fckujqb8mNZvBrh8cpT3tEyHUt7BGXd0
         Tx/DUqCpBSLxA==
Date:   Tue, 18 Jul 2023 17:04:21 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/4] dt-bindings: display: st7789v: add jasonic
 jt240mhqs-hwt-ek-e3 display
Message-ID: <20230718-popper-unrivaled-dae204940094@spud>
References: <20230718-feature-lcd-panel-v1-0-e9a85d5374fd@wolfvision.net>
 <20230718-feature-lcd-panel-v1-2-e9a85d5374fd@wolfvision.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dfkE5JaiJoHSnNRG"
Content-Disposition: inline
In-Reply-To: <20230718-feature-lcd-panel-v1-2-e9a85d5374fd@wolfvision.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dfkE5JaiJoHSnNRG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 05:31:51PM +0200, Michael Riesch wrote:
> Add compatible for the Jasonic Technology Ltd. JT240MHQS-HWT-EK-E3
> display.
>=20
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml | =
1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7=
789v.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7789=
v.yaml
> index 905c064cd106..eb1a7256ac32 100644
> --- a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.ya=
ml
> +++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.ya=
ml
> @@ -18,6 +18,7 @@ properties:
>      enum:
>        - edt,et028013dma
>        - inanbo,t28cp45tn89-v17
> +      - jasonic,jt240mhqs-hwt-ek-e3

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>        - sitronix,st7789v
> =20
>    reg: true
>=20
> --=20
> 2.30.2
>=20

--dfkE5JaiJoHSnNRG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLa4BAAKCRB4tDGHoIJi
0lGcAQCzZ+ilxAtoiJh6JOa61LrzqrMCGZ9S+wVR5O9qT33nTgEA4xpTjrWZ96u0
CmzULkM3CKVNhgrk4IxAI6N16acLAwM=
=0upB
-----END PGP SIGNATURE-----

--dfkE5JaiJoHSnNRG--

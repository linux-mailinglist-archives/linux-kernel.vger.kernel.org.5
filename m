Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44A47D226F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 11:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjJVJyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 05:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVJyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 05:54:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7A6E3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 02:54:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2B6C433C7;
        Sun, 22 Oct 2023 09:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697968448;
        bh=624DD86ruJdAKpRg5DvcZ6DGc3A5gO4DA0XsTE9YA0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eg4EW7zJrsPBLSVaMUUnDDNajHiROoE+x3HBZGuDv6Tr9dMd4wz4iI3QVbM/tPniz
         1TfwJNEPsBnUxThdnNrY/rZoTl9pJdxhJkMxT497V0bTNpRgL6FR+FF2uhL51BNp20
         mWUMBTt7MYZwM/aPak79Fro/jb/mqhv2smWYyz+hY1SK/5w8AViUICDGlZiCopPtBu
         sjL9T6AfHrQJL0W/MQOtgEXzmamuchjR89WTBSCvTcboRboFzDRBkFpjb5IRQLooLV
         q94UDvDjDc6jIM/0t/y2IzemQvfNgWHIMfVpU8ugMWB+5e8ZSD2QoZrGuqaeBcbtKM
         /MGmbIpQ/+pfA==
Date:   Sun, 22 Oct 2023 10:54:03 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] dt-bindings: display: ssd132x: Remove '-' before
 compatible enum
Message-ID: <20231022-sandbox-reverend-7651a2e00a7d@spud>
References: <20231020223029.1667190-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AzbL4NimfEVzMx25"
Content-Disposition: inline
In-Reply-To: <20231020223029.1667190-1-javierm@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AzbL4NimfEVzMx25
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 21, 2023 at 12:30:17AM +0200, Javier Martinez Canillas wrote:
> This is a leftover from when the binding schema had the compatible string
> property enum as a 'oneOf' child and the '-' was not removed when 'oneOf'
> got dropped during the binding review process.
>=20
> Reported-by: Rob Herring <robh@kernel.org>
> Closes: https://lore.kernel.org/dri-devel/CAL_Jsq+h8DcnpKqhokQOODCc8+Qi3M=
0PrxRFKz_Y4v37yMJvvA@mail.gmail.com/
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>=20
>  .../devicetree/bindings/display/solomon,ssd132x.yaml      | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd132x.ya=
ml b/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml
> index 0aa41bd9ddca..37975ee61c5a 100644
> --- a/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml
> @@ -11,10 +11,10 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    - enum:
> -        - solomon,ssd1322
> -        - solomon,ssd1325
> -        - solomon,ssd1327
> +    enum:
> +      - solomon,ssd1322
> +      - solomon,ssd1325
> +      - solomon,ssd1327
> =20
>  required:
>    - compatible
> --=20
> 2.41.0
>=20

--AzbL4NimfEVzMx25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTTxOwAKCRB4tDGHoIJi
0oktAQDIz4f+vI7vkhhIDLAgUw9zdMfHk5TeYQwpzVwoeucoCAEAmzoJ7v2hDg0C
eX6hl7pSU/Oi61+XBX2HNiVYH3ykpgI=
=UhsP
-----END PGP SIGNATURE-----

--AzbL4NimfEVzMx25--

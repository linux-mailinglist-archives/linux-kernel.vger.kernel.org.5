Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620D7767E0F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 12:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjG2KNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 06:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjG2KNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 06:13:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564E81980;
        Sat, 29 Jul 2023 03:13:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D72E160B5C;
        Sat, 29 Jul 2023 10:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D28C433C7;
        Sat, 29 Jul 2023 10:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690625594;
        bh=e5qRP58sXUjxxjVtvykFY2nDh4nODzU0OW9ZJXKMiHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gWsv+BT5TiVW2HgwHrYaki7yauIZECpn8pjC0wHgTOGA/SvdFagSy9B7PNPhMSQ4z
         /3Hvriu2otr2fI7ysVxMGeEvUHdjxv6O07ope55PNwXE2fdoyBLjRDg7EzWGZrE5VG
         I0pXWVTxNXLXk/1J4USlWHds3gU1CvIvj00AbM4VgM2UyMkouGsxyGt/eCHK56+ftU
         QvlxzxaX3v0VV6JatvSC1nCHZySG5Yv/Mr4YtKCTv4+ZsdowJU9jHIoW6en74g8brT
         pVOarJvHkkpkEiCV6tEHe3K2y5ybLMSqWy2Ayr9jiQJ+1Zl0eRNMjLi68eS5gK4CEs
         0qvH+V466Mxkw==
Date:   Sat, 29 Jul 2023 11:13:09 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Varshini Rajendran <varshini.rajendran@microchip.com>
Cc:     claudiu.beznea@microchip.com, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        codrin.ciubotariu@microchip.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 31/50] ASoC: dt-bindings: microchip: add sam9x7
Message-ID: <20230729-contently-gopher-27c3ee182aaa@spud>
References: <20230728102828.266861-1-varshini.rajendran@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jbAX9C9n+mrlLIx0"
Content-Disposition: inline
In-Reply-To: <20230728102828.266861-1-varshini.rajendran@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jbAX9C9n+mrlLIx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 03:58:28PM +0530, Varshini Rajendran wrote:
> Add sam9x7 compatible in the DT documentation.
>=20
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  .../bindings/sound/microchip,sama7g5-i2smcc.yaml      | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/microchip,sama7g5-i2=
smcc.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-i2smc=
c.yaml
> index 651f61c7c25a..fb630a184350 100644
> --- a/Documentation/devicetree/bindings/sound/microchip,sama7g5-i2smcc.ya=
ml
> +++ b/Documentation/devicetree/bindings/sound/microchip,sama7g5-i2smcc.ya=
ml
> @@ -24,9 +24,14 @@ properties:
>      const: 0
> =20
>    compatible:
> -    enum:
> -      - microchip,sam9x60-i2smcc
> -      - microchip,sama7g5-i2smcc
> +    oneOf:
> +      - enum:
> +          - microchip,sam9x60-i2smcc
> +          - microchip,sama7g5-i2smcc
> +      - items:
> +          - enum:
> +              - microchip,sam9x7-i2smcc
> +          - const: microchip,sam9x60-i2smcc

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--jbAX9C9n+mrlLIx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMTmNQAKCRB4tDGHoIJi
0iM1AQCyockr49QodvoBZKhRj4Gd4MI3M+haAHo6hUQYCjQvtgD+OBIg06DrKxU5
mH4EWIWlfM0YArsyJUFo8x5egfkCcw0=
=XpDA
-----END PGP SIGNATURE-----

--jbAX9C9n+mrlLIx0--

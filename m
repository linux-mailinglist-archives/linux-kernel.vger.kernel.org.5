Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DED79D676
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbjILQhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236874AbjILQhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:37:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90162115;
        Tue, 12 Sep 2023 09:37:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35ED1C433C7;
        Tue, 12 Sep 2023 16:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694536632;
        bh=OJuoXIE82hjK2NBMYhWXwpJGkmlI7rC+5Tx9u3yV2tM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ps2S5DYSbulUYf7oy7lT6QUeIC8SEE8uDrovxyzlP1aFanperwJfPxgxOSDoMicdj
         QPhK/QjxkpPvjv2poRuKEjUgTqjp60TdQnRQmmahJid4JusPVASg0K1uVbLr45UAB9
         O+q5IVvxkSBtPB4uIoSzebjqIZKeWLsg1NRa9ESumUogVOWqga9FHZ4uTwbMwFliV4
         inf0fEeH4WTZISjvzOruneKr+bXI0QcpZaEpr0gdpaoAWUmP+DefmPc84zsLhd9NP2
         YObhh1gBw/Dws7ynhREpR3QXWW0o3PhgfgfBYRLDlXE9yJVBmWttawahid5gfYz9Cd
         Kjln+OFCXKa7w==
Date:   Tue, 12 Sep 2023 17:37:03 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Simon Horman <horms@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 07/31] dt-bindings: soc: fsl: cpm_qe: cpm1-scc-qmc:
 Add 'additionalProperties: false' in child nodes
Message-ID: <20230912-pancreas-hacked-ddcaa726fa8e@spud>
References: <20230912081527.208499-1-herve.codina@bootlin.com>
 <20230912081527.208499-8-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H5/71ZKZWMUncSI5"
Content-Disposition: inline
In-Reply-To: <20230912081527.208499-8-herve.codina@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H5/71ZKZWMUncSI5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 10:14:58AM +0200, Herve Codina wrote:
> Additional properties in child node should not be allowed.
>=20
> Prevent them adding 'additionalProperties: false'
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml     | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-sc=
c-qmc.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-=
qmc.yaml
> index 450a0354cb1d..82d9beb48e00 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.y=
aml
> +++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.y=
aml
> @@ -64,6 +64,7 @@ patternProperties:
>      description:
>        A channel managed by this controller
>      type: object
> +    additionalProperties: false
> =20
>      properties:
>        reg:
> --=20
> 2.41.0
>=20

--H5/71ZKZWMUncSI5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQCTrwAKCRB4tDGHoIJi
0n+XAQCw6AgUOq0NyPZHrHWu5ogYxBjVGRRZ4L314GuJF/TwRAEA3G14ilDkYP5o
3fMneddHCQlNQIVPUgNd/ldquYguZwQ=
=eFLQ
-----END PGP SIGNATURE-----

--H5/71ZKZWMUncSI5--

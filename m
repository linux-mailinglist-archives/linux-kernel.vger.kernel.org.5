Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD0D7F657C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345456AbjKWRdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWRdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:33:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80085B9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:33:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EBEC433C7;
        Thu, 23 Nov 2023 17:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700760797;
        bh=woLJ62RYkt7tapNnqeAjaKeIkpTolDbLBY64GCRJz2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pgk6DEGHDHMD30MyZKcpHBIj2e4NiqNJ1+dNjOijT3YblPQbz8okp0NQtHY+MsU5R
         np1mse6z03lV4GlFofmHqkfRwFbF0JxdyaFfmNSwnrA3lTvkqn9b/OBB7zWU1+Bval
         LUAiz9hQO3g4erc5WkUpHpmyHdipBNAkEBUO6WcGj3AtiAOXtAMqGnm6/ldnMlaZVD
         tsnFBJ3XG1tpeBlXpzSJGnnA2ELEtFrwkLjKNFRanWSbInsgGy0d1i1aY9LwA4vang
         ppAnkWikW2OPCEHJiKOJ711+eyMFszHSdwr8hlPOkaKOLGPuS+g1FJ7AXL/XMAmBxG
         dxbDoNUx5LDLw==
Date:   Thu, 23 Nov 2023 17:33:11 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Michael Walle <mwalle@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: simple: add Evervision
 VGG644804 panel
Message-ID: <20231123-demote-landscape-4f49eea6f274@spud>
References: <20231123102404.2022201-1-mwalle@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v/MTmL7bd4PQXEjS"
Content-Disposition: inline
In-Reply-To: <20231123102404.2022201-1-mwalle@kernel.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v/MTmL7bd4PQXEjS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 11:24:03AM +0100, Michael Walle wrote:
> Add Evervision VGG644804 5.7" 640x480 LVDS panel compatible string.
>=20
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple=
=2Eyaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 3ec9ee95045f..2471c99a0c96 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -144,6 +144,8 @@ properties:
>        - edt,etmv570g2dhu
>          # E Ink VB3300-KCA
>        - eink,vb3300-kca
> +        # Evervision Electronics Co. Ltd. VGG644804 5.7" VGA TFT LCD Pan=
el
> +      - evervision,vgg644804
>          # Evervision Electronics Co. Ltd. VGG804821 5.0" WVGA TFT LCD Pa=
nel
>        - evervision,vgg804821
>          # Foxlink Group 5" WVGA TFT LCD panel
> --=20
> 2.39.2
>=20

--v/MTmL7bd4PQXEjS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV+M1wAKCRB4tDGHoIJi
0g5bAP4msuYt8MvmnmtOl4e/iBRX83HejY8bhwJ5ev0kBk7raQD40yYCRbaIBDL3
5u/TjYow9B+aexy90tzKAP86TVJqDA==
=OH5m
-----END PGP SIGNATURE-----

--v/MTmL7bd4PQXEjS--

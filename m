Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E607DE3B5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjKAO6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjKAO6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:58:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6103F126;
        Wed,  1 Nov 2023 07:57:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDFCC433C8;
        Wed,  1 Nov 2023 14:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698850679;
        bh=qZ55fdHQk3fOUH7BBLwgg60kJywx1z///E8C4Ry7qcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H/3xG3SFX7PDHOtADXzE4YbJjG/exugleZUqEh+ogcchr/T1P+qaR4u5fx6tswz1a
         Lr/wzBxwavLPhmlJGbkN/SHJfZ7CwkshltihiLxtEdUDDPJS37Vv1bOamOTXfCzQWQ
         9lVtV/DYv9xfEq0jMVSF9H/85mYxu+1Yeh9z2sqLEs8kcsR595AoJrG9EY5ReFzT9L
         +Fynq9w70G60KsumPx2DqHpRfIuddA2xL28GRRp7wr/Egsa9D6g79Eb2HhzstaZBrG
         7hxEnkIfECMh5jim+HCO8YB9XWp2WPYCerLJoyUt5wOZROZo1x9pHB6USpuAl0n7N2
         y3WRNMzRBh2Vw==
Date:   Wed, 1 Nov 2023 14:57:53 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        Umang Jain <umang.jain@ideasonboard.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] media: dt-bindings: media: imx335: Add supply
 bindings
Message-ID: <20231101-subscribe-massive-0a719216375d@spud>
References: <20231101131354.2333498-1-kieran.bingham@ideasonboard.com>
 <20231101131354.2333498-2-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lQ4u7dUvhW08tIKL"
Content-Disposition: inline
In-Reply-To: <20231101131354.2333498-2-kieran.bingham@ideasonboard.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lQ4u7dUvhW08tIKL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 01:13:49PM +0000, Kieran Bingham wrote:
> Add the bindings for the supply references used on the IMX335.
>=20
> Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
>=20
> ---
> v2:
>  - Remove the supplies from required properties to prevent ABI breakage.
>=20
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

FYI, double signoff, mb your tooling be acting up.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--lQ4u7dUvhW08tIKL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUJncQAKCRB4tDGHoIJi
0jZTAP0bt39/eWWvtTOSVDEayTA4j0xHSp8Iavc0vz1ukk7xCgD/UDcU1kFM8Quz
jMgQ0BcQwjWaSf6B4kT8z16SUQbUNwk=
=QzoB
-----END PGP SIGNATURE-----

--lQ4u7dUvhW08tIKL--

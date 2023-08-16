Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E5A77E3C8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343730AbjHPOjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343753AbjHPOiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:38:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F2E2D41;
        Wed, 16 Aug 2023 07:38:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96D6863FD9;
        Wed, 16 Aug 2023 14:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42698C433C8;
        Wed, 16 Aug 2023 14:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692196692;
        bh=wAA3WePHJSoHVgxkU3KiZytlFD8F7FCW7Hbk/uZSCGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NVgNgu63cFaxLiCNMANcOgomGY8QLmO2yCAxa2dxkePn/NytnJ+DTy9SWCLuaJfW+
         +L8tjYp4N/Fm8dLgNAgPzWDGFG75XFs2EyOG4lUXHIlV2HEDjvdsH+hBrT1vm7K8fq
         HZ1DRuI15yUS+YZht81PvOGYAEqlPyOHJS3ENImGY4pyn2tuERq95nJimDaokPLow8
         x5uza3VFZ4xkpk52basr8ay5Jm6RpO6XyR60P9+vG81EBelMkPoQQSJnuNyIM3YCPh
         5WxR+xGZDQbH8A035fcewFXyxwHS7M8jva14J2nauC4v1yPvFDkxGaCSvQ16Uycjzc
         sxtvpoxnDuMTA==
Date:   Wed, 16 Aug 2023 15:38:07 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Mihai.Sain@microchip.com
Cc:     claudiu.beznea@tuxon.dev, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Nicolas.Ferre@microchip.com, Cristian.Birsan@microchip.com,
        alexandre.belloni@bootlin.com, andre.przywara@arm.com,
        Jerry.Ray@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrei.Simion@microchip.com
Subject: Re: [PATCH] ARM: dts: at91: sama5d29_curiosity: Add device tree for
 sama5d29_curiosity board
Message-ID: <20230816-asleep-move-ab8746612698@spud>
References: <20230804101043.4063-1-mihai.sain@microchip.com>
 <127fc712-d924-f27f-5449-33385e89d6c3@tuxon.dev>
 <PH8PR11MB6804E49B5946F4A9D60837E18213A@PH8PR11MB6804.namprd11.prod.outlook.com>
 <98d01db3-3eba-0731-0dd9-4310ed293bd6@tuxon.dev>
 <PH8PR11MB6804B1C6466C7A450A180D1D8215A@PH8PR11MB6804.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TC0LRDS6Pz+cbGoi"
Content-Disposition: inline
In-Reply-To: <PH8PR11MB6804B1C6466C7A450A180D1D8215A@PH8PR11MB6804.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TC0LRDS6Pz+cbGoi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 09:05:19AM +0000, Mihai.Sain@microchip.com wrote:
> Hi Claudiu,
>=20
> ----------------------
>=20
> Hi, Mihai,
>=20
> On 8/10/23 09:47, Mihai.Sain@microchip.com wrote:
> >> +&i2s0 {
> >> +     pinctrl-names =3D "default";
> >> +     pinctrl-0 =3D <&pinctrl_i2s0_default>;
> >> +     status =3D "okay";
> > I see no sound bindings on DT. Is there any reason for having this here?
> > # i2s0 bus is wired to RPi 40-pin connector. I want to have this node a=
nd its pinctrl here.
> > # i2c1, flx4-spi, pwm0, uart1 are also wired to Rpi connector, and are =
defined here.
> > # The same logic we apply also for mikroBUS sockets: i2c, pwm, spi and =
uart nodes are defined here.
> >
>=20
> Can you use it (either with user space tools or other kernel consumers) w=
/o additional device tree bindings?
> # Yes. We have added in dt-overlay the codec which uses the i2s0 and i2c1=
 nodes and pinctrls.

Can you please fix your mail client so that your replies are properly
quoted? I don't understand who is saying what here.

--TC0LRDS6Pz+cbGoi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNzfTgAKCRB4tDGHoIJi
0mskAQDqB7yvGCNZL5HLPqbFd4miuOsz8BFLD9vxbjY5k+x9XAD+NKe0JvyQzcBk
MW+H0TBbpXXo7VMYE0ttbiSKddZE1QI=
=X1ZD
-----END PGP SIGNATURE-----

--TC0LRDS6Pz+cbGoi--

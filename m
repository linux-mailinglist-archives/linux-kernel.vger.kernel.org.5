Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5599578C986
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 18:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbjH2QSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 12:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbjH2QS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 12:18:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C5AD7;
        Tue, 29 Aug 2023 09:18:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6707764416;
        Tue, 29 Aug 2023 16:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83DEC433C8;
        Tue, 29 Aug 2023 16:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693325899;
        bh=jnl6nZX2ShkzIlc495/dk1aw7DQqFvN9eYvidhh8edE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z8q6/yoa53lUtNQRR0ihnLfDXHz845k11SkRrUveLlbolmnYdNQ9WK7KLRJMa2OEF
         f4k+453uy7rlHUYYgrNv6BjWxRe3iroW6tTMam4KBzK4/A99r55KmWHnYDLlkAIiu5
         bD6/giQVKC3+YIugowkS3HlQusCOaAyO/COtI8lbebPeinC0Q5T3Jllqu6rT53GeRd
         lZxwGoYbFjGeFDSa9/96nkeeX01zP39ptCValyVyBkz7mqh/CNSr7apbP9fv5zGtyG
         v0GL2SZ19nr8VmxWPhS/+bRRvg8GYoygfPb4A1uLFS1TUe6f/S6A26aUbmS/ACBgUU
         McVsmCSFqBfzA==
Date:   Tue, 29 Aug 2023 17:18:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Marius.Cristea@microchip.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lars@metafoo.de, linux-kernel@vger.kernel.org, jic23@kernel.org,
        conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Message-ID: <20230829-banker-phrasing-a0b2652a4808@spud>
References: <20230829154133.40716-1-marius.cristea@microchip.com>
 <20230829154133.40716-2-marius.cristea@microchip.com>
 <20230829-legal-superjet-f992cdab2bd3@spud>
 <8db5512a9ccb0d4f3bb3b0e063c7b43e08e4dadd.camel@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cja5q3k8S8/clq6P"
Content-Disposition: inline
In-Reply-To: <8db5512a9ccb0d4f3bb3b0e063c7b43e08e4dadd.camel@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cja5q3k8S8/clq6P
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 04:01:00PM +0000, Marius.Cristea@microchip.com wrot=
e:
> Hi Conor
>=20
> On Tue, 2023-08-29 at 16:45 +0100, Conor Dooley wrote:
> > On Tue, Aug 29, 2023 at 06:41:32PM +0300,
> > marius.cristea@microchip.com=A0wrote:
> > > From: Marius Cristea <marius.cristea@microchip.com>
> > >=20
> > > This is the device tree schema for iio driver for
> > > Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
> > > Delta-Sigma ADCs with an SPI interface (Microchip's
> > > MCP3461, MCP3462, MCP3464, MCP3461R, MCP3462R,
> > > MCP3464R, MCP3561, MCP3562, MCP3564, MCP3561R,
> > > MCP3562R and MCP3564R analog to digital converters).
> > >=20
> > > Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> >=20
> > Did you intentionally drop my reviewed-by that I gave you on v4?
> >=20
>=20
> Sorry that was my mistake. I was not aware that I need to keep the
> reviewd-by that you have given me on v4, also on v5.

If you don't change anything meaningful, there's no need to drop the
tags. AFAICT, you changed nothing at all here.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--cja5q3k8S8/clq6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZO4aRwAKCRB4tDGHoIJi
0rHVAQDA8EI6/Xj/ZKdAnV7/eywNKhc0C3MYdK8GNpgy/PgFeAEA29heKk7C1NY5
Onqt571h0zoHG+mV/+qAg47LlsQSswY=
=fHrb
-----END PGP SIGNATURE-----

--cja5q3k8S8/clq6P--

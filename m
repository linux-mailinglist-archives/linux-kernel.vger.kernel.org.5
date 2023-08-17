Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8175277F285
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349147AbjHQI4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240114AbjHQI4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:56:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D6C210E;
        Thu, 17 Aug 2023 01:56:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 439F16195A;
        Thu, 17 Aug 2023 08:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6AA5C433C8;
        Thu, 17 Aug 2023 08:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692262564;
        bh=9bDuY4CAwq3emi0LWvjJSZGJSZqOemRjjqVz1VixD10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aDuAsDMmGzdgrTKeCwZIXfYjfwCOla4Adogr507rJhu5hwxy70453WMRqb6kDbGin
         084kqXUPx3hLfcm5089YuN4yUmNJ31dtreSK52kJjyBZjDaqqWVF6tKLgzPNxISWkS
         y5zuLjcSLauHN/E5KFBIUKmgdf46CYveBpYIjAbFI/Rfmgoqs2UxUZFt28tlLrq1CA
         sQfZ7jAbrOx7U9tJOHagYKL/wiragV5BTz0ar5G8KyozStfp3RL2c6TKJwSDmWgtJV
         P5lyPa5CWOE3K9e1A64kMjVomLtVZFMAQEDTmmXjA/B0ApeCWINd4tBW0B/n77mtTq
         v/MCkWrIKXcAA==
Date:   Thu, 17 Aug 2023 09:55:59 +0100
From:   Conor Dooley <conor@kernel.org>
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] dt-bindings: net: Add HPE GXP UMAC
Message-ID: <20230817-animate-aerosol-5c857b4ff9a9@spud>
References: <20230802201824.3683-1-nick.hawkins@hpe.com>
 <20230802201824.3683-4-nick.hawkins@hpe.com>
 <20230803-balance-octopus-3d36f784f776@spud>
 <AF599C90-1257-4C13-AF60-8680A812421A@hpe.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gJ6NujNNSkAlOeiD"
Content-Disposition: inline
In-Reply-To: <AF599C90-1257-4C13-AF60-8680A812421A@hpe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gJ6NujNNSkAlOeiD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 04:26:09PM +0000, Hawkins, Nick wrote:
> Hi Conor,
>=20
> Thanks for your feedback. I will provide an explanation below.
>=20
> > > +description:
> > > + HPE GXP 802.3 10/100/1000T Ethernet Unifed MAC controller.
> > > + Device node of the controller has following properties.
> > > +
> > > +properties:
> > > + compatible:
> > > + const: hpe,gxp-umac
> > > +
>=20
>=20
> > > + use-ncsi:
> > > + type: boolean
> > > + description:
> > > + Indicates if the device should use NCSI (Network Controlled
> > > + Sideband Interface).
>=20
>=20
> > How is one supposed to know if the device should use NCSI? If the
> > property is present does that mean that the mac hardware supports
> > it? Or is it determined by what board this mac is on?
> > Or is this software configuration?
>=20
> Hi Conor,
>=20
> There are two MAC's available in the ASIC but only one can support
> NCSI. Even though it supports NCSI does not mean the board has
> been physically wired to support it. In terms of the device tree I would
> expect the "use-ncsi" to be present in the dts board specific file.
>=20
> There will be hardware configurations where both MAC0 and MAC1
> will be using the SERDES connections. In that case there will be no
> NCSI available.
>=20
> Is a better description needed here to explain this?

Ah crap, I missed this yesterday - I think this came in as I was doing
my queue sweep. The improved description seems good to me, thanks for
adding to it.

--gJ6NujNNSkAlOeiD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZN3gnwAKCRB4tDGHoIJi
0rKVAQDPJoKAqlpV7Q1t6ED5S659aQuuZhr/DdhyowGt8aRpVwEA3LWLW16B+M6I
vz/Rwt5DU2t/EondExnJr/SQgyAHHgY=
=KkRV
-----END PGP SIGNATURE-----

--gJ6NujNNSkAlOeiD--

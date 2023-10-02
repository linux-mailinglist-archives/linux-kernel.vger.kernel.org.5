Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058987B5B31
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbjJBTVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjJBTVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:21:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877D3AC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 12:21:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B629C433C8;
        Mon,  2 Oct 2023 19:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696274467;
        bh=WeIQDK9C+Lg7sfwz7aMXeYG+hNY0EwrPIT8ROstC1zE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ujxy3EA76/Hrc6fXpKGNxLtcvwKse/DIua954gfHgtf92hdzm5adhY3WNGPkgeSew
         xMIrKJLzdjfrFVbB0+SMTcLXRBgfebAbR+jRf9J8ECj/85zQJGi3/akE58aKiZM7yV
         Urh41IF6V9IB1e75adR1zz2JK4FOIVTgjulExHKMAt6hBym8Yd3602xKrcqGJuDfZM
         J67zMDGbmS1HOLGbacowB7DHavlAHMa5bi1orU35l34rXz/uB0qqqg6PIlGTlRKP39
         jV0YK6rbSw/AR8Vp1UW4ZU+Q+rDNbH0fqQDtG4GHofC1HuoJyRSKMYK2BNZhgpFJre
         qRto3ILnFFLVg==
Date:   Mon, 2 Oct 2023 20:21:02 +0100
From:   Conor Dooley <conor@kernel.org>
To:     "Balas, Eliza" <Eliza.Balas@analog.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: misc: adi,axi-tdd: Add device-tree
 binding for TDD engine
Message-ID: <20231002-aggregate-scanner-3ca2ae69cf0c@spud>
References: <20230928092804.22612-1-eliza.balas@analog.com>
 <20230928092804.22612-2-eliza.balas@analog.com>
 <20231002163244.GA1886905-robh@kernel.org>
 <BN7PR03MB454508AF350D2DC96FE1743A97C5A@BN7PR03MB4545.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="89n6cpjAet9oXeM3"
Content-Disposition: inline
In-Reply-To: <BN7PR03MB454508AF350D2DC96FE1743A97C5A@BN7PR03MB4545.namprd03.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--89n6cpjAet9oXeM3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2023 at 04:46:26PM +0000, Balas, Eliza wrote:
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Monday, October 2, 2023 19:33
> > To: Balas, Eliza <Eliza.Balas@analog.com>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dool=
ey <conor+dt@kernel.org>; Derek Kiernan
> > <derek.kiernan@amd.com>; Dragan Cvetic <dragan.cvetic@amd.com>; Arnd Be=
rgmann <arnd@arndb.de>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>; linux-kernel@vger.kernel.org; devicetree@=
vger.kernel.org
> > Subject: Re: [PATCH v2 1/2] dt-bindings: misc: adi,axi-tdd: Add device-=
tree binding for TDD engine
> >=20
> > [External]
> >=20
> > On Thu, Sep 28, 2023 at 12:28:03PM +0300, Eliza Balas wrote:
> > > Add device tree documentation for the AXI TDD Core.
> > > The generic TDD controller is in essence a waveform generator
> > > capable of addressing RF applications which require Time Division
> > > Duplexing, as well as controlling other modules of general
> > > applications through its dedicated 32 channel outputs.
> > >
> > > The reason of creating the generic TDD controller was to reduce
> > > the naming confusion around the existing repurposed TDD core
> > > built for AD9361, as well as expanding its number of output
> > > channels for systems which require more than six controlling signals.
> > >
> > > Signed-off-by: Eliza Balas <eliza.balas@analog.com>
> > > ---
> > >  .../devicetree/bindings/misc/adi,axi-tdd.yaml | 65 +++++++++++++++++=
++
> > >  MAINTAINERS                                   |  7 ++
> > >  2 files changed, 72 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/misc/adi,axi-td=
d.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml =
b/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
> > > new file mode 100644
> > > index 000000000000..8938da801b95
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
> > > @@ -0,0 +1,65 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +# Copyright 2023 Analog Devices Inc.
> > > +%YAML 1.2
> > > +---
> > > +$id: https://urldefense.com/v3/__http://devicetree.org/schemas/misc/=
adi,axi-
> > tdd.yaml*__;Iw!!A3Ni8CS0y2Y!5Cxus2huppjhkiJZLWTpJEgA0IXdLZx4t0fS9J1yt0x=
gjp9g3Y1N5PbZ7pAcIkKU4WPbS_TR9yjTKw$
> > > +$schema: https://urldefense.com/v3/__http://devicetree.org/meta-
> > schemas/core.yaml*__;Iw!!A3Ni8CS0y2Y!5Cxus2huppjhkiJZLWTpJEgA0IXdLZx4t0=
fS9J1yt0xgjp9g3Y1N5PbZ7pAcIkKU4WPbS_RK8aQ9xw$
> > > +
> > > +title: Analog Devices AXI TDD Core
> > > +
> > > +maintainers:
> > > +  - Eliza Balas <eliza.balas@analog.com>
> > > +
> > > +description: |
> > > +  The TDD controller is a waveform generator capable of addressing RF
> > > +  applications which require Time Division Duplexing, as well as con=
trolling
> > > +  other modules of general applications through its dedicated 32 cha=
nnel
> > > +  outputs. It solves the synchronization issue when transmitting and=
 receiving
> > > +  multiple frames of data through multiple buffers.
> > > +  The TDD IP core is part of the Analog Devices hdl reference design=
s and has
> > > +  the following features:
> > > +    * Up to 32 independent output channels
> > > +    * Start/stop time values per channel
> > > +    * Enable and polarity bit values per channel
> > > +    * 32 bit-max internal reference counter
> > > +    * Initial startup delay before waveform generation
> > > +    * Configurable frame length and number of frames per burst
> > > +    * 3 sources of synchronization: external, internal and software =
generated
> > > +  For more information see the wiki:
> > > +  https://wiki.analog.com/resources/fpga/docs/axi_tdd
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,axi-tdd-2.00.a
> >=20
> > Where does this version number come from? I looked at the above link and
> > see versions such as '2021_R2', '2019_r2', etc. I didn't dig deeper
> > whether there's some per IP version.
> >=20
> > If you want to use version numbers, please document the versioning
> > scheme. For example, see
> > Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.tx=
t.
> >=20
> > Rob
>=20
> The version refers to the IP version. The version of the IP is also
> specified in its VERSION register (there is a drop down to expand the
> register map on the wiki page) which is verified by the driver during
> probe. "2021_R2" refers to the compatible tool version used for
> creating the FPGAIP Core.

If you have version registers in these IPs, what benefit does version
numbers in the compatible string bring?
Rather than using the version numbers to validate what the DT gave you,
which not the kernel's job IMO, why not just use the information from
the register to determine the version?

Cheers,
Conor.

--89n6cpjAet9oXeM3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRsYHgAKCRB4tDGHoIJi
0hNTAQDQKnn2rQiKo7g3PzTiisgKqyTMNHeg9GOBd8i9KiUhPAEAixAZhoF4bcci
ysMUNIYsa5zOPzAy4Vd24Y4FftL65wQ=
=zP/g
-----END PGP SIGNATURE-----

--89n6cpjAet9oXeM3--

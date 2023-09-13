Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350C779EBBE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241596AbjIMO4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241462AbjIMO43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:56:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8764AF;
        Wed, 13 Sep 2023 07:56:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43588C433C7;
        Wed, 13 Sep 2023 14:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694616985;
        bh=N3WTRGQRC2DCSVFNDD7+aWUBo/AuSWHVXjENW2+DJOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EDl19bbfcfT/eKzPy1uhctBEtgQfI7bioxWIylfDjw072ASF7Rw5chvVGEYf7ZXzv
         D6ag1C6uRMNTgmS0OE+PrgT1a/LUCCCodqAMoIEtHRHs/GW/opSjL/xEs9eHn91wax
         8nTuAR3br6x3XJ0MGLXMyxVSKPuxv6tPskLE/bjJ2hWrOluZFIy6koi5RjPh7gvRMb
         d1I5KXNTaevGJxYkrrG/oj/ikITlwP9pwOsKPraxh00tMQy67CUsQR01mmm9cwF98e
         sNCa/yk6JfFzQ79mk5ExQRgpVAKfLOlLcnwkbz0K8xylH3muVc7rGZsAx3ueDcvxo4
         7iiIZXZFS9rBA==
Date:   Wed, 13 Sep 2023 15:56:16 +0100
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
Subject: Re: [PATCH v5 08/31] dt-bindings: soc: fsl: cpm_qe: cpm1-scc-qmc:
 Add support for QMC HDLC
Message-ID: <20230913-oversold-delay-05368e5de9fe@spud>
References: <20230912081527.208499-1-herve.codina@bootlin.com>
 <20230912101018.225246-1-herve.codina@bootlin.com>
 <20230912-capable-stash-c7a3e33078ac@spud>
 <20230913092640.76934b31@bootlin.com>
 <20230913-unruly-recite-7dbbbd7e63e0@spud>
 <20230913165250.02bab2ad@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="an5JAs7matqyH5h+"
Content-Disposition: inline
In-Reply-To: <20230913165250.02bab2ad@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--an5JAs7matqyH5h+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 04:52:50PM +0200, Herve Codina wrote:
> On Wed, 13 Sep 2023 15:42:45 +0100
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Wed, Sep 13, 2023 at 09:26:40AM +0200, Herve Codina wrote:
> > > Hi Conor,
> > >=20
> > > On Tue, 12 Sep 2023 18:21:58 +0100
> > > Conor Dooley <conor@kernel.org> wrote:
> > >  =20
> > > > On Tue, Sep 12, 2023 at 12:10:18PM +0200, Herve Codina wrote: =20
> > > > > The QMC (QUICC mutichannel controller) is a controller present in=
 some
> > > > > PowerQUICC SoC such as MPC885.
> > > > > The QMC HDLC uses the QMC controller to transfer HDLC data.
> > > > >=20
> > > > > Additionally, a framer can be connected to the QMC HDLC.
> > > > > If present, this framer is the interface between the TDM bus used=
 by the
> > > > > QMC HDLC and the E1/T1 line.
> > > > > The QMC HDLC can use this framer to get information about the E1/=
T1 line
> > > > > and configure the E1/T1 line.
> > > > >=20
> > > > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > > > ---
> > > > >  .../bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml   | 13 +++++++=
++++++
> > > > >  1 file changed, 13 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl=
,cpm1-scc-qmc.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,c=
pm1-scc-qmc.yaml
> > > > > index 82d9beb48e00..b5073531f3f1 100644
> > > > > --- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-s=
cc-qmc.yaml
> > > > > +++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-s=
cc-qmc.yaml
> > > > > @@ -101,6 +101,16 @@ patternProperties:
> > > > >            Channel assigned Rx time-slots within the Rx time-slot=
s routed by the
> > > > >            TSA to this cell.
> > > > > =20
> > > > > +      compatible:
> > > > > +        const: fsl,qmc-hdlc
> > > > > +
> > > > > +      fsl,framer:
> > > > > +        $ref: /schemas/types.yaml#/definitions/phandle
> > > > > +        description:
> > > > > +          phandle to the framer node. The framer is in charge of=
 an E1/T1 line
> > > > > +          interface connected to the TDM bus. It can be used to =
get the E1/T1 line
> > > > > +          status such as link up/down.   =20
> > > >=20
> > > > Sounds like this fsl,framer property should depend on the compatible
> > > > being present, no? =20
> > >=20
> > > Well from the implementation point of view, only the QMC HDLC driver =
uses this
> > > property.
> > >=20
> > > From the hardware description point of view, this property means that=
 the time slots
> > > handled by this channel are connected to the framer. So I think it ma=
kes sense for
> > > any channel no matter the compatible (even if compatible is not prese=
nt).
> > >=20
> > > Should I change and constraint the fsl,framer property to the compati=
ble presence ?
> > > If so, is the following correct for this contraint ?
> > >    --- 8< ---
> > >    dependencies:
> > >      - fsl,framer: [ compatible ];
> > >    --- 8< --- =20
> >=20
> > The regular sort of
> > if:
> > 	compatible:
> > 		contains:
> > 			const: foo
> > then:
> > 	required:
> > 		- fsl,framer
> > would fit the bill, no?
>=20
> Not sure.
> "fsl,framer" is an optional property (depending on the hardware we can ha=
ve
> a framer or not).

Ah apologies, I had it backwards! Your suggestion seems fair in that
case.

Thanks,
Conor.

--an5JAs7matqyH5h+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQHNkAAKCRB4tDGHoIJi
0rk4AP9tF09K9UpnoFfoFVhxs4hN1zi4zumz8pDO+w2kSvpj+wD/U+zvPN42popV
KEeEL83/RHxkPDfOblyLbLTsTcrtZgA=
=fzsq
-----END PGP SIGNATURE-----

--an5JAs7matqyH5h+--

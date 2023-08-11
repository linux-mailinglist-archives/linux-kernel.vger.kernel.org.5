Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394DF7787AE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 08:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjHKGym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 02:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjHKGyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:54:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A5DE7E;
        Thu, 10 Aug 2023 23:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691736881; x=1723272881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BsK4TCop8Tvvq64YuM67VXvxRYKw44rbaUJs8CrYGWQ=;
  b=fLjyw5GGuHSjFOWRNJql3ZJET3VIgVxm78JLDlElLrfUSyRGdF4uB5EX
   W/Jd4yUaTog9iaH4c3JyTTBiDeUZOGAqFAyMudJdVrwYaxVGocZUyRuWf
   VPPWvDqX+EXn452JV3o+PSPhNfnG8W2bwXn15SmG8WI/wWSwN3ja0+A6p
   nH4Oyi3g5S4ZUJqTXM9GRbgEZlV1xdx7/VyPGRclUUyVLXhc1vLe6j7M+
   VBY5tGDWQjOwjt+wSbxCFrbWoM66zjvL3qvrgcKqYb3wHS3Rc6zAB6Ej/
   0Gtu3HmNof9162xmMv9nYEl+9BsOqT8udrbJDLHjjHOdxspTO7TeCqPdH
   w==;
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="asc'?scan'208";a="229270610"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Aug 2023 23:54:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 10 Aug 2023 23:54:32 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 10 Aug 2023 23:54:29 -0700
Date:   Fri, 11 Aug 2023 07:53:52 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>,
        David Heidelberg <david@ixit.cz>, Marek Vasut <marex@denx.de>,
        Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liu Ying <victor.liu@nxp.com>, <kernel@puri.sm>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: mxsfb: Exclude i.MX8MQ from power-domains
 requirement
Message-ID: <20230811-purgatory-obliged-1f0755ac88d2@wendy>
References: <20230730184120.94984-1-david@ixit.cz>
 <ZMonFSqutQRqs61n@qwark.sigxcpu.org>
 <20230810-embroider-seduce-ee4506e7608b@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ItxO9H8fCtDVgFN+"
Content-Disposition: inline
In-Reply-To: <20230810-embroider-seduce-ee4506e7608b@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ItxO9H8fCtDVgFN+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 08:30:21PM +0100, Conor Dooley wrote:
> On Wed, Aug 02, 2023 at 11:51:17AM +0200, Guido G=FCnther wrote:
> > Hi,
> > On Sun, Jul 30, 2023 at 09:41:20PM +0300, David Heidelberg wrote:
> > > i.MX8MQ uses as secondary compatible fsl,imx6sx-lcdif, which triggers
> > > requirement of power-domains, thou it's not required.
> > >=20
> > > Fixes: f62678a77d58 ("dt-bindings: mxsfb: Document i.MX8M/i.MX6SX/i.M=
X6SL power-domains property")
> > >=20
> > > Signed-off-by: David Heidelberg <david@ixit.cz>
> > > ---
> > >  .../devicetree/bindings/display/fsl,lcdif.yaml        | 11 +++++++++=
--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml=
 b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > > index fc11ab5fc465..2d868276b0f9 100644
> > > --- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > > +++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > > @@ -129,8 +129,15 @@ allOf:
> > >                - fsl,imx8mp-lcdif
> > >                - fsl,imx93-lcdif
> > >      then:
> > > -      required:
> > > -        - power-domains
> > > +      if:
> > > +        properties:
> > > +          compatible:
> > > +            not:
> > > +              contains:
> > > +                const: fsl,imx8mq-lcdif
> > > +      then:
> > > +        required:
> > > +          - power-domains
> >=20
> > We currently enable the mipi power domain for the mipi dphy and nwl
> > bridge only but not for LCDIF itself assuming it's not needed (as there=
's
> > other outputs LCDIF can drive). I *think* this is correct but maybe
> > Marek or Liu can confirm?
>=20
> I'm happy to Ack this, but I've been sitting on it waiting to see if
> Marek or Liu popped up..

Well, I got two positive responses, so
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.



--ItxO9H8fCtDVgFN+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNXbAAAKCRB4tDGHoIJi
0ivxAQCX4HLM88F3C85q+xIpWfw/hZxtiBMY3aKnSvpKM2M+nAEAtRYGseVn9VrH
EcVfsRku0eySutPtAoQsqd9peXJm/g8=
=jTU0
-----END PGP SIGNATURE-----

--ItxO9H8fCtDVgFN+--

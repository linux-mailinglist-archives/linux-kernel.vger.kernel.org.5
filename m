Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6597766B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbjG1LH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbjG1LHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:07:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BC2271D;
        Fri, 28 Jul 2023 04:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690542444; x=1722078444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Aka8gvuYwnBE1qjG5Cx27//2rg7/9tsuBUh8r9GeeDU=;
  b=1Kfzbrru1N55O5j/yQvvKEQyQcgET5Jycy/5qjla6r+kJy1jL5XBYcui
   nuS+R+NrUFcQR8q9UwJxgoCXUWgpcVJl7mBLQ63JWiJzleRP22ol1TUE9
   4Ell5CZuSfeGvirsVlJPYAPJW9XjG/ECDwtpJBcM31JPtPNvEqDjKdcCC
   00SqKtJ3u/boypd3UnoxbJryyfMkR//9M3uekEujZPkT8wyCpHa5L+Hjx
   T46OBHGmf83QWpAH9HCZO8UzCePvD2rCy/NU1LauYO2WzzARn4I1Hk9ll
   Y2NLvgrB/J0E3xsRYruPLjebJqU8SKPpulVKrP5111k0jqvFBQSgEUfaC
   g==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="asc'?scan'208";a="226626857"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 04:07:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 04:07:12 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 28 Jul 2023 04:07:10 -0700
Date:   Fri, 28 Jul 2023 12:06:35 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Eric Lin <eric.lin@sifive.com>
CC:     Conor Dooley <conor@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <zong.li@sifive.com>,
        <greentime.hu@sifive.com>, <vincent.chen@sifive.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
Message-ID: <20230728-corrosive-crown-54dfd6dd3919@wendy>
References: <20230720135125.21240-1-eric.lin@sifive.com>
 <20230720135125.21240-2-eric.lin@sifive.com>
 <20230720-slept-guru-216e2803061e@spud>
 <20230728-facedown-husked-9813fa79d9a0@wendy>
 <CAPqJEFrObCSEXx+qTOp_JY3m5Ano59x=U4fFCBJ32ufLUx+6PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Yr02wk+FfM9y0tjy"
Content-Disposition: inline
In-Reply-To: <CAPqJEFrObCSEXx+qTOp_JY3m5Ano59x=U4fFCBJ32ufLUx+6PA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Yr02wk+FfM9y0tjy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 04:24:08PM +0800, Eric Lin wrote:
> On Fri, Jul 28, 2023 at 3:06=E2=80=AFPM Conor Dooley <conor.dooley@microc=
hip.com> wrote:
> > On Thu, Jul 20, 2023 at 06:10:51PM +0100, Conor Dooley wrote:
> > > On Thu, Jul 20, 2023 at 09:51:19PM +0800, Eric Lin wrote:

> > > > +description:
> > > > +  The SiFive Private L2 Cache Controller is per core and
> > > > +  communicates with both the upstream L1 caches and
> > > > +  downstream L3 cache or memory, enabling a high-performance
> > > > +  cache subsystem.
> > > > +
> > > > +allOf:
> > > > +  - $ref: /schemas/cache-controller.yaml#
> > > > +
> > >
> > > I'm pretty sure that I pointed out last time around that you need to =
add
> > > something like in the ccache driver:
> > >
> > > select:
> > >   properties:
> > >     compatible:
> > >       contains:
> > >         enum:
> > >           - sifive,ccache0
> > >           - sifive,fu540-c000-ccache
> > >           - sifive,fu740-c000-ccache
> > >
> > > otherwise this binding will be used for anything containing "cache" in
> > > the dt-binding.
> > > For this binding, I think that the following is sufficient:
> > >
> > > select:
> > >   properties:
> > >     compatible:
> > >       contains:
> > >           const: sifive,pl2cache1
> > >
>=20
> Sorry, I misunderstood your meaning.
> To be honest, I'm not quite familiar with the usage of the select propert=
y.
> When should we use the select property?
> May I ask, is there a document to detail introduce each property and
> its usage like the device-tree spec?
> I think it would be very helpful for beginners writing correct
> dt-binding and it can save much reviewers time.

You need this select because otherwise this binding will match against
every other user of "cache" in the tree. It's explained here:
https://docs.kernel.org/devicetree/bindings/writing-schema.html

Thanks,
Conor.

--Yr02wk+FfM9y0tjy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMOhOwAKCRB4tDGHoIJi
0gAsAP9n7SLd/UwEsj+M3d9jv2unEvtzM1+jOnjUIu5bDMSlkgD/f7qD0m5FiV5D
klvEB4+xPiMifa296wZGHkTM5YhzxAc=
=IuWE
-----END PGP SIGNATURE-----

--Yr02wk+FfM9y0tjy--

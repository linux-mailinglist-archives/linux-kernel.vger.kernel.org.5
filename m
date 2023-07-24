Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C7675F389
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjGXKja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjGXKj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:39:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFDFE55;
        Mon, 24 Jul 2023 03:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690195142; x=1721731142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eUPS2eKQuZV1PS+dulQY1U13BfYH8VlPDUoaYrp3SCU=;
  b=BEOHmDG+ltIIRbGk66rzmHZGaM+NkfX59u6BkkBxUiSAHAIZN7D9YzVx
   PA4GxGU6JV/tf1PZWKlH/Jg7KaTvMLH1y5fjYSVwN3Z1CS5zkOHZ9Gqnn
   JBEqcUXm6DK+exuHcYmjolAZ3+lrJm4CyJNgFx02RmuvuIFx2alshZhvZ
   cvroHNOOHBf9iCrmlrxbveTkLaQBe0JY69YzHxDz3HIU0JNjt0ekQmXVw
   0/H1ejeV7jcYEuFhT9d8qKCadDgw1BdQ0A8Fgn79D1H2DxA+DESO/obzW
   hxNVOqmcu/BRTYBAyguZAdae2ITPHCSxRKuiBAIbWPGtW2CwjoevFU/jq
   g==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="asc'?scan'208";a="237301218"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jul 2023 03:38:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 24 Jul 2023 03:38:33 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 24 Jul 2023 03:38:30 -0700
Date:   Mon, 24 Jul 2023 11:37:56 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jisheng Zhang <jszhang@kernel.org>
CC:     Drew Fustini <dfustini@baylibre.com>,
        Conor Dooley <conor@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>
Subject: Re: [PATCH 1/3] riscv: dts: thead: add BeagleV Ahead board device
 tree
Message-ID: <20230724-census-party-0a50d1563075@wendy>
References: <20230722-upstream-beaglev-ahead-dts-v1-0-ccda511357f4@baylibre.com>
 <20230722-upstream-beaglev-ahead-dts-v1-1-ccda511357f4@baylibre.com>
 <20230723-savor-trolling-e35ed4a7a751@spud>
 <ZL1jlacHj7sgNg8M@x1>
 <ZL3Eenj4lGZDhZTM@xhacker>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IYmJ4PmQz3geta1F"
Content-Disposition: inline
In-Reply-To: <ZL3Eenj4lGZDhZTM@xhacker>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--IYmJ4PmQz3geta1F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 08:23:22AM +0800, Jisheng Zhang wrote:
> On Sun, Jul 23, 2023 at 10:29:57AM -0700, Drew Fustini wrote:
> > On Sun, Jul 23, 2023 at 11:32:17AM +0100, Conor Dooley wrote:
> > > On Sat, Jul 22, 2023 at 02:55:39PM -0700, Drew Fustini wrote:
> > >=20
> > > > +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> > > > @@ -0,0 +1,61 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > >=20
> > > Hmm, should this not be dual licensed?
> > > I notice the other th1520 stuff isn't either..
> >=20
> > Good point, I'll resubmit with a dual license.
> >=20
> > Jisheng: are you okay with the other arch/riscv/boot/dts/thead files
> > changing to a dual license?
>=20
> When cooking the initial patch, I wrote the lpi4a dts files from
> scratch based on sipeed opened sch file, and currently only I made
> contributions to them, so it's easy to make the lpi4a dts files
> dual license.
>=20
> However, when constructing the th1520.dtsi, I refered the T-HEAD's
> opensourced yocto repo(in fact, that's the only sourcecode/doc I have
> at that time), and the license there is GPL-2.0. That's
> also the reason why copyright of Alibaba Group Holding Limited is
> added to th1520.dtsi. I'm not sure how to make th1520.dtsi dual
> license. At least, this needs help from Guo Ren. Any suggestion is
> appreciated.

I think Guo Ren Acking the change should be sufficient. It'd be good to
have them dual licensed to make it easier for other projects to include
the dts files from Linux. Almost all of what we have at the moment is
dual licensed, other than the Canaan stuff & some board dts files I got
=66rom customers that were only GPLed.

--IYmJ4PmQz3geta1F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL5UhAAKCRB4tDGHoIJi
0t3eAP0SIcy6zSf49cO2g9xepgYH48UogCXzOT92cUu2NKH05QEA5Fk0An0caUmn
SbO0ODosTVbVLHdioxciWhf1orRGXQM=
=Ii48
-----END PGP SIGNATURE-----

--IYmJ4PmQz3geta1F--

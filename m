Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4217A780A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjITJyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbjITJyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:54:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F144AB;
        Wed, 20 Sep 2023 02:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695203678; x=1726739678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xge9ahqJY3+sJNRIvwggXTWfNktjO7lkxZkLNMukJhk=;
  b=VK/JP0331SMsn7CecluLnh/WlejHO9GoWobSDNe+I5VKVw6ANA+Gry/w
   DE3Ncl7lzDYZR2decba23uyHJJ1JZXLSITAXMp1cB4ZSuRZ4p+cGcX0pa
   xcrC9k8WWqiQC43f2q3SxGOJhN9mLjI+psLL1O+07vyY9NNdAEwG/Fn/s
   pw7fsYb5zuqWJhsh+0tT/2eu4q14TgC4yPNbwb0cQJXxFKQ2ZR2tWEtvh
   ToXOgY7xt8t8/+Bzo52hxCpjUYJbODhxzbSSJG5GTo5ctnP/ACTm8vx5c
   7DnCS5Ov/We/JQUQI27YZngiQjv/BPz2HmY3Nc0HVGgntYBPIfAs5N5FV
   w==;
X-CSE-ConnectionGUID: ugFauFS5Q5Gyvh5Ditk4gA==
X-CSE-MsgGUID: 4GR16S+KSeCRebeA/mGKEQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="asc'?scan'208";a="172618278"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2023 02:53:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 20 Sep 2023 02:53:42 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 20 Sep 2023 02:53:39 -0700
Date:   Wed, 20 Sep 2023 10:53:22 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Inochi Amaoto <inochiama@outlook.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <aou@eecs.berkeley.edu>, <chao.wei@sophgo.com>, <conor@kernel.org>,
        <evicetree@vger.kernel.org>, <emil.renner.berthing@canonical.com>,
        <guoren@kernel.org>, <jszhang@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <robh+dt@kernel.org>, <xiaoguang.xing@sophgo.com>,
        Chen Wang <wangchen20@iscas.ac.cn>
Subject: Re: [PATCH v2 06/11] dt-bindings: timer: Add Sophgo sg2042 clint
Message-ID: <20230920-untimely-untagged-12b75e247afb@wendy>
References: <20230920-recount-chili-f80d5dc125e8@wendy>
 <IA1PR20MB4953F5FB42B8CAE4BEAC924CBBF9A@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fbzcNIeJ1H36uc+g"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953F5FB42B8CAE4BEAC924CBBF9A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--fbzcNIeJ1H36uc+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Wed, Sep 20, 2023 at 05:08:41PM +0800, Inochi Amaoto wrote:
> >On Wed, Sep 20, 2023 at 02:39:39PM +0800, Chen Wang wrote:
> >> From: Inochi Amaoto <inochiama@outlook.com>
> >>
> >> Add two new compatible string formatted like `C9xx-clint-xxx` to ident=
ify
> >> the timer and ipi device separately, and do not allow c900-clint as the
> >> fallback to avoid conflict.
> >>
> >> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> >> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
> >
> >Have you ignored Krzysztof's comments on this? I don't see a response or
> >a reaction to his comments about the compatibles on the last version.
> >Additionally, where is the user for these? I don't see any drivers that
> >actually make use of these.
> >
>=20
> Sorry for late reply and wrong message-id.
>=20
> The clint is parsed by sbi.

That needs to go in the commit message.

> As use the same compatible, the opensbi will
> parse the device twice. This will cause a fault.

Then only have one compatible with 2 register ranges? Then your SBI
implementation can use those two register ranges to find out the base
address for the mtimer bits and for the mswi bits.
I don't understand why this cannot be done, could you please explain.
I also don't see anything in the opensbi repo right now that is using
these (nor could I easily see any patches for opensbi adding this).
Is there another SBI implementation that you are using that I can take
a look at to try and understand this better?

> >Why do you need to have 2 compatibles (and therefore 2 devices) for the
> >clint? I thought the clint was a single device, of which the mtimer and
> >mswi bits were just "features"? Having split register ranges isn't a
> >reason to have two compatibles, so I must be missing something here...

> Sorry for late reply, The clint consists of mtimer and ipi devices, which
> is defined in [1].

Yes, I have looked at the spec. I went to check it again before replying
here in case there was something immediately obvious that I was missing.

> This standard shows clint(or the aclint) has two device,

The wording used here doesn't really matter. It's one interrupt
controller that does mtimer and mswi.

> but not one. In another word, there is no need to defined mtimer and ipi
> device on the same base address.

There's also no need to have two compatibles for the same interrupt
controller, so I do not get this reasoning. What actually _requires_
them to be split?

> So we need two compatibles to allow sbi to identify them correctly.

Why is it not sufficient to identify the individual memory regions?

Thanks,
Conor.

--fbzcNIeJ1H36uc+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQrBEgAKCRB4tDGHoIJi
0uE9AQDcuPiKQqOUfJofFw9tgJk/fYHI/izXyyDi+z1YBTla/wEAhRAmp8R3mIzv
GQ0/8xAitQFh1AQI59d7L68CJHPI0w4=
=FLtW
-----END PGP SIGNATURE-----

--fbzcNIeJ1H36uc+g--

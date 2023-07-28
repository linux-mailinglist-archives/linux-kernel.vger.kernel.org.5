Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08DC766A12
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbjG1KTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjG1KSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:18:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8CD3A84;
        Fri, 28 Jul 2023 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690539521; x=1722075521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4zd/F3UuyGO+qovy87KICDEK2ximibZdVG5bedGOv6I=;
  b=oVTLscJqEFAnLewq5m70iErRg2OQDe8Rnp/Hn/NUcnG6enR6JH6U5rls
   zGwo/kVQ97Z2YMWr/RzFGPCdvZ1LkD69gICcvWHzPTeXf/++S8B0wE6cq
   67YPa5P1C2vveHLzRvufvoQnfd3g1SeswRdWQVFtSElUd3fQZ1be8pUAP
   dfKYHd6LGy5Mypc94G34g0HOcNMR7gFMzsw93KXUWzzm+xixqiaHgVFiM
   DwRAuKv34e3OYYHHWESHn8ZbTwbjP/ucpE7yX0LSQVUnum8vWy5XSaBcI
   r4hBBenJB6MdSd3xGpCrYC4wLUgYybALHRKbZfLMyAQB3OSl/kog4nyNQ
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="asc'?scan'208";a="238400228"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:18:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:18:40 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 28 Jul 2023 03:18:37 -0700
Date:   Fri, 28 Jul 2023 11:18:03 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Huacai Chen <chenhuacai@kernel.org>
CC:     Yinbo Zhu <zhuyinbo@loongson.cn>, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        <wanghongliang@loongson.cn>, Liu Peibao <liupeibao@loongson.cn>,
        <loongson-kernel@lists.loongnix.cn>, Liu Yun <liuyun@loongson.cn>,
        <kernel@xen0n.name>
Subject: Re: [PATCH v5 0/2] soc: loongson2_pm: add power management support
Message-ID: <20230728-unedited-thank-366462ab471d@wendy>
References: <20230728074944.26746-1-zhuyinbo@loongson.cn>
 <20230728-cornball-preacher-a7e4644fcbef@wendy>
 <CAAhV-H5cfGZLvThzu_mBOphGJeUSFAu_4nZvGNFJqF5++DN2OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9Yys7cBeTncYwMRU"
Content-Disposition: inline
In-Reply-To: <CAAhV-H5cfGZLvThzu_mBOphGJeUSFAu_4nZvGNFJqF5++DN2OA@mail.gmail.com>
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

--9Yys7cBeTncYwMRU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 05:48:29PM +0800, Huacai Chen wrote:
> On Fri, Jul 28, 2023 at 4:44=E2=80=AFPM Conor Dooley <conor.dooley@microc=
hip.com> wrote:
> > On Fri, Jul 28, 2023 at 03:49:42PM +0800, Yinbo Zhu wrote:
> > > Loongson-2 platform support Power Management Controller (ACPI) and th=
is
> > > series patch was to add PM driver that base on dts and PM binding sup=
port.
> > >
> > > Change in v5:
> > >               1. The patch "[PATCH v3 1/3] loongarch: export some arc=
h-specific
> > >                  pm interfaces" had been merged into linux-next tree =
thus this
> > >                  v4 series patch need drop it and need depend on it a=
nd it's
> > >                  patch link was:
> > > https://lore.kernel.org/all/20230615091757.24686-2-zhuyinbo@loongson.=
cn/
> >
> > Just to note, it might be in linux-next, but more importantly it is also
> > in v6.5-rc1, so there is no issue with dependencies.
> >
> > >               2. Swap the positions of compatible for 2k1000 and 2k05=
00.
> >
> > I noticed you sent a mail pinging the v4 of this series yesterday as it
> > had not been picked up. Who do you actually expect to apply these
> > patches? There does not appear to be a maintainer listed for the
> > drivers/soc/loongson directory, just one for your GUTS driver.
> >
> > As a result, patches like
> > <https://lore.kernel.org/all/a69170cb55cfc73e378b40ccf1d9c16f@208suo.co=
m/>
> > have gone ignored. Granted, that patch is probably crap that does not
> > apply, due to 208suo.com people sending corrupted patches, but you the
> > point.
> >
> > More interestingly there is also
> > <https://lore.kernel.org/all/40b324af-3483-4b3d-b65a-a97944aa4a70@app.f=
astmail.com/>
> > which seems to have also gone missing (I don't see it in linux-next),
> > despite some discussion about how the patch should be merged.
> >
> > Looks to me like drivers/soc/loongson/ needs someone to take
> > responsibility for picking up patches for the directory & sending them
> > to the soc maintainers (with a new MAINTAINERS entry reflecting that) so
> > that patches don't fall through the cracks.

> As discussed when the guts driver gets merged, I think it is better to
> go via Arnd's soc tree for these patches under drivers/soc/loongson/.

Discussed perhaps, and that does seem to me like the correct thing to do,
but nobody actually did anything about it.
Somebody needs to set up a git tree, add a MAINTAINERS entry for the
directory, actually apply the patches and then send a PR to the soc
maintainers (as mentioned by Arnd in the second patch I linked there).

Perhaps that someone is you, or maybe it is Yinbo, up to you guys to
decide :)

Cheers,
Conor.


--9Yys7cBeTncYwMRU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMOV2wAKCRB4tDGHoIJi
0h5QAQCrVcz3iSUu0j4+XQQCxl/L4HK7TWqWDov3pdLYNimUlwEA4bjjRYTIub/6
aXIjVeWyrL+cfCrNxjWNDwoYvWjTzgY=
=87F1
-----END PGP SIGNATURE-----

--9Yys7cBeTncYwMRU--

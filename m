Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7131A7A6C61
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 22:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjISUif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 16:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjISUid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 16:38:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC5993
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 13:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1695155899; x=1695760699; i=j.neuschaefer@gmx.net;
 bh=kybDOh6D3XxyjaCVBL1N0978TW3OGvof2IUbAcUyp3w=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=n/34hMJMH8L/R/hFjO+G76BpgqwFeIED9Eq3lj2tXIrym57JKR3ivWTP2xs0egGUrReh9SueGe3
 k2dqBQGxTiL8RMIkazBkDS78b8dxaJ4/s90xqS1eRd324PGv5vY0F/lILIoPZVrghXrHlverbsgZt
 g/lGEA3MM3KJkOvDYOHCmlN1sQTQRydgZ058vCFViHsGwEjZByCTFm11449eSYiRDy7PS64r5R61W
 CmgWpUBrPa1YBMJEN3IJtU80Y2T993efSYSyjn51OcKmfC0Ronuu/6+2qq3k72DDd0+C7KiFC/hH3
 JXGzSqN8fmzaiIwzV2kLqRyR7Hx3BCtsHgGg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.0.47.152]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhlV-1qsLzJ474p-00AqrU; Tue, 19
 Sep 2023 22:38:19 +0200
Date:   Tue, 19 Sep 2023 22:38:17 +0200
From:   =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v4 1/2] soc: nuvoton: Add a menu for Nuvoton SoC drivers
Message-ID: <ZQoGuR6+7tJdjL6V@probook>
References: <20230814173757.1747439-1-j.neuschaefer@gmx.net>
 <CAMuHMdWTU8tN1QNrAT-BWgdrgzvJRvV6a30GcDAFq3qmF1CWag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i29JFbL/BmvFTG8c"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWTU8tN1QNrAT-BWgdrgzvJRvV6a30GcDAFq3qmF1CWag@mail.gmail.com>
X-Provags-ID: V03:K1:mHpdvxoTSe4sfNwZN7x8qDj8Q1Rpc+ZxRf+bNcMA/1nJUXQRQhH
 DLuC2Uk/VbJ5FRljHJHhwTdYxmkTIxZeL7WPCEe9ccPPTclbRwizYIXuZWqxmil14huW4XT
 6lYEmdLv4XQpIk6A4vlqrALpTh2LzBSl9Ko5+b/n1GQNMN/c2aLnLVwedD0zp+YanWkE/4y
 vtSL+BEgxbI28puDHRZ9g==
UI-OutboundReport: notjunk:1;M01:P0:zbHHiTGUaCw=;qxLsjRUwOqmJbX0qOpDXGnbnvrj
 mvkvakpVnBEHZ6Y+xJ8TSxw00li+Ss6L2s5qfNXLixs6lcz9SCRCAC8O3J6uTkX43tiZTQUww
 bp+y55bZCB93eA9JMV/w9Z/oGCx3YLpqgtB3n9XsHCASryzc/OxBODx5K1osML4egwSWRGOQo
 Cm850F8YHRJfNQWBdT0OvacSZveYziJd+Z3TjmrUKbEfI4iiv9b2Y3zB9h7cChV01OezhUWLt
 SdVd7OCMMpqQaAvXgKVufuiWXkAGLGhCsG8q6mrkCBXSfzhBuiDzQSdCa741i/d4evMiAio1H
 2ekaf+8sujGsnZ4Vk4+u6BtjlEDm2Dx8OYP8lAGPADctEYbAecz/O1TlwoVEgBgoIDI9sqFV8
 XDWpeEOraolgj2aGNfAFLxGPpHqOwA+ah6BYHEayNZl04tHksnrvxMn6CB0dUMPYY2JxSB48L
 pTGt1GJo2dIP0uwlakPu+6QWyYhJd8Yw3zYpdcWAJVVYFBqsptmNdt8kn+Z/8xJf2YnCqVuP3
 gp7D17hstGTaKyKjS0yq8pwp5nMxz+UTMxQuoqzdWjtA+2lrbs+lJOdqblhn1BKndkGQYIgJn
 V+o28n0MGhuyLBsxuX9F3uoj1c4wIBcSM3blUD/49l01rKnajnH5VxXmUmpUFqpsuHiLAh3Z4
 2ntOcPXLmKVe+13Q38ott2VU1WVe5zUAp8kZbR0h+iizDf2qa82pzGx6hhuvJ3BKy+yYjhO17
 FqTXbon36bQ3fC0SISZJWlgntH9toOjbO8ycnafjPUOLbrHEfmG6aDuIa3r+liYEPkb6R3jvk
 dLCs3DQpTPJdxj9JIhrCQGln9fxlZ1ylCOxR9jCatH+zNg8ZmhE9g3+ZX5wsW+QiFLQvBcWqE
 42njxPr0lSbXpN+JdxPTYsY4AMxWCNolLKYuM+NbzkEnEJyRfKiugrh7D0nmAQjvEGVp5q+3P
 FhSZeQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i29JFbL/BmvFTG8c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 01:37:01PM +0200, Geert Uytterhoeven wrote:
> Hi Jonathan,
>=20
> On Mon, Aug 14, 2023 at 7:38=E2=80=AFPM Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
> > Add a menu "Nuvoton SoC drivers" to make it easier to add other Nuvoton
> > SoC drivers later on and to prevent asking about the Nuvoton WPCM450 SoC
> > driver when configuring a kernel without support for Nuvoton SoCs.
> >
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Closes: https://lore.kernel.org/lkml/CAMuHMdWo5vHCeE6BeSHrUy12uT7_wFhW-=
VbQmQ5u+4Q8c7-wYQ@mail.gmail.com/
> > Fixes: 7dbb4a38bff3 ("soc: nuvoton: Add SoC info driver for WPCM450")
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v4:
> > - Add Geert's tag
> > - Fix commit reference
> > - Change Link tag to Closes
>=20
> Any plans to move this patch and patch 2/2 forward?
> Thanks!

I've been distracted by other projects, but I still want to move this
patchset forward. I will hopefully get around to it by the end of this week.


Thanks for the reminder,
Jonathan

--i29JFbL/BmvFTG8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmUKBpgACgkQCDBEmo7z
X9sGzQ//ZkXxXybWZnRwlpKSd3MQwxRRN26sQI7V8DFusqq8yA6dzJMzv0dYbNNT
BR0Z0CI6927jNBgAVBOrgE8laRCd2dk8gBgRfi7lEbEoG/+srPguxmZw5QoQgooL
xc/j+/xfPsCCJ/+HVkLImqVcx+MBB/L85FOGJ5WjQsjTHqjWuKiGM22oagIsk5Jm
tL0rafhiNLQH0UP8R8qBCdloSZW7KBKrQDZt1dxRkuq7F6To9yZ2pjm6bnwjVR9I
PuSu9EIgk+IcQ1pxk3mhrPzeixskooYFRY6GxNqHtIWfmBQI+aKA3QtA17p0r6Fn
MV2iwJlHa6dT3kqtdC12I/NLJJ4J37tF6iAHkLNAVO0pgGJH6ZprS0nDjNHL49o/
6VZvtirz1EWDlFx3EMVFXLinuhMP7WBVflVb5UIXeAxASHaDpvNzysyKXDzyIx3g
Al/mLyrrmscH5kVJn1/iI3lqckHoqbLYWL9pHDS3anmmq/FzxiUKFZ1gq+NO76+3
QNaMet0woYr62Z2So45bwxgDqsIMe13OiPEhNIcnARTJKLboemKQz3/mbK6YLdro
G9HH8eYM2OVXsRtmC85vIc3SVIHk9nUuzWzRFQnKTFzx4RmbPQyEoXz/wuDnpUuT
loA7prm/wNLHQp/bcjcT4rll0xQWkQKqDVSYyT3Q8zAEzfPnIxM=
=4UcE
-----END PGP SIGNATURE-----

--i29JFbL/BmvFTG8c--

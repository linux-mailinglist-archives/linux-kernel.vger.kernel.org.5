Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7092D76B4C1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjHAMaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjHAM37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:29:59 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646C910C7;
        Tue,  1 Aug 2023 05:29:56 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230801122952euoutp01c29376beab2d6dd40c14a80ff0b20257~3QjfiztQm1018410184euoutp01m;
        Tue,  1 Aug 2023 12:29:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230801122952euoutp01c29376beab2d6dd40c14a80ff0b20257~3QjfiztQm1018410184euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690892992;
        bh=Tv1dOBt1pYZQgdGfaYjYCzlbbtjNnj4TXEakpv6cTZU=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=NqqBW9LBg/HBzSBP9J+C/cH3RwenGEUK6Ylcj+M5+jnD4McClNb+HBG7SdFF4pHk4
         /UZK7MHmNrsAcjGVOO1FDP3FdBcTCyk3dzbhG9SAYVWBE0fFi23Kd2n/i00xbXe4tA
         v4DJanITK3gjeNkkpbmtisBurBvYFnzODy2N8EvI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230801122952eucas1p2053b13133bdfff8ed3c2df5823ace33d~3QjfXzB8k0373003730eucas1p27;
        Tue,  1 Aug 2023 12:29:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 97.35.37758.0CAF8C46; Tue,  1
        Aug 2023 13:29:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230801122952eucas1p122142fe815621be6238bd4c9ae343b98~3QjfG9Du91813718137eucas1p1q;
        Tue,  1 Aug 2023 12:29:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230801122952eusmtrp135a2f3b96769df24ef65cfb15e384a0f~3QjfGTrj10531305313eusmtrp1d;
        Tue,  1 Aug 2023 12:29:52 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-53-64c8fac0ca1a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CA.1F.10549.0CAF8C46; Tue,  1
        Aug 2023 13:29:52 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230801122952eusmtip28da22f351c55c8213cfb648e0eadc6f7~3Qje2cVGs2012620126eusmtip2V;
        Tue,  1 Aug 2023 12:29:52 +0000 (GMT)
Received: from localhost (106.210.248.165) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 1 Aug 2023 13:29:51 +0100
Date:   Tue, 1 Aug 2023 14:29:50 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Martin Schiller <ms@dev.tdt.de>
CC:     Xie He <xie.he.0141@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Hendry <andrew.hendry@gmail.com>,
        "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH net-next RFC] MAINTAINERS: Add Martin Schiller as a
 maintainer for the X.25 stack
Message-ID: <20230801122950.ptjqmyoyirawujhj@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="yggh5s5w2qb2usjg"
Content-Disposition: inline
In-Reply-To: <1a468a8132d38bf2c5429e33e0f67b79@dev.tdt.de>
X-Originating-IP: [106.210.248.165]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7djP87oHfp1IMWi/pm4x+7ijxd9Jx9gt
        5pxvYbG4sK2P1eLyrjlsFt/mnWC2OLZAzGJ29wdGBw6P378mMXpsWXmTyaP7yCtmj52z7rJ7
        bFrVyebxeZNcAFsUl01Kak5mWWqRvl0CV8bB7pXMBReUK1ae/87WwPhGpouRk0NCwETixp07
        bF2MXBxCAisYJbb1b4ByvjBK/Dt3kQnC+cwo8fj5ZTaYlv17N0JVLWeUWPhiMytc1c0F7YwQ
        zhZGiTUHV4C1sAioSGyffZ8ZxGYT0JE4/+YOkM3BISKgLLH2CTdIPbPAd0aJuwvWsIPUCAuk
        S3SeOcEEYvMKmEv8ejCTFcIWlDg58wkLiM0sUCFxq/0C2BxmAWmJ5f84QMKcAlYSG1seQV2q
        LLGk9RALhF0rcWrLLbB3JASWc0o8vrEQqshF4srri0wQtrDEq+Nb2CFsGYnTk3tYIBomM0rs
        //eBHcJZzSixrPErVIe1RMuVJ1AdjhLvF/WygVwkIcAnceOtIMShfBKTtk1nhgjzSnS0CUFU
        q0msvveGZQKj8iwkr81C8toshNcgwjoSC3Z/YsMQ1pZYtvA1M4RtK7Fu3XuWBYzsqxjFU0uL
        c9NTi43zUsv1ihNzi0vz0vWS83M3MQLT2+l/x7/uYFzx6qPeIUYmDsZDjCpAzY82rL7AKMWS
        l5+XqiTCK/37eIoQb0piZVVqUX58UWlOavEhRmkOFiVxXm3bk8lCAumJJanZqakFqUUwWSYO
        TqkGJj+BJ9EXT+Qw/1zt8Zdb6JfA0239kV9nLTvBfeXw82nrJtTZvEvmaUgXEuiT59vxf2P7
        Q9Oms6wHVAwq32mVnIhxP5CQt6D5h6/Wf7uD3375Gj402GU95dwr9rZI7hs60XPMa68/P/OR
        /4+uE9f93Ow5u8J7r6/4FF9ao91eVVWUv2eJbe7jNbPrD117e7hfoXu3jL72AtNrs7t0A3bd
        EX+Qcjwtuk3vCzPjQYvlW3a8qC/8Ni/7wgRD38+q7Oc7t3R+U2Nb73AujOn2J2td7fKlRWJH
        P3Bxvbv3Z7fAMy8dvi33T29KOpfd8upDmfTDNW3ca63CY0tfdPJLLyq42vPQ6qozq1fhq4cb
        3mXIKyixFGckGmoxFxUnAgDR/IpR6gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsVy+t/xe7oHfp1IMVj6WMBi9nFHi7+TjrFb
        zDnfwmJxYVsfq8XlXXPYLL7NO8FscWyBmMXs7g+MDhwev39NYvTYsvImk0f3kVfMHjtn3WX3
        2LSqk83j8ya5ALYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzM
        stQifbsEvYwZb/+zFpxTrpj07w5TA+MrmS5GTg4JAROJ/Xs3snUxcnEICSxllHjyoZUZIiEj
        sfHLVVYIW1jiz7UuqKKPjBIT+36ygySEBLYwSkx+ogJiswioSGyffR+smU1AR+L8mztANgeH
        iICyxNon3CC9zALfGSXuLlgD1isskC7ReeYEE4jNK2Au8evBTFaImXOYJM4eZoGIC0qcnPkE
        zGYWKJPYvuMa2ExmAWmJ5f84QMKcAlYSG1sesUHcqSyxpPUQC4RdK/H57zPGCYzCs5BMmoVk
        0iyESRBhLYkb/14yYQhrSyxb+JoZwraVWLfuPcsCRvZVjCKppcW56bnFhnrFibnFpXnpesn5
        uZsYgfG97djPzTsY5736qHeIkYmD8RCjClDnow2rLzBKseTl56UqifBK/z6eIsSbklhZlVqU
        H19UmpNafIjRFBiIE5mlRJPzgYknryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUg
        tQimj4mDU6qBiUN4Q6JC+74zCzeEyk76OufOlZDsY6p5d9+sWOaz3Ij/MeeNkGq11X7bL3y5
        wb/TyL1oV8PL1A138q4krenYvffcKuHQc15KUtbvcrbVKFmu0uDzMQsUXdtwpfz48f6pE38x
        zJuzzCLq6/cJO1qWB/+qFvvTIP5U/tT3BBtfj2f/LR1VXhuVympoVM62KfB8Vjtp5ZWfvktq
        he78+P7v1P6zB+10N/R/M9S9+XmJ7qXJ76ovZE2b3bb5zJudSZeDUgMU/YqX8gRLqvV95JU7
        rGvKdMzD01peST1FX8+zxlBQ48a52f+/qlheTn9s9ShG5gBLd2zo2Qkrk9fcOJSh/CA0gSeA
        /XSW6NK4l/8CnyuxFGckGmoxFxUnAgCeJCUqhAMAAA==
X-CMS-MailID: 20230801122952eucas1p122142fe815621be6238bd4c9ae343b98
X-Msg-Generator: CA
X-RootMTR: 20230801110904eucas1p2c09238963a8ff7726a50a68dc803d0c6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230801110904eucas1p2c09238963a8ff7726a50a68dc803d0c6
References: <20201111213608.27846-1-xie.he.0141@gmail.com>
        <7baa879ed48465e7af27d4cbbe41c3e6@dev.tdt.de>
        <CGME20230801110904eucas1p2c09238963a8ff7726a50a68dc803d0c6@eucas1p2.samsung.com>
        <20230801110902.ae24p3nltsudndw5@localhost>
        <1a468a8132d38bf2c5429e33e0f67b79@dev.tdt.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--yggh5s5w2qb2usjg
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Perfect.

Thx for confirming.
On Tue, Aug 01, 2023 at 01:16:04PM +0200, Martin Schiller wrote:
> On 2023-08-01 13:09, Joel Granados wrote:
> > Hey everyone
> >=20
> > I recently sent a patch and got a DNS error lookup for dev.tdt.de. Is
> > Martins mail still valid? Should it be updated?
>=20
> Hi Joel!
>=20
> Yes, I'm still alive and reachable. ;-)
>=20
> We had some technical issues with our DNS entry for the dev.tdt.de
> subdomain after adding an spf entry, which is fixed now.
>=20
> Regards,
> Martin
>=20
> >=20
> > Best
> >=20
> > On Thu, Nov 12, 2020 at 08:06:37AM +0100, Martin Schiller wrote:
> > > On 2020-11-11 22:36, Xie He wrote:
> > > > Hi Martin Schiller, would you like to be a maintainer for the X.25
> > > > stack?
> > > >
> > > > As we know the linux-x25 mail list has stopped working for a long t=
ime.
> > > > Adding you as a maintainer may make you be Cc'd for new patches so =
that
> > > > you can review them.
> > >=20
> > > About 1 year ago I was asked by Arnd Bergmann if I would like to
> > > become
> > > the maintainer for the X.25 stack:
> > >=20
> > > https://protect2.fireeye.com/v1/url?k=3Dcbe1c96b-947af072-cbe04224-00=
0babff3793-aa57099473c75eca&q=3D1&e=3D6392d959-6b44-4e7a-bdb2-eead35e1f540&=
u=3Dhttps%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Fnetdev%2Fpatch%2F2019120=
9151256.2497534-4-arnd%40arndb.de%2F%232320767
> > >=20
> > > Yes, I would agree to be listed as a maintainer.
> > >=20
> > > But I still think it is important that we either repair or delete the
> > > linux-x25 mailing list. The current state that the messages are going
> > > into nirvana is very unpleasant.
> > >=20
> > > >
> > > > The original maintainer of X.25 network layer (Andrew Hendry) has
> > > > stopped
> > > > sending emails to the netdev mail list since 2013. So there is
> > > > practically
> > > > no maintainer for X.25 code currently.
> > > >
> > > > Cc: Martin Schiller <ms@dev.tdt.de>
> > > > Cc: Andrew Hendry <andrew.hendry@gmail.com>
> > > > Signed-off-by: Xie He <xie.he.0141@gmail.com>
> > > > ---
> > > >  MAINTAINERS | 20 ++++++++++----------
> > > >  1 file changed, 10 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 2a0fde12b650..9ebcb0708d5d 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -9832,13 +9832,6 @@ S:	Maintained
> > > >  F:	arch/mips/lantiq
> > > >  F:	drivers/soc/lantiq
> > > >
> > > > -LAPB module
> > > > -L:	linux-x25@vger.kernel.org
> > > > -S:	Orphan
> > > > -F:	Documentation/networking/lapb-module.rst
> > > > -F:	include/*/lapb.h
> > > > -F:	net/lapb/
> > > > -
> > > >  LASI 53c700 driver for PARISC
> > > >  M:	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> > > >  L:	linux-scsi@vger.kernel.org
> > > > @@ -18979,12 +18972,19 @@ L:	linux-kernel@vger.kernel.org
> > > >  S:	Maintained
> > > >  N:	axp[128]
> > > >
> > > > -X.25 NETWORK LAYER
> > > > -M:	Andrew Hendry <andrew.hendry@gmail.com>
> > > > +X.25 STACK
> > > > +M:	Martin Schiller <ms@dev.tdt.de>
> > > >  L:	linux-x25@vger.kernel.org
> > > > -S:	Odd Fixes
> > > > +L:	netdev@vger.kernel.org
> > > > +S:	Maintained
> > > > +F:	Documentation/networking/lapb-module.txt
> > > >  F:	Documentation/networking/x25*
> > > > +F:	drivers/net/wan/hdlc_x25.c
> > > > +F:	drivers/net/wan/lapbether.c
> > > > +F:	include/*/lapb.h
> > > >  F:	include/net/x25*
> > > > +F:	include/uapi/linux/x25.h
> > > > +F:	net/lapb/
> > > >  F:	net/x25/
> > > >
> > > >  X86 ARCHITECTURE (32-BIT AND 64-BIT)

--=20

Joel Granados

--yggh5s5w2qb2usjg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTI+r4ACgkQupfNUreW
QU80owv/Qy0b+WMCmtK48yCIuX6Zu9wk6pwWgP/eQmwYU72ySeW+CvWuyExKVXWY
ojDQ9yShHCdc8BJ/ahLp6hmag7t8ywwt5bcG2DeNzX1xRn5ggUvnFzqwv44x9Ytc
Gm5+Ug/y6DSN8cSeQH7Lx3aXbIP1/ly8kBReRSUwZffGqg3vF4SJl3dCq4I3838r
IxLUQYA3olRdsEK5fFFO35b4q7TjzJmwxv0ta6pBIHoyb0oJtMSngAe4xUiBGQpF
fjjY5z+wS/SmwDpPd7KT8IGCjelOVpQTe15+9ctX0djapZWLMESURwhGYOu55Hit
5Q/dRu3irZs0qWUlb1S6Ai1rhBpJftQvVZ2pAZoiOP0SDOhRlTGsDeZhhSgFtOSO
hfO88thj2zOFTOsbNbwl9XEhiB3yRW+ciKjtYuqZm0Uq85f1S1Y+3G4vfge6bkfk
phMpqdjcV90UhMP7YaFnvGz9gXiXsgNFb93vksalcQCsUTKw1uPDQYV2I9QiFzuN
22CMbq/4
=5y0r
-----END PGP SIGNATURE-----

--yggh5s5w2qb2usjg--

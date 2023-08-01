Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DB276B2D2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjHALOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbjHALNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:13:40 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78A646A6;
        Tue,  1 Aug 2023 04:09:08 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230801110905euoutp01dda9be4ee20ed19a8a18fc6f0e6ebaf5~3Pc9VkK8M1817518175euoutp01l;
        Tue,  1 Aug 2023 11:09:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230801110905euoutp01dda9be4ee20ed19a8a18fc6f0e6ebaf5~3Pc9VkK8M1817518175euoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690888145;
        bh=nxaDJvtoa53tg9/5JeNAG2BsOI21G1BvaH4u2p7Enhs=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=tNTxZypO2C53E3MpOiys2SUbcjOs3lwFhelsP4K7v6bpbqvWgXaRKmiZNn9nKtVtZ
         Rw2iYvDJ89wsoUmYfSHjz89VK0rwUohsnAckwHUzKEwmrIsRYNMF5mrQPi0lcKt2s1
         2HSrlKkzcRII+x0rWl4Lhlt296muRzjG2GtdJgMs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230801110905eucas1p155f374e866abfc8ed4f50ecac13e9d2d~3Pc9FEcP41782317823eucas1p1z;
        Tue,  1 Aug 2023 11:09:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 23.A9.42423.1D7E8C46; Tue,  1
        Aug 2023 12:09:05 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230801110904eucas1p2c09238963a8ff7726a50a68dc803d0c6~3Pc8ihfz72292722927eucas1p2D;
        Tue,  1 Aug 2023 11:09:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230801110904eusmtrp2ed9957757d51d70e7cb405af6094b079~3Pc8h48nv1458914589eusmtrp2W;
        Tue,  1 Aug 2023 11:09:04 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-77-64c8e7d17b6a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E7.D0.14344.0D7E8C46; Tue,  1
        Aug 2023 12:09:04 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230801110904eusmtip11308ac1264ab31127b393bb6d1aa5aff~3Pc8Vq3-72985329853eusmtip1b;
        Tue,  1 Aug 2023 11:09:04 +0000 (GMT)
Received: from localhost (106.210.248.165) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 1 Aug 2023 12:09:04 +0100
Date:   Tue, 1 Aug 2023 13:09:02 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Martin Schiller <ms@dev.tdt.de>
CC:     Xie He <xie.he.0141@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Hendry <andrew.hendry@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH net-next RFC] MAINTAINERS: Add Martin Schiller as a
 maintainer for the X.25 stack
Message-ID: <20230801110902.ae24p3nltsudndw5@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="w5od6bkxbptofq3m"
Content-Disposition: inline
In-Reply-To: <7baa879ed48465e7af27d4cbbe41c3e6@dev.tdt.de>
X-Originating-IP: [106.210.248.165]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGKsWRmVeSWpSXmKPExsWy7djPc7oXn59IMZh6Ttpi9nFHi7+TjrFb
        zDnfwmJxYVsfq8XlXXPYLL7NO8FscWyBmMXs7g+MDhwev39NYvTYsvImk0f3kVfMHjtn3WX3
        2LSqk83j8ya5ALYoLpuU1JzMstQifbsErowr2yczFdyXqbj1aBFbA+Nv8S5GTg4JAROJd61T
        WLoYuTiEBFYwSjzufsQIkhAS+MIosXK+J0TiM5B9aiYbTMfa33MZIRLLgTpWrGGDq9q06DA7
        hLOFUWLJ/41gLSwCKhJTjj9hArHZBHQkzr+5w9zFyMEhIqAssfYJN0g9s8BXRon+B9dZQWqE
        BdIlOs+cAKvnFTCXeLukmQXCFpQ4OfMJmM0sUCFx8MtTVpA5zALSEsv/cYCEOQWsJE68+MIK
        camyxJLWQywQdq3EqS23mEB2SQgs55R4OesFI0TCRWLWwZnsELawxKvjW6BsGYn/O+dDNUxm
        lNj/7wM7hLOaUWJZ41cmiCpriZYrT6A6HCXeL+plA7lIQoBP4sZbQYhD+SQmbZvODBHmleho
        E4KoVpNYfe8NywRG5VlIXpuF5LVZCK9BhHUkFuz+xIYhrC2xbOFrZgjbVmLduvcsCxjZVzGK
        p5YW56anFhvmpZbrFSfmFpfmpesl5+duYgQmt9P/jn/awTj31Ue9Q4xMHIyHGFWAmh9tWH2B
        UYolLz8vVUmEV/r38RQh3pTEyqrUovz4otKc1OJDjNIcLErivNq2J5OFBNITS1KzU1MLUotg
        skwcnFINTLlWfVP4H+7va7Tw6RNbFp96XXLdxUuxVkH3p9W0fFR5wrDvWmZ3Db/JS5GpqQ+k
        /m7c7JzbUuBzeLVwqNLWkvOxPY/ybHJ5ek8UT3u2Niz0ZQ/TipkJEtlmWdkP33lanNossvPA
        zOM2Ye/mv7teNfNJcabRLHaGRU1O8h/907ac3+dYLKgc96j+IGvYxpxobW0W+RO3Z5xRSv8y
        x7575l+ZQ3PWSYs1dswsncyvVe2yb+p0m3XL/64wXFRUFLF2f45tjOWxuOBVfBZC3xRWro7g
        juoRr/xQfDYhUc4raZvc7MrM/FzHOOG7m6t4AyRDH2etyag0UqqampYjm5bXa7xZg0cpVCbG
        vDveVlmJpTgj0VCLuag4EQCeO2mK6QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsVy+t/xu7oXnp9IMfgzw9hi9nFHi7+TjrFb
        zDnfwmJxYVsfq8XlXXPYLL7NO8FscWyBmMXs7g+MDhwev39NYvTYsvImk0f3kVfMHjtn3WX3
        2LSqk83j8ya5ALYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzM
        stQifbsEvYxnx3exFNyVqejceo2pgfGneBcjJ4eEgInE2t9zGbsYuTiEBJYySjz6cYoJIiEj
        sfHLVVYIW1jiz7UuNoiij4wSrVOfsUM4WxglWg59YwOpYhFQkZhy/AlYN5uAjsT5N3eYuxg5
        OEQElCXWPuEGqWcW+MooMe31c7B6YYF0ic4zJ8DqeQXMJd4uaWYBsYUEsiRW7rrJDBEXlDg5
        8wlYnFmgTGLJuVOsIDOZBaQllv/jAAlzClhJnHjxBepQZYklrYdYIOxaic9/nzFOYBSehWTS
        LCSTZiFMgghrSdz495IJQ1hbYtnC18wQtq3EunXvWRYwsq9iFEktLc5Nzy020itOzC0uzUvX
        S87P3cQIjPBtx35u2cG48tVHvUOMTByMhxhVgDofbVh9gVGKJS8/L1VJhFf69/EUId6UxMqq
        1KL8+KLSnNTiQ4ymwECcyCwlmpwPTD15JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6Yklqdmp
        qQWpRTB9TBycUg1M9iZRE6ql1TXNnTI/bODfMKvwiw9nuEeq1Eu2krmfvzw1rfqxNkshfNbb
        rTOUGV3cr3GW3lr4YNnC5ad+sfpPcuTcpiU+Je7E2hj/y1s0FS9KX+A9Pa0u+W24uR0Do6lq
        gs8b6ckdDae/usyf/mb1jc9s/t7nps0rv9qo/GfrJZ72XNanfg9Svm7+f7837GuY8aZ5c8oO
        n5/x79WjTQzqN9jM3lW/lL9x959FV++2qOK9p/49Z9hcksvjmiXssu232+J1W3ZEsxcd/vKl
        5cWVX147vX6td+GTFVUtNKtKW7v+o3aHBL+0zIEZ3/fcYImRf3xAuY/r45rcFyIr+3ViP/CZ
        BcQVeK1937I0p+RMohJLcUaioRZzUXEiAGtQAjmFAwAA
X-CMS-MailID: 20230801110904eucas1p2c09238963a8ff7726a50a68dc803d0c6
X-Msg-Generator: CA
X-RootMTR: 20230801110904eucas1p2c09238963a8ff7726a50a68dc803d0c6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230801110904eucas1p2c09238963a8ff7726a50a68dc803d0c6
References: <20201111213608.27846-1-xie.he.0141@gmail.com>
        <7baa879ed48465e7af27d4cbbe41c3e6@dev.tdt.de>
        <CGME20230801110904eucas1p2c09238963a8ff7726a50a68dc803d0c6@eucas1p2.samsung.com>
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

--w5od6bkxbptofq3m
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey everyone

I recently sent a patch and got a DNS error lookup for dev.tdt.de. Is
Martins mail still valid? Should it be updated?

Best

On Thu, Nov 12, 2020 at 08:06:37AM +0100, Martin Schiller wrote:
> On 2020-11-11 22:36, Xie He wrote:
> > Hi Martin Schiller, would you like to be a maintainer for the X.25
> > stack?
> >=20
> > As we know the linux-x25 mail list has stopped working for a long time.
> > Adding you as a maintainer may make you be Cc'd for new patches so that
> > you can review them.
>=20
> About 1 year ago I was asked by Arnd Bergmann if I would like to become
> the maintainer for the X.25 stack:
>=20
> https://patchwork.ozlabs.org/project/netdev/patch/20191209151256.2497534-=
4-arnd@arndb.de/#2320767
>=20
> Yes, I would agree to be listed as a maintainer.
>=20
> But I still think it is important that we either repair or delete the
> linux-x25 mailing list. The current state that the messages are going
> into nirvana is very unpleasant.
>=20
> >=20
> > The original maintainer of X.25 network layer (Andrew Hendry) has
> > stopped
> > sending emails to the netdev mail list since 2013. So there is
> > practically
> > no maintainer for X.25 code currently.
> >=20
> > Cc: Martin Schiller <ms@dev.tdt.de>
> > Cc: Andrew Hendry <andrew.hendry@gmail.com>
> > Signed-off-by: Xie He <xie.he.0141@gmail.com>
> > ---
> >  MAINTAINERS | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2a0fde12b650..9ebcb0708d5d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9832,13 +9832,6 @@ S:	Maintained
> >  F:	arch/mips/lantiq
> >  F:	drivers/soc/lantiq
> >=20
> > -LAPB module
> > -L:	linux-x25@vger.kernel.org
> > -S:	Orphan
> > -F:	Documentation/networking/lapb-module.rst
> > -F:	include/*/lapb.h
> > -F:	net/lapb/
> > -
> >  LASI 53c700 driver for PARISC
> >  M:	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> >  L:	linux-scsi@vger.kernel.org
> > @@ -18979,12 +18972,19 @@ L:	linux-kernel@vger.kernel.org
> >  S:	Maintained
> >  N:	axp[128]
> >=20
> > -X.25 NETWORK LAYER
> > -M:	Andrew Hendry <andrew.hendry@gmail.com>
> > +X.25 STACK
> > +M:	Martin Schiller <ms@dev.tdt.de>
> >  L:	linux-x25@vger.kernel.org
> > -S:	Odd Fixes
> > +L:	netdev@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/networking/lapb-module.txt
> >  F:	Documentation/networking/x25*
> > +F:	drivers/net/wan/hdlc_x25.c
> > +F:	drivers/net/wan/lapbether.c
> > +F:	include/*/lapb.h
> >  F:	include/net/x25*
> > +F:	include/uapi/linux/x25.h
> > +F:	net/lapb/
> >  F:	net/x25/
> >=20
> >  X86 ARCHITECTURE (32-BIT AND 64-BIT)

--=20

Joel Granados

--w5od6bkxbptofq3m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTI58wACgkQupfNUreW
QU937Av+OuDJFB5zjnP87Zzw7wi35LuyWZ2ZUG9Fw5aaAAo5Sq6vs7is5916/Ccp
0iu0KsWpHXhQm+QS3QOG6zcLTvDcux7qGo18zqu6XL/bWX8AkY4JZHb5Xh94tuQt
6zHGJOJW0rt10bfV9V2BOB0uEkqwCJeHBvI63Q9tYxXoxY1MKYIeqh0Y6DnLWxLx
g6s6NMIuPGhQR0BNsFjuyp929z5a3WrXoXAwu356vCf1cbUKDd6T0mk3EVxRQVem
07yzHnlNiKZO6cvpV/Lh9TzLIk3HfDlKqT18VkEEtG66n701YFWAEcIwLQ7akryq
1dI02s0PbxLpTlFD3Ji62Ix4lYBfS4nfkYJ/G8G2fBgfsW1WQ+K891BPNLEkSnwd
yz7ZRm1wGzdkOXybyA7KBSTbzlh14MssC18qt9LKcqSmNzxWKirYQLoMPHYDTdC0
ftiUATwtJXO+K22eObS0cKdh7F3j1G+EBWW5h08dZftrsu88Y2rHrm9ZGXYm+rmg
7RZ3r9n9
=fM6w
-----END PGP SIGNATURE-----

--w5od6bkxbptofq3m--

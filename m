Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737A67C4D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345033AbjJKIbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344232AbjJKIbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:31:10 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED259E;
        Wed, 11 Oct 2023 01:31:04 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231011083103euoutp0292639907a430301ee2dbb76d84394fde~NAGPCv5033124531245euoutp02R;
        Wed, 11 Oct 2023 08:31:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231011083103euoutp0292639907a430301ee2dbb76d84394fde~NAGPCv5033124531245euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697013063;
        bh=c23HKEnm07lR0JjSW2N2NuGqLttQ0iruGe5RY3MyjYA=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=bIHFQv4DHDaMLEOTaYS6xqyAflmHaFX1SURfZ5ayiibBPqWEZbdS8B2l1O7+p/MM0
         SE2kzGHxfUY5SQhVp2BCLwe6XPdPy5XKTKSZZpwsmRZULB8rX7mP05f0bED8Yn9sPW
         yXYfetu9SQ3NcqKerr1nHC/MyjZlx4pwBxCS7p0c=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231011083102eucas1p16b45762026096a11812a6211e77905b2~NAGO0iLSX2913829138eucas1p1R;
        Wed, 11 Oct 2023 08:31:02 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 78.1E.37758.64D56256; Wed, 11
        Oct 2023 09:31:02 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231011083102eucas1p23f187c8ac330799038a55b62c0e07686~NAGOYrXya1371313713eucas1p2q;
        Wed, 11 Oct 2023 08:31:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231011083102eusmtrp2229867fd04eddaae5839485b8674a82d~NAGOYAKyz1417414174eusmtrp2l;
        Wed, 11 Oct 2023 08:31:02 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-fc-65265d460b94
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 59.B2.25043.64D56256; Wed, 11
        Oct 2023 09:31:02 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231011083102eusmtip238644f210741fa49f3c4e348aa6c8dfe~NAGOHZK1S0276502765eusmtip2J;
        Wed, 11 Oct 2023 08:31:02 +0000 (GMT)
Received: from localhost (106.210.248.232) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 11 Oct 2023 09:31:01 +0100
Date:   Wed, 11 Oct 2023 10:36:12 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Luis Chamberlain <mcgrof@kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        Phillip Potter <phil@philpotter.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the sysctl tree
Message-ID: <20231011083612.4hymwsvc43hrwm6h@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="stxij4fxwoknaead"
Content-Disposition: inline
In-Reply-To: <20231011162050.773ebb15@canb.auug.org.au>
X-Originating-IP: [106.210.248.232]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsWy7djPc7pusWqpBhc/6FmsvtvPZnF51xw2
        i4ML2xgtbkx4ymgxdZmexda9V9kd2Dwab9xg87h8ttRj06pONo8HuzeweHzeJBfAGsVlk5Ka
        k1mWWqRvl8CVcePnDqaCLzwVC//mNTDO5O5i5OSQEDCRmL+im72LkYtDSGAFo8TmCx+gnC+M
        Ems6P7BCOJ8ZJQ7NXs4M03Lwyk4miMRyRoneZ9PZQBJgVbe7VSESWxklji47xgiSYBFQlbiw
        +DITiM0moCNx/s0dsEkiAsESJxZeBdvHLLCPUWLqzblgk4QFrCWWX+hjAbF5BcwlNs1+zAxh
        C0qcnPkEKM4B1FAh0fXRCMKUllj+jwOkghOouv/hbRaIQ5Ulrs98wQRh10qsPXYGbJWEQD+n
        xIedn8HGSAi4SGx8DlUvLPHq+BZ2CFtG4v/O+UwQ9ZMZJfb/+wDVvJpRYlnjV6ip1hItV55A
        dThKbF4OYoMM5ZO48VYQJMwMZE7aNp0ZIswr0dEmBFGtJrH63huWCYzKs5A8NgvhsVkIj80C
        m6MjsWD3JzYMYW2JZQtfM0PYthLr1r1nWcDIvopRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93
        EyMwcZ3+d/zrDsYVrz7qHWJk4mA8xKgC1Pxow+oLjFIsefl5qUoivI8yVVKFeFMSK6tSi/Lj
        i0pzUosPMUpzsCiJ86qmyKcKCaQnlqRmp6YWpBbBZJk4OKUamLwrwx9tsPRaP9HUY87B95v+
        9L/fveWeifS7hD960q/rrbIU67Z5yzxpXcVSX2G0I+jjzaK1S2fP9455v0dRY+lcr635fB7F
        v4vWf+2e+XQu41HxH1Gz7FYIiCpH2CmV8l8MWPj6FVsM29aW564lBg7z5Fjv3DuQMEFOhG9d
        ScXHf7G9Ox6bqNw/unCb1Bnev880846cavT+ou77eZ9/o8FccweuJlGp836NB8rqNTPFelte
        zA3kUeJSEv3hNPHpiURvBf+Us8xrSp9dZbwxT/Tb8e/CXx9/Z7oglvBryhpfhuy8oLjH8338
        nXL0G7wnX5weuDggz0/a7/XLiAcczp8Vlxz7f/G62i+Tf0KyKUosxRmJhlrMRcWJAB/wPGfX
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xe7pusWqpBis381usvtvPZnF51xw2
        i4ML2xgtbkx4ymgxdZmexda9V9kd2Dwab9xg87h8ttRj06pONo8HuzeweHzeJBfAGqVnU5Rf
        WpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8XLVP+aCTzwV
        u679ZGxgnM7dxcjJISFgInHwyk6mLkYuDiGBpYwSfzcdYYNIyEhs/HKVFcIWlvhzrYsNougj
        o8SzS8/YIZytjBKvb88Aq2IRUJW4sPgyE4jNJqAjcf7NHWYQW0QgWOLEwqtgDcwC+xglzszf
        C9YgLGAtsfxCHwuIzStgLrFp9mNmiKldjBI3nj1ghkgISpyc+QSsiFmgTGL96m1AkziAbGmJ
        5f84QMKcQL39D2+zQJyqLHF95gsmCLtW4tX93YwTGIVnIZk0C8mkWQiTIMJaEjf+vWTCENaW
        WLbwNTOEbSuxbt17lgWM7KsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzEC43jbsZ9bdjCufPVR
        7xAjEwfjIUYVoM5HG1ZfYJRiycvPS1US4X2UqZIqxJuSWFmVWpQfX1Sak1p8iNEUGIwTmaVE
        k/OBCSavJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNTqoFpQ2SQtsK1
        XekbNy/oOTht8QdhS03riKVP1U+8l/9tuGVd/sy0rLj3b3cmsnlvMZ4aFvKX78hF6wVXX01Z
        tDNtvY2f/+Llp9NYPjha83Ye4r27IERAc91qL72EeamfdHSF2c+o8+bJdzCv+bf3hfpzdqWl
        djJ5ccY7+gvnzf3QnaHy8nZwm09umPWUvJOn9dn3zf2jU7Mm5YKblOnN3AtbP/jGudxwrlD7
        VlPL9cRkJYPdjv3SC3b1dV9c/4Jp+S0zi71T9W5GrkuauuuSyZ5ToY+d/s72vZhkVDo3yrux
        e+fCIy+z7VvTTaWqZH0XtHN12B0pYUq+4b5LsejK7UuNsQwOfkcOmXyrCNvlqcSoxFKckWio
        xVxUnAgAw6H6P3gDAAA=
X-CMS-MailID: 20231011083102eucas1p23f187c8ac330799038a55b62c0e07686
X-Msg-Generator: CA
X-RootMTR: 20231011052057eucas1p2876288636c2eaaf61a36985cffb29f8e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231011052057eucas1p2876288636c2eaaf61a36985cffb29f8e
References: <CGME20231011052057eucas1p2876288636c2eaaf61a36985cffb29f8e@eucas1p2.samsung.com>
        <20231011162050.773ebb15@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--stxij4fxwoknaead
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 04:20:50PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> The following commit is also in the block tree as a different commit
> (but the same patch):
>=20
>   80f3c6cfab37 ("cdrom: Remove now superfluous sentinel element from ctl_=
table array")
>=20
> This is commit
>=20
>   114b0ff62a65 ("cdrom: Remove now superfluous sentinel element from ctl_=
table array")
>=20
> in the block tree.
Is this a warning on the merge? or did it actually error out? if it is a
wraning and one of the two was skipped, it can be safely ignored as they
are the same. I can also remove that commit from my set and send another
version. @luis: How do you want to handle it?

--=20

Joel Granados

--stxij4fxwoknaead
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmUmXnoACgkQupfNUreW
QU/i5Qv+NCv8awTRSurob6g5QJqggAPPU2CdAbRRUaJ4/LyN7MsgwhJGQC+ro7UV
Fyit7H+QWrUyjKpFORjQVn3DzXfImnLUd0DtALJRRJsDgddWJ86dfW16gQMw+BG1
CqD+R5fkruEe+fl6AwQe8JDKSb3tV8AMm7RcpY3z5L5Cbogd38yX1CkUqUCze7fM
l416yH1h3Wqd7KYpKWJ/Wn59jdzIiPgQvy461Z9sfbmq5cTAM7sxdK5hK19+ZDz+
Ya0tDRDADPVevKOKdpu+l1kUQ6eGgTUnGLDWLefuLuPLr1L2+hT9clLCALqtp8CO
4jgHhgevrA0npvn1VcEiJCEZcrDUgZsMgdRUE5cr8bYjNP1h7iT/MRawKtlHd0WC
xfhpz5EPtnDqhsUWRIfUt17BlxIgbZE4bZBxxtU+l8qfa83I0X3SeZDlDLBK8LX3
Gkk4zQ7YSpc8JdOgnEMhKIVLo8zffHX3RGkPkrhpI87HW0D1J7les7VjNgYQN/ed
fuwjxIoa
=B94G
-----END PGP SIGNATURE-----

--stxij4fxwoknaead--

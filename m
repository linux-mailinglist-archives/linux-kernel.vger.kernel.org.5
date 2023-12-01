Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078D5800BB8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378978AbjLANWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378950AbjLANWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:22:18 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BD813E;
        Fri,  1 Dec 2023 05:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701436943; x=1732972943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SFiMiObX9ZGFEyE4h8oReM51+m2Od7/qLb1KYhjjjLg=;
  b=c7IR14nm6CKShldHQDU/xM2tM+cDw5OP2LZN+pd7f+wgu5hpNfoMKFto
   HZBVFXN7kbIuiTbLkpSJHhHNmhz40iUN4bbP3jQ5p87N1mhsqE7NBRu/R
   l5bkj0ng9ho8e2CgLJ6tj713nNIO4Lq2VYKacvqT6Xqg8A6ef0Mrj8gmr
   J5Aj/UxYA+/hyrW/sxXLgg98PWi05pFr7DDnMnfsXIHem8kJsDLya3B96
   dQn3h3BweFhsCagKv9BOODV+zbQrvhcZncNIs62TufYzzjeBCFwpz+/i4
   jUsd57R164hx9SkcOFCh6AlF6Z4DBl1S6uUB8Fa01DyBGkk9ZytlcCJDa
   Q==;
X-CSE-ConnectionGUID: h4Jrgyr3T9i1kHEvfFr0NQ==
X-CSE-MsgGUID: QYF4eAE9TJCZvZov9yd8ew==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="asc'?scan'208";a="179742437"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Dec 2023 06:22:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Dec 2023 06:22:00 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 1 Dec 2023 06:21:57 -0700
Date:   Fri, 1 Dec 2023 13:21:28 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <stable@vger.kernel.org>, <patches@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <akpm@linux-foundation.org>, <linux@roeck-us.net>,
        <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>, <allen.lkml@gmail.com>
Subject: Re: [PATCH 6.6 000/112] 6.6.4-rc1 review
Message-ID: <20231201-prize-deck-be172f77a4bb@wendy>
References: <20231130162140.298098091@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CGVL03bvG34QNHYM"
Content-Disposition: inline
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--CGVL03bvG34QNHYM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 04:20:47PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.4 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--CGVL03bvG34QNHYM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWnd2AAKCRB4tDGHoIJi
0uO2AQDgaoRRvbNVU+L0vVmYKaIMArJIz6JH3K0QDUdd7M77KwD+O2iYvcBIwEeb
zZl1lG7BTtD04V/w8ec46x9ppu093wc=
=vWEC
-----END PGP SIGNATURE-----

--CGVL03bvG34QNHYM--

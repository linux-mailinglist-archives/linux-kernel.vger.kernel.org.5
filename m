Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2144E800942
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378449AbjLALCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378463AbjLALC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:02:28 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B443193;
        Fri,  1 Dec 2023 03:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701428554; x=1732964554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uYe92/+q2AsWj/XJIkpJZ54l5IPYR4MCNkD/UZeYmWw=;
  b=oqFzbjX6ULFXxdtehK7LoplXP+ipsXImo9MXSZtPAqUDcHmFmSeWzcMZ
   tIzNaR2CZ/tl/SABnEB0FMVLvy7co8kK0jtm2ufkUYB+d+djoTyRBl0RZ
   HQmTIaq90SdPl4Aa+4rmwPPFqskcc2q6fztpbUosjY6EQep+2/D60Bpc4
   d3019WgKpJ+i4JNk+QR1HN7FwoisPHg9xWZaz8GvS2yu48f8rbwL/Nv3s
   AY5v3gYM6JKyOJLrFbj4nweumcQCmJ6V4bUYfDKmkrXOlhgAoUxpo1SL1
   J6/mGHfIpsDKyimfsoSMzXWsYOcA0akOzTUJhkEoxHwQK9qrVHcSK7Hn0
   Q==;
X-CSE-ConnectionGUID: 1g/+sIhlTqCL1F9uWMaPeg==
X-CSE-MsgGUID: 1gQ5qdcPRny2WPun9EQ0Lw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="asc'?scan'208";a="12533231"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Dec 2023 04:02:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Dec 2023 04:02:03 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 1 Dec 2023 04:02:00 -0700
Date:   Fri, 1 Dec 2023 11:01:31 +0000
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
Subject: Re: [PATCH 6.1 00/82] 6.1.65-rc1 review
Message-ID: <20231201-manicure-annuity-c6f29c460878@wendy>
References: <20231130162135.977485944@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y1RXsZqWw4Nlr+rB"
Content-Disposition: inline
In-Reply-To: <20231130162135.977485944@linuxfoundation.org>
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

--Y1RXsZqWw4Nlr+rB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 04:21:31PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.65 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--Y1RXsZqWw4Nlr+rB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWm9CwAKCRB4tDGHoIJi
0ucOAQCTmquaS9c+i69BPOHYxNf+7mGEk40LGA2D6UAabLaK9wD8D8D6SRHMaJZD
79QUsKox/3k+n55zZc7BJV15C4Ielg0=
=Srho
-----END PGP SIGNATURE-----

--Y1RXsZqWw4Nlr+rB--

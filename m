Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E0E79E033
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238450AbjIMGpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjIMGpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:45:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831FC173E;
        Tue, 12 Sep 2023 23:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694587514; x=1726123514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y8cbm2xRT+3Q5jY61mAtQawuW7IB4753dPX/HheSAG4=;
  b=b5lfadJXAycNX1uN+KsZhwCKh0zy/pMABu1nGdbTLxriVRmSes+VHZad
   ffZa8qUvdq3Dx7/TEyFCLz37hIPwM1idf6ybOdgPt6ve3jenlICHAUm/2
   cLmikfu4f/l+oMhiIWxMqxoouDfE1OJ5+Vtnt73byjI2HY9ND6IrZPg3k
   GD2ENQ8HRs3ZAKpa+4YrnlWFmemwEGV/Z0rkmTD3xrEaS+1vBeqrSxg1c
   UhBggpEbElkK/KiCYkwZaVLUHanhcDJ8kcd9Xf1senJ+N6qrUAndRC+7H
   S+E/7fXoAFWl63Q3J3unCo6RKqi5aEUJVaAC61GUXHulwkJZeJR2PpmYj
   A==;
X-CSE-ConnectionGUID: VJleJK+XR/2wSg6R38LvfQ==
X-CSE-MsgGUID: /BsJvPWXRHuu9s0R0d6YVw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="asc'?scan'208";a="4256110"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Sep 2023 23:45:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 12 Sep 2023 23:45:13 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 12 Sep 2023 23:45:10 -0700
Date:   Wed, 13 Sep 2023 07:44:54 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <stable@vger.kernel.org>, <patches@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <akpm@linux-foundation.org>, <linux@roeck-us.net>,
        <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>
Subject: Re: [PATCH 6.5 000/739] 6.5.3-rc1 review
Message-ID: <20230913-scared-ahoy-f19b8358416e@wendy>
References: <20230911134650.921299741@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fH+1Q+LkcwDFv20g"
Content-Disposition: inline
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--fH+1Q+LkcwDFv20g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 11, 2023 at 03:36:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.3 release.
> There are 739 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--fH+1Q+LkcwDFv20g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQFaZgAKCRB4tDGHoIJi
0i6eAP9Uh+H+JFMbhk75ndW4Osn9yehDBXy0gZrxMuE4/VjMDAD/TOItRJvEyIMp
P0+EX2J1BWeg4l/xd7eS8Jmmu3AAYwc=
=NN7b
-----END PGP SIGNATURE-----

--fH+1Q+LkcwDFv20g--

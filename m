Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18467A486A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241354AbjIRL3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241665AbjIRL3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:29:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59C9170E;
        Mon, 18 Sep 2023 04:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695036364; x=1726572364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AWntqZbkSbmn/MP084Ke+21jIISRxqv10eVOLcv87Cg=;
  b=Qj+5+KAx12ZCiTlyjbahquryCZLowDVu7pXazF7ojV41uBpaFFPBiN6S
   +xfqb/Ushei6391FOHvkgsiHE4Twpls+tOuh8Pyy9EGrsTuTmqadwpUEX
   nWo7ZQlFhJJZ8AXcCZdwqk483s8fhR4Y18/Tuj639nKEjkktMJEUT6zL5
   QT7pNmsF0wNeeiK6O2c85alSRTN+Vs9B8fSL3F5/nym7IWWJajlNrXFx8
   psfrcd70r5pXglB/l99ZtP6ThlQ2jYBRMlMMRjpQNCHrrpPNIGfRNZV3b
   aaqwAuRVuusSL/4kvAuKiXwECtJec7OuZQaCeHCBvicqn6fjm7XZIQKKK
   g==;
X-CSE-ConnectionGUID: pIJvHuS8Qpmn2ZqRa9Ey8Q==
X-CSE-MsgGUID: czKlEAplTfmnmjX5f1zEGw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="asc'?scan'208";a="235738003"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2023 04:25:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 18 Sep 2023 04:24:45 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 18 Sep 2023 04:24:40 -0700
Date:   Mon, 18 Sep 2023 12:24:23 +0100
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
Subject: Re: [PATCH 6.1 000/219] 6.1.54-rc1 review
Message-ID: <20230918-animal-reword-a5ec304ea2fa@wendy>
References: <20230917191040.964416434@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L1qguHOKtswDYfDE"
Content-Disposition: inline
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--L1qguHOKtswDYfDE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 17, 2023 at 09:12:07PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.54 release.
> There are 219 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--L1qguHOKtswDYfDE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQgzZwAKCRB4tDGHoIJi
0n9rAQDyO31hBrEBGohyj30+1d1XuQqiDNG/YXHlnmVow396PAEA+fI0RYn3NHCA
oPrx6vr3yfObwpH43oN6c5ToK2iUtAI=
=42Pv
-----END PGP SIGNATURE-----

--L1qguHOKtswDYfDE--

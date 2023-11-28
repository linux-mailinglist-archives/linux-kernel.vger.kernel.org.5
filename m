Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EBE7FB986
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344547AbjK1LjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbjK1LjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:39:05 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C42D4C;
        Tue, 28 Nov 2023 03:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701171551; x=1732707551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W6jdQif78H8ac9hdDjtpyYbJHi2T8WFgTDSWP9xkfGE=;
  b=N0FEG/6QVVCLUY/0E7jWl8Mmsy5Zq3+hdlTfYrMGq7bjs9SlPWZpfpIo
   ob0VwKeyVLOHUQT2D3Aas1hsi+ubcjvf3TqWa1jaJ3Xm21rnErjMPCF5/
   Nj7bwmxnqoQ9Qm0YEclvnaMJahkI5GkNVHLe91JioJ8eUOyOaTaMwUxTM
   c6ArnTUHX4aaGDbyD93D/IeTKnFcHeXWT+arwAZiP6lQSBrjGdhFbYN5l
   qHjOczhCsoo4xC5FdRcEgUYF17/v3aqeWvYyBTuljPU9GuflO9AP9kPdy
   a9vKltCL5/VmNIgVMYJwNcxY1w5l3DBeiYlVDMhKGnFlJDGo5aBlYb9SK
   Q==;
X-CSE-ConnectionGUID: 6xCExiqRTp2H5+4mrlHd+g==
X-CSE-MsgGUID: bTq6O5gwQIStnsUQ1jKqPQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="asc'?scan'208";a="13173510"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Nov 2023 04:39:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Nov 2023 04:39:02 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 28 Nov 2023 04:38:59 -0700
Date:   Tue, 28 Nov 2023 11:38:30 +0000
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
Subject: Re: [PATCH 6.1 000/366] 6.1.64-rc4 review
Message-ID: <20231128-perceive-impulsive-754e8e2e2bbf@wendy>
References: <20231126154359.953633996@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dp00RXnGoC29AqO0"
Content-Disposition: inline
In-Reply-To: <20231126154359.953633996@linuxfoundation.org>
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

--dp00RXnGoC29AqO0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2023 at 03:46:28PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.64 release.
> There are 366 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

I missed testing 6.1.63 so I noticed this only here, but my CI is
complaining about seeing some
[    0.000000] Couldn't find cpu id for hartid [0]
during boot.

It was caused by

commit 3df98bd3196665f2fd37fcc5b2d483a24a314095
Author: Anup Patel <apatel@ventanamicro.com>
Date:   Fri Oct 27 21:12:53 2023 +0530

    RISC-V: Don't fail in riscv_of_parent_hartid() for disabled HARTs
   =20
    [ Upstream commit c4676f8dc1e12e68d6511f9ed89707fdad4c962c ]
   =20
    The riscv_of_processor_hartid() used by riscv_of_parent_hartid() fails
    for HARTs disabled in the DT. This results in the following warning
    thrown by the RISC-V INTC driver for the E-core on SiFive boards:
   =20
    [    0.000000] riscv-intc: unable to find hart id for /cpus/cpu@0/inter=
rupt-controller
   =20
    The riscv_of_parent_hartid() is only expected to read the hartid
    from the DT so we directly call of_get_cpu_hwid() instead of calling
    riscv_of_processor_hartid().
   =20
    Fixes: ad635e723e17 ("riscv: cpu: Add 64bit hartid support on RV64")
    Signed-off-by: Anup Patel <apatel@ventanamicro.com>
    Reviewed-by: Atish Patra <atishp@rivosinc.com>
    Link: https://lore.kernel.org/r/20231027154254.355853-2-apatel@ventanam=
icro.com
    Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
    Signed-off-by: Sasha Levin <sashal@kernel.org>

and there is already a fix for this in Linus' tree though that you can
pick:
52909f176802 ("RISC-V: drop error print from riscv_hartid_to_cpuid()")

That's just one error print that realistically has no impact on the
operation of the system, and is not introduced by this particular
version, so

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--dp00RXnGoC29AqO0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWXRNgAKCRB4tDGHoIJi
0nPGAPwIDqickTmSq2C7/20IyCkzCK1340MjkfKXlO4UZ2J5AQEApcVkMBNRRwpW
8ogGeZp6DkOY9YpSALMCH/lk89scZw4=
=rG0R
-----END PGP SIGNATURE-----

--dp00RXnGoC29AqO0--

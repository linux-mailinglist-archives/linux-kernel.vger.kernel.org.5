Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2D87886FC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244839AbjHYMSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244900AbjHYMSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:18:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0CA2708;
        Fri, 25 Aug 2023 05:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692965875; x=1724501875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pKrWa/+guseK12hSWiHg8JwVCS7BT39n7+hjvajt3Hs=;
  b=oKb7JzwNrqh33psoZZjCJ5WdRfcfljGtHAfI+CYiR91/RcqBge19wh1U
   1/H+GluOqyHM81FWH9GDAIotrOipMvG3ZqUerSoucobWdUNPL92bYokJ7
   LK/3Q39RX1bczzkg+1aXNjJyta0r0jtZMT3F1QZOeD4rJQdYKnIRetKhs
   18xz5aOW5c5jnrkpgXZNpyyYQZbQ7acQhflwHs4YCQf8F6O+X85WV9/+u
   2wcJmsRLmfizOUD9wco6x0j20bxRP7eaNMQMmB/s2yrWrMkl1BxYDPgd1
   O/hXZM2Pl1Nxo/xbHd291lFm6LcOu8C+Q0upoE/JqKHTSjzFuDRRXpSbk
   w==;
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="asc'?scan'208";a="168288541"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2023 05:16:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 25 Aug 2023 05:16:51 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 25 Aug 2023 05:16:48 -0700
Date:   Fri, 25 Aug 2023 13:16:07 +0100
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
Subject: Re: [PATCH 6.1 00/15] 6.1.48-rc1 review
Message-ID: <20230825-radish-gong-b42f53b3e6ad@wendy>
References: <20230824141447.155846739@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nkFZEeQSBoq7Dahz"
Content-Disposition: inline
In-Reply-To: <20230824141447.155846739@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nkFZEeQSBoq7Dahz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 04:14:56PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.48 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

SRSO mitigations are probably not in the slightest bit relevant for me,
but I didn't get a chance to retest the previous stable release after
the build got unbricked for RISC-V, so:
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Fix for the build issue I saw should be on it's way to Linus today, so
I guess the original fix you were backporting & its fix should end up
back in your queue soonTM.

Thanks,
Conor.

>=20
> Responses should be made by Sat, 26 Aug 2023 14:14:28 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.48-=
rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git=
 linux-6.1.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h
>=20
> -------------
> Pseudo-Shortlog of commits:
>=20
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 6.1.48-rc1
>=20
> Borislav Petkov (AMD) <bp@alien8.de>
>     x86/srso: Correct the mitigation status when SMT is disabled
>=20
> Peter Zijlstra <peterz@infradead.org>
>     objtool/x86: Fixup frame-pointer vs rethunk
>=20
> Petr Pavlu <petr.pavlu@suse.com>
>     x86/retpoline,kprobes: Fix position of thunk sections with CONFIG_LTO=
_CLANG
>=20
> Borislav Petkov (AMD) <bp@alien8.de>
>     x86/srso: Disable the mitigation on unaffected configurations
>=20
> Borislav Petkov (AMD) <bp@alien8.de>
>     x86/CPU/AMD: Fix the DIV(0) initial fix attempt
>=20
> Sean Christopherson <seanjc@google.com>
>     x86/retpoline: Don't clobber RFLAGS during srso_safe_ret()
>=20
> Peter Zijlstra <peterz@infradead.org>
>     x86/static_call: Fix __static_call_fixup()
>=20
> Borislav Petkov (AMD) <bp@alien8.de>
>     x86/srso: Explain the untraining sequences a bit more
>=20
> Peter Zijlstra <peterz@infradead.org>
>     x86/cpu: Cleanup the untrain mess
>=20
> Peter Zijlstra <peterz@infradead.org>
>     x86/cpu: Rename srso_(.*)_alias to srso_alias_\1
>=20
> Peter Zijlstra <peterz@infradead.org>
>     x86/cpu: Rename original retbleed methods
>=20
> Peter Zijlstra <peterz@infradead.org>
>     x86/cpu: Clean up SRSO return thunk mess
>=20
> Peter Zijlstra <peterz@infradead.org>
>     x86/alternative: Make custom return thunk unconditional
>=20
> Peter Zijlstra <peterz@infradead.org>
>     x86/cpu: Fix up srso_safe_ret() and __x86_return_thunk()
>=20
> Peter Zijlstra <peterz@infradead.org>
>     x86/cpu: Fix __x86_return_thunk symbol type
>=20
>=20
> -------------
>=20
> Diffstat:
>=20
>  Documentation/admin-guide/hw-vuln/srso.rst |   4 +-
>  Makefile                                   |   4 +-
>  arch/x86/include/asm/entry-common.h        |   1 +
>  arch/x86/include/asm/nospec-branch.h       |  28 +++---
>  arch/x86/kernel/cpu/amd.c                  |   1 +
>  arch/x86/kernel/cpu/bugs.c                 |  28 +++++-
>  arch/x86/kernel/static_call.c              |  13 +++
>  arch/x86/kernel/traps.c                    |   2 -
>  arch/x86/kernel/vmlinux.lds.S              |  20 ++--
>  arch/x86/kvm/svm/svm.c                     |   2 +
>  arch/x86/lib/retpoline.S                   | 141 ++++++++++++++++++++---=
------
>  tools/objtool/arch/x86/decode.c            |   2 +-
>  tools/objtool/check.c                      |  21 +++--
>  13 files changed, 182 insertions(+), 85 deletions(-)
>=20
>=20

--nkFZEeQSBoq7Dahz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOibhwAKCRB4tDGHoIJi
0ir9APwJNOqXyqbbaUtHMlbqI/DUrcQjWxsS98/PmHK//Tp7JgEAyhMga4q+QApr
kaPHLpoRzYPdyy8r/pOeGIvbCdPg3A4=
=tUo8
-----END PGP SIGNATURE-----

--nkFZEeQSBoq7Dahz--

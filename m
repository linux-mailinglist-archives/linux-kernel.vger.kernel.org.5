Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152B77A1750
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjIOH0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjIOH0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:26:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC41A1BCC;
        Fri, 15 Sep 2023 00:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694762776; x=1726298776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EyH0sB0gCaPFZjPgUffhDBAyq6GhY0/i50f+uPV8t/o=;
  b=JhhE5lGA6V5KJi7ANF+Of93uWCgoHx+lcPZK29C9hKUDxS8F0z1pj4IV
   O31P57jclKuUe5mJnnt1ukafHwCXTgDQVGiTL0QByvvdir97xrRGyO3T+
   D2YHHaAxPuez/OHIZuqYhZygJE/WC2/M/qrKyZlZfo7fJ6Xjc8DPRaYK9
   +/Ltcj61RicGzh/uG4IAt/DpM5YfC5kgUFiqkj7mgoi1Cb0E3QQA5c0ez
   PsDu7voIOKI3sPp/OaLyEw+2nsmBbeMnENBOvXQJ88WblCn6zUfQMlUrE
   nTtHLE/dpY5QRsHBzwENAWvODuWvGLD8VsEhhrTFb6V0ro9pv2+tS0JqF
   A==;
X-CSE-ConnectionGUID: V6gNLPcxR0GFNINxl3o+CQ==
X-CSE-MsgGUID: oMXifhVTQ7CSEyR0Xd1ocQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="asc'?scan'208";a="4993552"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2023 00:26:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 15 Sep 2023 00:25:40 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 15 Sep 2023 00:25:37 -0700
Date:   Fri, 15 Sep 2023 08:25:21 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Wang Chen <unicornxw@gmail.com>
CC:     <linux-riscv@lists.infradead.org>, <conor@kernel.org>,
        <aou@eecs.berkeley.edu>, <krzysztof.kozlowski+dt@linaro.org>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jszhang@kernel.org>,
        <guoren@kernel.org>, <chao.wei@sophgo.com>,
        <xiaoguang.xing@sophgo.com>, Wang Chen <wangchen20@iscas.ac.cn>
Subject: Re: [PATCH 00/12] Add Milk-V Pioneer RISC-V board support
Message-ID: <20230915-dill-gauze-922068730d7b@wendy>
References: <20230915070856.117514-1-wangchen20@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IJenxqMWDwNwrYt0"
Content-Disposition: inline
In-Reply-To: <20230915070856.117514-1-wangchen20@iscas.ac.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--IJenxqMWDwNwrYt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Fri, Sep 15, 2023 at 03:08:56PM +0800, Wang Chen wrote:
> Milk-V Pioneer [1] is a developer motherboard based on SOPHON SG2042 [2]
> in a standard mATX form factor. Add minimal device
> tree files for the SG2042 SOC and the Milk-V Pioneer board.

Cool, thanks for working on this.

>=20
> Now only support basic uart drivers to boot up into a basic console.
>=20
> The patch series is based on v6.6-rc1. You can simply review or test=20
> the patches at the link [3]. Hope this series will be merged soon.
>=20
> Thanks
>=20
> [1]: https://milkv.io/pioneer
> [2]: https://en.sophgo.com/product/introduce/sg2042.html
> [3]: https://github.com/unicornx/linux-riscv/commits/milkv-pioneer-minimal
>=20
> Emil Renner Berthing (2):
>   dt-bindings: serial: snps-dw-apb-uart: Add Sophgo SG2042 uarts
>   serial: 8250_dw: Add Sophgo SG2042 support
>=20
> Inochi Amaoto (1):
>   dt-bindings: timer: Add Sophgo sg2042 clint
>=20
> Wang Chen (8):
>   dt-bindings: vendor-prefixes: add milkv/sophgo
>   dt-bindings: riscv: add sophgo sg2042 bindings
>   dt-bindings: riscv: Add T-HEAD C920 compatibles
>   dt-bindings: interrupt-controller: Add SOPHGO's SG2042 PLIC
>   riscv: dts: add initial SOPHGO SG2042 SoC device tree
>   riscv: dts: sophgo: add Milk-V Pioneer board device tree
>   riscv: dts: sophgo: Add sophgo,sg2024-uart compatibles
>   riscv: defconfig: enable SOPHGO SoC
>=20
> xiaoguang.xing (1):
>   riscv: Add SOPHGO SOC family Kconfig support

One thing on sending patchsets - you've not threaded this patchset,
where each patch is a reply to the cover letter. This makes it more
difficult to apply the series as a human & ~impossible for the
automation to test correctly.
Git should do this for you if run send-email on an entire directory,
or you can pass the message-id of the cover letter with an argument.
The first option is likely a lot easier for you...

Thanks,
Conor.

--IJenxqMWDwNwrYt0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQQG4QAKCRB4tDGHoIJi
0mQUAP9WOBdSKZXk8ACK1UVixPMHRsarDWFDmAAa/uPxxRVXFgEA+jBK+Bq2J/xE
MtSEfbB0WAs8zdV+l3VW3oVLXhciAw0=
=lNkY
-----END PGP SIGNATURE-----

--IJenxqMWDwNwrYt0--

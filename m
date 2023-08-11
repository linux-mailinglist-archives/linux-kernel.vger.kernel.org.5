Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6B8779297
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbjHKPOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHKPOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:14:34 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3107230C1;
        Fri, 11 Aug 2023 08:14:22 -0700 (PDT)
Received: from fabians-envy.localnet ([185.104.138.32]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mq2Wi-1pzI0N2Vog-00nCYG; Fri, 11 Aug 2023 17:14:00 +0200
From:   Fabian Vogt <fabian@ritter-vogt.de>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>, Andrew Davis <afd@ti.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v8 0/9] TI-Nspire cleanups
Date:   Fri, 11 Aug 2023 17:13:48 +0200
Message-ID: <4849173.31r3eYUQgx@fabians-envy>
In-Reply-To: <20230802153333.55546-1-afd@ti.com>
References: <20230802153333.55546-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:P2pXAH7kPYmWtTIH2fkzRYX6gsX20W7/i0QIFNuGyf9z1P4Eh0V
 YUFfY++WWNbKSNjJ8m31/C00aUemShz0oq0+xdHd4WbnP0vJ6glzl/TOfbOnCZUgQ0hKJNc
 tH0MlyEuLJS/OVgJqXA8gJSMQTYbVduiJRi8Djza+kiJg2CWGkulmFqDMVBrPhV/fVOnCXu
 LaQJnPB+sz7+67o3H2hGA==
UI-OutboundReport: notjunk:1;M01:P0:p66Z/dOwumo=;FdRa5CmPlIsJU+zOAJdicpUAWR3
 ePJA3HztcY5Bb+m68Kos6w0apZukNhgjqZa2jujmcnKyH/RORj1/aSu8fetZvGs35NW7fOIcd
 Tzhkj7JegMBhyeoo1YKxWL3aj88wAIF2267ndJSjH+dxx/tKBg0P4W1vw55riJJwQ/XI+sVnd
 Q4cQteOW9eA+NiwghvkButrpbNWNjg+7if2Eys1o7zxAluM5svuBjoO7ASDLNasGc58wWDgL6
 W8Rx0aXpxz4g6VYfwV3UBVwDL+ciDQY3bh3yLFWJG09c3sUnV0NmxY5FjajROFo8G6MMnMLdw
 0H2tVo5d+UXzwNPXzlzp2xww2jHi6nGzO1W6Sgeu0O1sI29oTAljA+O4L6apnVygJQRDh9ogN
 CPFJpzm9YIeoDGF20jtlWty70+QGpmbT9iISc2Ab6GvAD7E3ww6Iddzp/P0qoOP4/pSOJNKWr
 1gScMcTZ6vS+io7P2EnW6N/Ig4Y0hdBarHrh2P6goI115/I8IrcNuiOznPGcsBBLy5JHsYE+m
 s8H7aZVwPJZhmdzac3HNPk4bdxGJVrr2Cd1wOpks4HIYohIPjK8uTWOQfCpwVUTq0Ogxpysd6
 gfE8Nah1wA8JrQ9s2lwKxgJLY0rq/DoVmC1eZABO1S4Ex/GHp2gJhcHKK3/ntBB3pObmN0CfN
 xyEdSlDvtjQ1P3bN+LhGZ38WPw6xTaMtUBx85ZoAjVPGRXIchDB7DNLwcue6QQ1Q+5SbV9rna
 t93q6ywqDI2i/60ZcpErYqEOxmlKCdDdjlwG/dozY14DXvwAYwfs+wr5ArSw3AwdahBBKLDuR
 wQKyTapg7MN2HzEH9/GDSY6Kkvnhx2A+pqJyCoPU1oonpciXTgMHqujrXWi8N2K/fjYvMCmbv
 TdkMcDUe4uLd9FQ==
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 2. August 2023, 17:33:24 CEST schrieb Andrew Davis:
> Hello all,
> 
> This series is an extended version of the series started here[0]
> and here[1].
> 
> We break out what was the first patch into one for DTS change and
> one for code changes as suggested by Krzysztof. Those are now patches
> 1 and 8 of this series (I kept the ACKs, hope that is okay).
> 
> While I was adding that, I noticed some other dtbs_check issues,
> so while here fixed some of those up too (patches 2-6).

Whole series applied on top of cacc6e22932f and confirmed to work:

Tested-by: Fabian Vogt <fabian@ritter-vogt.de>

Thanks,
Fabian

> Thanks,
> Andrew
> 
> [0] https://lore.kernel.org/lkml/20221026161302.5319-1-afd@ti.com/
> [1] https://lore.kernel.org/linux-arm-kernel/20221027181337.8651-1-afd@ti.com/
> 
> Changes from v7:
>  - Rebase on latest with new dts dirs
> 
> Changes from v6:
>  - Old first patch was taken, remove from series
>  - Add new patch 7/9, should be trivial enough
> 
> Changes from v5:
>  - Rebase on latest master
>  - Fix DT binding comments from Rob and add ACK
> 
> Changes from v4:
>  - Rebase on latest master
> 
> Changes from v3:
>  - Add Reviewed-by
>  - Make new binding for patch #1
> 
> Changes from v2:
>  - See cover letter message
> 
> Changes from v1:
>  - Add ACKs
>  - Rebase on latest
> 
> Andrew Davis (9):
>   ARM: dts: nspire: Use syscon-reboot to handle restart
>   ARM: dts: nspire: Fix cpu node to conform with DT binding
>   ARM: dts: nspire: Fix sram node to conform with DT binding
>   ARM: dts: nspire: Fix vbus_reg node to conform with DT binding
>   ARM: dts: nspire: Fix uart node to conform with DT binding
>   ARM: dts: nspire: Use MATRIX_KEY macro for linux,keymap
>   ARM: dts: nspire: Remove file name from the files themselves
>   ARM: nspire: Use syscon-reboot to handle restart
>   ARM: nspire: Remove unused header file mmio.h
> 
>  arch/arm/boot/dts/nspire/nspire-classic.dtsi |  2 -
>  arch/arm/boot/dts/nspire/nspire-clp.dts      | 93 ++++++++++++++-----
>  arch/arm/boot/dts/nspire/nspire-cx.dts       | 95 ++++++++++++++------
>  arch/arm/boot/dts/nspire/nspire-tp.dts       | 93 ++++++++++++++-----
>  arch/arm/boot/dts/nspire/nspire.dtsi         | 26 ++++--
>  arch/arm/mach-nspire/Kconfig                 |  2 +
>  arch/arm/mach-nspire/mmio.h                  | 16 ----
>  arch/arm/mach-nspire/nspire.c                | 24 -----
>  8 files changed, 231 insertions(+), 120 deletions(-)
>  delete mode 100644 arch/arm/mach-nspire/mmio.h



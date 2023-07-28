Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE1876767E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbjG1Tm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbjG1TmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:42:21 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1274211
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 12:42:17 -0700 (PDT)
Received: from [185.230.175.137] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qPTLi-0001Fz-G9; Fri, 28 Jul 2023 21:42:06 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>,
        Dan Johansen <strit@manjaro.org>,
        Anand Moon <linux.amoon@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH v3] arm64: defconfig: Enable drivers for the Odroid-M1 board
Date:   Fri, 28 Jul 2023 21:42:04 +0200
Message-Id: <169057331592.3100473.11428860387621722756.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230720080838.933890-1-m.szyprowski@samsung.com>
References: <CGME20230720080848eucas1p2c18ac25b06cb0b89d61db4ab2df1d8dd@eucas1p2.samsung.com> <20230720080838.933890-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 10:08:38 +0200, Marek Szyprowski wrote:
> Hardkernel Odroid-M1 board is supported since commit fd3583267703
> ("arm64: dts: rockchip: Add Hardkernel ODROID-M1 board"). Enable all
> drivers needed by that board in the defconfig to let the automated
> test systems to check them on the real hardware.
> 
> The drivers were configured to be compiled as modules if that was
> supported.
> 
> [...]

Applied, thanks!

[1/1] arm64: defconfig: Enable drivers for the Odroid-M1 board
      commit: 5eaeb85ccae878e5800a207da7baeb5d9d1dd2fd

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

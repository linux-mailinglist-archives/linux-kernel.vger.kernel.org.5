Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF8B7B967D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 23:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244145AbjJDVdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 17:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243954AbjJDVc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 17:32:59 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A23DC6;
        Wed,  4 Oct 2023 14:32:56 -0700 (PDT)
Received: from i53875a3c.versanet.de ([83.135.90.60] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qo9UA-0005RF-Aq; Wed, 04 Oct 2023 23:32:50 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, John Clark <inindev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Thomas McKahan <tmckahan@singleboardsolutions.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Add NanoPC T6 PCIe e-key support
Date:   Wed,  4 Oct 2023 23:32:41 +0200
Message-Id: <169645508392.141514.12518327886843465241.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230906012305.7113-1-inindev@gmail.com>
References: <20230906012305.7113-1-inindev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sep 2023 01:23:05 +0000, John Clark wrote:
> before
> ~~~~
> 0000:00:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3588 (rev 01)
> 0002:20:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3588 (rev 01)
> 0002:21:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)
> 0004:40:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3588 (rev 01)
> 0004:41:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Add NanoPC T6 PCIe e-key support
      commit: ac76b786cc370b000c76f3115a5d2ee76ff05c08

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

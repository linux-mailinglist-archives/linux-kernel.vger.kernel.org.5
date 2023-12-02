Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FCD801DC9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 17:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjLBQge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 11:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjLBQgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 11:36:32 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B68A129;
        Sat,  2 Dec 2023 08:36:36 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r9Syo-0002Wz-9J; Sat, 02 Dec 2023 17:36:34 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alex Bee <knaerzche@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/2] Add GMAC for RK3128
Date:   Sat,  2 Dec 2023 17:36:32 +0100
Message-Id: <170153497985.380580.2053954762522949902.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231202124158.65615-2-knaerzche@gmail.com>
References: <20231202124158.65615-2-knaerzche@gmail.com>
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

On Sat, 2 Dec 2023 13:41:57 +0100, Alex Bee wrote:
> RK3128's GMAC is already supported by the Rockchip's glue for dwmac
> driver, so this series basically adds the respective nodes in the SoC DT
> and the enablements for XPI-3128 board.
> 
> Note: These patches are based on maintainers repo.
> 
> Changes in v2:
>  - use phy reset-timings according to the datasheet
>  - added rx-fifo-depth and rx-fifo-depth for gmac
> 
> [...]

Applied, thanks!

[1/2] ARM: dts: rockchip: Add gmac node for RK3128
      commit: 3d880c31d40d30328cb550523adadf1466e7c686
[2/2] ARM: dts: rockchip: Enable gmac for XPI-3128
      commit: b47c0b9ed3eb31c8efb8f8be3bca32d6ced5fd52

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

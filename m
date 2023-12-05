Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEE8804310
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343569AbjLEAGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjLEAGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:06:05 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5826F0;
        Mon,  4 Dec 2023 16:06:09 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1rAIwt-0001qb-Dh; Tue, 05 Dec 2023 01:06:03 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alex Bee <knaerzche@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add power-controller and gpu for RK3128
Date:   Tue,  5 Dec 2023 01:05:59 +0100
Message-Id: <170173468933.501889.16032345540267173122.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204153547.97877-1-knaerzche@gmail.com>
References: <20231204153547.97877-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 16:35:44 +0100, Alex Bee wrote:
> This series adds the power-controller and the gpu to RK3128's SoC
> devicetree - both are already supported by the respective drivers.
> Patch 3 enables the gpu for XPI-3128 board.
> 
> changes in v3:
>  - dropped patches for not-yet needed power domains
>  - dropped dt-bindings patches which was already merged
> 
> [...]

Applied, thanks!

[1/3] ARM: dts: rockchip: Add power-controller for RK3128
      commit: 5e806176a3a57a530d0220242141b30056a70918
[2/3] ARM: dts: rockchip: Add GPU node for RK3128
      commit: 2cc98b5080f693d718cc17c136180732cc32f73b
[3/3] ARM: dts: rockchip: Enable GPU for XPI-3128
      commit: d892a562110ebe7935c60548a1a3924fb36eca5c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

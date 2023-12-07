Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5E0809250
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjLGUbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjLGUa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:30:59 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56011710;
        Thu,  7 Dec 2023 12:31:03 -0800 (PST)
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1rBL1Q-0005tY-Hw; Thu, 07 Dec 2023 21:31:00 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, daniel.lezcano@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add dynamic-power-coefficient to rk3399 GPU
Date:   Thu,  7 Dec 2023 21:30:59 +0100
Message-Id: <170198105573.18516.6264175947902125145.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127081511.1911706-1-lukasz.luba@arm.com>
References: <20231127081511.1911706-1-lukasz.luba@arm.com>
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

On Mon, 27 Nov 2023 08:15:11 +0000, Lukasz Luba wrote:
> Add dynamic-power-coefficient to the GPU node. That will create Energy
> Model for the GPU based on the coefficient and OPP table information.
> It will enable mechanism such as DTMP or IPA to work with the GPU DVFS.
> In similar way the Energy Model for CPUs in rk3399 is created, so both
> are aligned in power scale. The maximum power used from this coefficient
> is 1.5W at 600MHz.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Add dynamic-power-coefficient to rk3399 GPU
      commit: 381d48fbada9b5b39f5a811bb8fe76365d6bdd5c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

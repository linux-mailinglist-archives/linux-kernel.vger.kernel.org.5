Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06347F165D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjKTOxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjKTOwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:52:07 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA7F199E;
        Mon, 20 Nov 2023 06:51:33 -0800 (PST)
Received: from [194.95.143.137] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r55cZ-0008C4-8l; Mon, 20 Nov 2023 15:51:31 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alex Bee <knaerzche@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, Alex Bee <knaerzche@gmail.com>
Subject: Re: [PATCH v3 2/5] phy: phy-rockchip-inno-usb2: Add RK3128 support
Date:   Mon, 20 Nov 2023 15:51:30 +0100
Message-ID: <1776143.VLH7GnMWUR@phil>
In-Reply-To: <20231119121340.109025-3-knaerzche@gmail.com>
References: <20231119121340.109025-1-knaerzche@gmail.com>
 <20231119121340.109025-3-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 19. November 2023, 13:13:37 CET schrieb Alex Bee:
> Add registers to support the 2-port usb2 phy found in RK312x SoC familiy.
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
> Changes in v3:
>  - added phy_tuning-callback for RK3128
>  
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Vinod, can you pick up patches 1+2 if they seem ok to you?
Patches 3-5 are more or less independent from the phy changes
(the rk3128-usbphy was already documented in the binding,
 so I'll pick 3-5 now)

Thanks
Heiko



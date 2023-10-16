Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBBC7CB441
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjJPUNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbjJPUMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:12:41 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B8BF2;
        Mon, 16 Oct 2023 13:12:33 -0700 (PDT)
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qsTwv-0000QB-2g; Mon, 16 Oct 2023 22:12:25 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v1 1/1] arm64: dts: rockchip: add status LED to rock-5b
Date:   Mon, 16 Oct 2023 22:12:19 +0200
Message-Id: <169748713691.982818.17117317398371965214.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231005134037.33231-1-sebastian.reichel@collabora.com>
References: <20231005134037.33231-1-sebastian.reichel@collabora.com>
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

On Thu, 5 Oct 2023 15:40:37 +0200, Sebastian Reichel wrote:
> Describe the Rock 5B status LED in its device tree.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: add status LED to rock-5b
      commit: 7952cbbda301f7d297c6ac761f9dfafb90205358

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

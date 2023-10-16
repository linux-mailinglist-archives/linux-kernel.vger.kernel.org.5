Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9685E7CB440
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjJPUNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbjJPUMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:12:41 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2710EED;
        Mon, 16 Oct 2023 13:12:33 -0700 (PDT)
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qsTwu-0000QB-9U; Mon, 16 Oct 2023 22:12:24 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     robh+dt@kernel.org,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3] arm64: dts: rockchip: rk3588s: Add AV1 decoder node
Date:   Mon, 16 Oct 2023 22:12:17 +0200
Message-Id: <169748713691.982818.8183459865936380442.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231006065334.8117-1-benjamin.gaignard@collabora.com>
References: <20231006065334.8117-1-benjamin.gaignard@collabora.com>
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

On Fri, 6 Oct 2023 08:53:34 +0200, Benjamin Gaignard wrote:
> Add node for AV1 video decoder.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: rk3588s: Add AV1 decoder node
      commit: dd6dc0c4c1265129c229e26917bf4de1d97ff91f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

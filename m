Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3447BEBB4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377953AbjJIUh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbjJIUhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:37:25 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F1EAC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:37:24 -0700 (PDT)
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qpx08-00058Z-80; Mon, 09 Oct 2023 22:37:16 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     hjc@rock-chips.com, Yang Li <yang.lee@linux.alibaba.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, airlied@gmail.com
Subject: Re: [PATCH -next] drm/rockchip: dsi: Use devm_platform_get_and_ioremap_resource()
Date:   Mon,  9 Oct 2023 22:37:13 +0200
Message-Id: <169688381987.192795.14551398550755679911.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421081303.122452-1-yang.lee@linux.alibaba.com>
References: <20230421081303.122452-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 16:13:03 +0800, Yang Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> 

Applied, thanks!

[1/1] drm/rockchip: dsi: Use devm_platform_get_and_ioremap_resource()
      commit: 253a1d33e5cfdf62525f5d6ed2bf03acbadd1582

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

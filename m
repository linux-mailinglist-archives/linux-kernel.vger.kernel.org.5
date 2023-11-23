Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E1C7F6315
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346101AbjKWPgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346072AbjKWPgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:36:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309E8D41
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:36:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135B6C433C8;
        Thu, 23 Nov 2023 15:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700753785;
        bh=PABX4GUt/DwRCgtKW6APxxB8AClQKd9n4+zsLzawp3s=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sVFefatVkWe2q/glwdnD4HQb5rHCHBGIjb5UxxcYDdRUbDdQTJIbZxx6xsnlmZ+vt
         rCTlaRvc4z2jX4Verg3quYY3yqOo1wSNYgsFDspSRq7QmqLCLzcs4QKLNhAW774CMc
         Damm7lg+0A1M3gJRvDQfktm2d6mLBPqjPipM7DBn67hO09zoO26SPD6wjLtX6H/ZHR
         If4qzr9YsQ/aEnQZPPqqSUlCSfetG+0KIdmNYiklU3/Ue72CCDi0lT4Ab+q26h2Qq9
         yGgfB+xAeacnRzzSKHBKxaFE9YqXGp2FqGMKUBX07Z04yaaxMp2EP5Vp2X8AP1tQ19
         nJFu+Xm1y+55w==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, Andre Werner <andre.werner@systec-electronic.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20231121063259.13991-1-andre.werner@systec-electronic.com>
References: <20231121063259.13991-1-andre.werner@systec-electronic.com>
Subject: Re: (subset) [PATCH] mfd: tps65086: Enable register view in
 debugfs
Message-Id: <170075378480.1387644.17833648454961124975.b4-ty@kernel.org>
Date:   Thu, 23 Nov 2023 15:36:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 07:32:59 +0100, Andre Werner wrote:
> Previously there was no output for the regmap's registers
> in debugfs due to missing "max_register" property in regmap
> configuration.
> 
> 

Applied, thanks!

[1/1] mfd: tps65086: Enable register view in debugfs
      commit: 0f3f51ebc4a8f096c1bd046115458b7499cf535e

--
Lee Jones [李琼斯]


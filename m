Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D3D7D6B31
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbjJYMUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbjJYMUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:20:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4839ECE
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:20:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE82C433C7;
        Wed, 25 Oct 2023 12:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698236407;
        bh=zQrTaEO41znR/LbtDpuLa5tmrMmya+3KE2EbIxv/5AQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Wqd1QD/aD8Cg3lfYqhvFWHK9QItvoZaxuC7l9wO5ubQWkiqsnS+9hy0/Is1qIRZXb
         rEpnxOnJmP2Xlfu1I6Qs0/5QaOYX2VWdio2NUkeVXb58xgIot/W6JPzsORSdf2XJWx
         3WQhaQyCIVOaqCd1vm4X2hlAEgTuNWu5d/MMj9H51m5ny/2uMdWYSij418KFoQTUCY
         FF9Y/2ZGVIg+FjbCX8W+m+C0OlN6ZaHLo1N+V1gJFWV9Vc5DugQImkOJp2uzP6tga4
         W6K5UAcX4aOi9Z0sSSW37Cn0qO3/mlxshQudtFA0zOMJVID69bDX40NKdayLrR2Mvo
         VuDy34iiz7S9A==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Tyser <ptyser@xes-inc.com>
In-Reply-To: <20231024160650.3898959-1-andriy.shevchenko@linux.intel.com>
References: <20231024160650.3898959-1-andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH v1 1/1] mfd: lpc_ich: Mark *_gpio_offsets data
 with const
Message-Id: <169823640666.726355.5485891757785798787.b4-ty@kernel.org>
Date:   Wed, 25 Oct 2023 13:20:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 19:06:50 +0300, Andy Shevchenko wrote:
> There is no reason why the GPIO resource offsets should not be const.
> Mark them accordingly and update a qualifier in struct lpc_ich_gpio_info
> definition.
> 
> 

Applied, thanks!

[1/1] mfd: lpc_ich: Mark *_gpio_offsets data with const
      commit: 41536c17303d087d7b18a5f6ba45b2c1d17f1483

--
Lee Jones [李琼斯]


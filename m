Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14971768C31
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjGaGn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjGaGnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:43:24 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96FF0E43;
        Sun, 30 Jul 2023 23:43:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id AE5DD809E;
        Mon, 31 Jul 2023 06:43:19 +0000 (UTC)
Date:   Mon, 31 Jul 2023 09:43:18 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     xuanzhenggang001@208suo.com
Cc:     linux@armlinux.org.uk, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP2+: prefer 'unsigned int' to bare use of
 'unsigned'
Message-ID: <20230731064318.GJ5194@atomide.com>
References: <20230709135705.59832-1-denghuilong@cdjrlc.com>
 <7efba6a4aae52649aa05756263c0a955@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7efba6a4aae52649aa05756263c0a955@208suo.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* xuanzhenggang001@208suo.com <xuanzhenggang001@208suo.com> [230709 16:59]:
> arch/arm/mach-omap2/display.c:73: WARNING: Prefer 'unsigned int' to bare use
> of 'unsigned'
> arch/arm/mach-omap2/display.c:111: WARNING: Prefer 'unsigned int' to bare
> use of 'unsigned'
> arch/arm/mach-omap2/display.c:119: WARNING: Prefer 'unsigned int' to bare
> use of 'unsigned'

This patch does not apply because the patch has spaces instead of tabs.
Care to check the issue and resend?

Thanks,

Tony

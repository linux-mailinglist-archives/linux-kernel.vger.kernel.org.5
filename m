Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1DD7BC5B3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343722AbjJGHoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343611AbjJGHoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:44:09 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBF92BD;
        Sat,  7 Oct 2023 00:44:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 33BD5809E;
        Sat,  7 Oct 2023 07:44:08 +0000 (UTC)
Date:   Sat, 7 Oct 2023 10:44:06 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vaibhav Hiremath <hvaibhav@ti.com>,
        Felipe Balbi <balbi@ti.com>,
        Xunlei Pang <pang.xunlei@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: OMAP: timer32K: fix all kernel-doc warnings
Message-ID: <20231007074406.GZ34982@atomide.com>
References: <20231007001603.24972-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007001603.24972-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Randy Dunlap <rdunlap@infradead.org> [231007 03:16]:
> Fix kernel-doc warnings reported by the kernel test robot:
> 
> timer32k.c:186: warning: cannot understand function prototype: 'struct timespec64 persistent_ts; '
> timer32k.c:191: warning: Function parameter or member 'ts' not described in 'omap_read_persistent_clock64'
> timer32k.c:216: warning: Function parameter or member 'vbase' not described in 'omap_init_clocksource_32k'
> timer32k.c:216: warning: Excess function parameter 'pbase' description in 'omap_init_clocksource_32k'
> timer32k.c:216: warning: Excess function parameter 'size' description in 'omap_init_clocksource_32k'
> timer32k.c:216: warning: No description found for return value of 'omap_init_clocksource_32k'

Thanks applying into fixes.

Tony

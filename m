Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FDD7B1544
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjI1Hqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjI1Hqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:46:32 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C08A992;
        Thu, 28 Sep 2023 00:46:30 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qlljB-0003Uv-00; Thu, 28 Sep 2023 09:46:29 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id E973AC013D; Thu, 28 Sep 2023 09:29:26 +0200 (CEST)
Date:   Thu, 28 Sep 2023 09:29:26 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] MIPS: AR7: remove platform
Message-ID: <ZRUrVgHyJvvhteGs@alpha.franken.de>
References: <20230922061530.3121-1-wsa+renesas@sang-engineering.com>
 <20230922061530.3121-7-wsa+renesas@sang-engineering.com>
 <ZRUl6+i/o0cqCV+6@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRUl6+i/o0cqCV+6@ninjato>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 09:06:19AM +0200, Wolfram Sang wrote:
> On Fri, Sep 22, 2023 at 08:15:27AM +0200, Wolfram Sang wrote:
> > After a discussion about removing VLYNQ support from the Kernel, it was
> > concluded that its only user, the AR7 platform can go [1]. Even OpenWRT
> > has removed support because these devices are "stuck with 3.18" [2].
> > 
> > [1] https://lore.kernel.org/r/3395161f-2543-46f0-83d9-b918800305e1@gmail.com
> > [2] https://openwrt.org/docs/techref/targets/ar7
> > 
> > Suggested-by: Jonas Gorski <jonas.gorski@gmail.com>
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Hi Thomas,
> 
> most people involved in this series think that it will be best to take
> the whole series via the MIPS tree. Do you agree?

I'm fine taking it.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

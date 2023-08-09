Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A050A7753DF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjHIHOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjHIHOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:14:08 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BE89211E;
        Wed,  9 Aug 2023 00:14:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 534BC8105;
        Wed,  9 Aug 2023 07:14:05 +0000 (UTC)
Date:   Wed, 9 Aug 2023 10:14:04 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Trevor Woerner <twoerner@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] arch/arm/configs/omap2plus_defconfig: drop removed
 options
Message-ID: <20230809071404.GA11676@atomide.com>
References: <20230803191821.36793-1-twoerner@gmail.com>
 <20230803191821.36793-2-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803191821.36793-2-twoerner@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Trevor Woerner <twoerner@gmail.com> [230803 19:18]:
> Drop CONFIG_NF_LOG_NETDEV as it was removed in commit 1510618e45cb
> ("netfilter: nf_log_netdev: merge with nf_log_syslog").
> 
> Drop CONFIG_NFT_COUNTER as it was removed in commit 023223dfbfb3
> ("netfilter: nf_tables: make counter support built-in").
> 
> Drop CONFIG_NF_FLOW_TABLE_IPV6 and CONFIG_NF_FLOW_TABLE_IPV4 as they were
> removed in commit c42ba4290b21 ("netfilter: flowtable: remove ipv4/ipv6
> modules").
> 
> Drop CONFIG_NF_LOG_BRIDGE as it was removed in commit 77ccee96a674
> ("netfilter: nf_log_bridge: merge with nf_log_syslog").

All the changes look good to me in the series, what's the plan
for applying them?

Regards,

Tony

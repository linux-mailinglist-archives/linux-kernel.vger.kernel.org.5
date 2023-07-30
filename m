Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855667686A8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 19:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjG3RXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 13:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjG3RXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 13:23:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74072126;
        Sun, 30 Jul 2023 10:23:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11A7F60C96;
        Sun, 30 Jul 2023 17:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE51C433C7;
        Sun, 30 Jul 2023 17:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690737809;
        bh=Td3SQZbECPhAKn9YumidUWiUzer2inokUiFedh9UIQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a8vqCgbUxJMpRM7WhgzoyORVKYM/QsO+7LLS0A3EbKt+wAHXPx+VxaorGMokaS135
         HzROxvssCuwwnoM2/yg2wpkn6gCgDgSic9nI/yMGiMZ1wD2fb40Jej26TTAZJpU3y3
         BApf50enc6Q6b6gScLxJa3PG7W/0jM/k7ut+oCBJqK8OFuWG5ji72Eh7YB3SNxiyMA
         x25sw1sIj3hfq+4A3OE4aahSVRmLXmd01kFBAzhn2WvoQ5HHVXWRfpPvalcnLHyYV4
         Lxk5bx98lzGmWmmncpNdkvMub+sJvuMCixMgp+4hYFvh9wdNavpBz4Wwo9115gECv6
         nyQulmuLsV7Bw==
Date:   Sun, 30 Jul 2023 19:23:25 +0200
From:   Simon Horman <horms@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: nl80211: Remove unused declaration
 nl80211_pmsr_dump_results()
Message-ID: <ZMacjbACX9SCeIAf@kernel.org>
References: <20230729121651.36836-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729121651.36836-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 08:16:51PM +0800, Yue Haibing wrote:
> nl80211_pmsr_dump_results() is never implemented since introducted in
> commit 9bb7e0f24e7e ("cfg80211: add peer measurement with FTM initiator API")
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD0E7F73A3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345137AbjKXMU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjKXMUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:20:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2BAD46
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 04:20:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DEECC433D9;
        Fri, 24 Nov 2023 12:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700828430;
        bh=OmLVtp+cGn5eWtwGfr7ol+CQUUfqXShKVoDMBch4ZJs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YIaqMbmioTMtdsLuyddfm/8JS3ojJeySLIqw09GDYRL3IXAm0yLs0EEBoaJ/prEAB
         R5sitbmnTTDs0h2CckJXCuuBJLtm73cxHjilswNFjT8Xxf5xyyohVUk4+qo0A2wJim
         ObpmvJ/Gpsy8foFvHD5wk1/TQGGtwwJa1pPXJEHhy0L7cA+fIoWULk4s7JH54tazYa
         OElKwZDFIujt15q8uGpUSBMBvkLI/oRPHi6CWgksPa7PFI/BNPknl4VuHTUa410rc8
         8WmxiDBkaLU/gupbNo/JjHY5zpDyOwPrhTck0jpmktvBf4Et7AJIQOTqBq76hx+Ob4
         MBEoG5GUkpSpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D041E2A029;
        Fri, 24 Nov 2023 12:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] add two sysctl for SMC-R v2.1
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170082843004.28500.18077234087153896761.git-patchwork-notify@kernel.org>
Date:   Fri, 24 Nov 2023 12:20:30 +0000
References: <20231122135258.38746-1-guangguan.wang@linux.alibaba.com>
In-Reply-To: <20231122135258.38746-1-guangguan.wang@linux.alibaba.com>
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc:     wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
        corbet@lwn.net, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, edumazet@google.com, tonylu@linux.alibaba.com,
        alibuda@linux.alibaba.com, guwen@linux.alibaba.com,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 22 Nov 2023 21:52:56 +0800 you wrote:
> This patch set add two sysctl for SMC-R v2.1:
> net.smc.smcr_max_links_per_lgr is used to control the max links
> per lgr.
> net.smc.smcr_max_conns_per_lgr is used to control the max connections
> per lgr.
> 
> Guangguan Wang (2):
>   net/smc: add sysctl for max links per lgr for SMC-R v2.1
>   net/smc: add sysctl for max conns per lgr for SMC-R v2.1
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net/smc: add sysctl for max links per lgr for SMC-R v2.1
    https://git.kernel.org/netdev/net-next/c/f8e80fc4aceb
  - [net-next,2/2] net/smc: add sysctl for max conns per lgr for SMC-R v2.1
    https://git.kernel.org/netdev/net-next/c/1f2c9dd73f0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



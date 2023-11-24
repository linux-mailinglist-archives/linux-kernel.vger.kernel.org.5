Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8867F6A13
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 02:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjKXBUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 20:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKXBUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 20:20:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B6F1B6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:20:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 346CBC433C8;
        Fri, 24 Nov 2023 01:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700788825;
        bh=eLNAnyUduoQQcE8ecVOU/349sikSBU3Okw3Eu+Fv3po=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AsE+sSpX1YgGEgwiGSNjOv38w0cso/T8/MPv2DZxKH8JvSts4fh9ePUgxlm/yoSVy
         p4dLG/c79ffECd2Xho9iQBP6iBu83ozVEgduIhVfutF+VJldRC48NucLuiqS+U7V+T
         6YtD9oNemPFU2Cr7Ljh1lMiZDMuMp6G0YU4QhurKWM/HJaE74PeiXTtZbgGkSq9cz0
         /37jm6tuA772z+ZA7R7aKETPv8WIDLQYKrsvLfV4Ux6erZSWAIBJU/r8aLN2PElDvL
         BmU9egNdpHrZaG6e2DOcPQdH0pQ1QA52UOciORqdrsILmSF8Gz97uXRaf13LUNclk+
         Z0QkE5XHFu1LQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B190C3959E;
        Fri, 24 Nov 2023 01:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Documentation: Document each netlink family
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170078882510.20317.6470955515511938856.git-patchwork-notify@kernel.org>
Date:   Fri, 24 Nov 2023 01:20:25 +0000
References: <20231121114831.3033560-1-leitao@debian.org>
In-Reply-To: <20231121114831.3033560-1-leitao@debian.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     corbet@lwn.net, kuba@kernel.org, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        pabeni@redhat.com, edumazet@google.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 21 Nov 2023 03:48:31 -0800 you wrote:
> This is a simple script that parses the Netlink YAML spec files
> (Documentation/netlink/specs/), and generates RST files to be rendered
> in the Network -> Netlink Specification documentation page.
> 
> Create a python script that is invoked during 'make htmldocs', reads the
> YAML specs input file and generate the correspondent RST file.
> 
> [...]

Here is the summary with links:
  - [v3] Documentation: Document each netlink family
    https://git.kernel.org/netdev/net-next/c/f061c9f7d058

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



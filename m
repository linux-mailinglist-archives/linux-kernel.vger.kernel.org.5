Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F8B7660E8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjG1Au0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjG1AuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF462D5E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16C2761F9C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E2B7C43397;
        Fri, 28 Jul 2023 00:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690505422;
        bh=e9oNV7ZGuvUs9vo/i9F7rmaLnHMQDv2cTspikLSRME4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=r8NcaErtlFsq4U3C93Wih0HdMGkULslwMJmEY1C9u9NE0v5iGK0V/nclJybjom1Y6
         kwNwauu2zaIiohTpXdgsG21r1AGer0fFDOBDWB1iPZ1fDl5gFvMVibYUtHaxPN0WDT
         P7XPe37+yjPpSjsoVvQmavXlkfRSevE0259T3Drgxdl8w9Nfh04OwiXCpSwL3Al45v
         TkPYNPOdR5/R1H37dvdL46bp3LWsrWbcctSXAHCZkp/Ro88TAPX717Bwji7O1EQeqP
         EPuFlFTguXFLxTpgyMK3Y8XRDUnbNmqCOYH7wvZflIiRrf8hnY88CPScTl+qN5DN7C
         W0aEjXv4QJNMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69B2BC64459;
        Fri, 28 Jul 2023 00:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: datalink: Remove unused declarations
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169050542243.6763.7729312365050648608.git-patchwork-notify@kernel.org>
Date:   Fri, 28 Jul 2023 00:50:22 +0000
References: <20230726144054.28780-1-yuehaibing@huawei.com>
In-Reply-To: <20230726144054.28780-1-yuehaibing@huawei.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 22:40:54 +0800 you wrote:
> These declarations is not used after ipx protocol removed.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/net/datalink.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] net: datalink: Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/994650353cae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



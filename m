Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247747EE3EF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345351AbjKPPLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345383AbjKPPLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:11:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1A7AD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:11:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF6ECC433C8;
        Thu, 16 Nov 2023 15:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700147467;
        bh=ffrPBCOuILG3hwhhVFCby0OZzf3IVeLDmbneh6GNuaE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Kth70fqqxyE2tc8z0tIf31YwzG9/PSvlcbxU5+esQyf/AbaH6Htpi7rT9ekshewLE
         85xL+aOs//pKF4PT3laK+HR795irg1Av5VmTJstxHWwHcyVmFQtYlOOetZFBaGDPjU
         9MjJhNLuOTC8US5s6xptAMPNzWSke/jQwukr3dS/Wpn0WG2Xzl6yBnwkcwGJSyAMGG
         e74MdLTIP6XLkwUavBrzs/eI7jWF3CnAIz1nvGGjBjeNJLcfIG0uz61GCnzdRulg/C
         YOAAz0cLP+20sld/uW/CqSQhuZ/PfiD7c9909BrmuPTYtH5R4eTVRtiEoMyHq0fRzm
         /5rlSfXLs30sg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 981A3E00090;
        Thu, 16 Nov 2023 15:11:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for v6.7-rc2
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170014746761.31706.13445108016681047980.git-patchwork-notify@kernel.org>
Date:   Thu, 16 Nov 2023 15:11:07 +0000
References: <20231116122140.28033-1-pabeni@redhat.com>
In-Reply-To: <20231116122140.28033-1-pabeni@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

This pull request was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu, 16 Nov 2023 13:21:40 +0100 you wrote:
> Hi Linus!
> 
> Notably this includes the fix for the eBPF regression you have been
> notified of.
> 
> The following changes since commit 89cdf9d556016a54ff6ddd62324aa5ec790c05cc:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for v6.7-rc2
    https://git.kernel.org/netdev/net/c/7475e51b8796

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



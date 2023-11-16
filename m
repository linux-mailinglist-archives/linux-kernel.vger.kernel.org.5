Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073F37EE06B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345248AbjKPMK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345100AbjKPMK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:10:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDF79C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:10:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B59CC433C9;
        Thu, 16 Nov 2023 12:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700136623;
        bh=CB+Z9KhjNuxIpYBv3s7uWPXwG45KTeyo1+mDiNPYoKk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rzzR9sizziRCyySRurTHP/DzjfttVHGD5LoetKUw3YZe0HGhDKNURQE0r1bMh1HWN
         BbU6Ydsw9rkwpTK6J4xNPV1CJPB/MAYf04Pp2YxiryFOnDq0XkDjZIQPdp46fTYdGm
         LKrJRTzhv1zOvAWr/u/A2hEj+7IIi/6/dBsrLMqtrR4IsCkyJCDJRVNe2JsscT0y0S
         4ofoXN0A+Bw+A0h7WY+VOfRxbCZHtVRAzdPQMaSWfcxZzc6+9c0IqVSv/+NtxNPZoz
         6zUfAtAD/TxUwJDx1/XOX7yiwYeRNq8Uwf3LlwgFaxXEBhQo+E/R8TPZgneF93yLUk
         kCa3G91qnjctA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A1F0E1F666;
        Thu, 16 Nov 2023 12:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] indirect_call_wrapper: Fix typo in INDIRECT_CALL_$NR
 kerneldoc
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170013662329.21544.14620842715409880928.git-patchwork-notify@kernel.org>
Date:   Thu, 16 Nov 2023 12:10:23 +0000
References: <20231114104202.4680-1-tklauser@distanz.ch>
In-Reply-To: <20231114104202.4680-1-tklauser@distanz.ch>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 14 Nov 2023 11:42:02 +0100 you wrote:
> Fix a small typo in the kerneldoc comment of the INDIRECT_CALL_$NR
> macro.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  include/linux/indirect_call_wrapper.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] indirect_call_wrapper: Fix typo in INDIRECT_CALL_$NR kerneldoc
    https://git.kernel.org/netdev/net-next/c/3185d57cfcd3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



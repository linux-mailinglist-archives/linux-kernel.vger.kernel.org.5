Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD3B7E9570
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 04:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjKMDX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 22:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjKMDX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 22:23:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE0D171A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 19:23:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6862C433C8;
        Mon, 13 Nov 2023 03:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699845835;
        bh=VqlI6V6UDK+1aiZJekC3tQSbjeSQ5VfV9+YK49rsbMs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=S78uDK8PEcxXmhNF1+IUs9x1JiUfLWlrPNwnJRDmw+XcarralUkk+sM0dAR6rtIkj
         0CAPuMEud1aJqD2yXHZwZ3H9LzuhgLhx+40OLjFq1urEZjmqIO3m2LY+fOdeHzdiSX
         3w41e+hdNTQrPNlqQnn45EM1iMnziUCV6Nj0pAcewXZRq4qzxyBw2qniR3bZ4+25TP
         qdqNwvIU5gJnHesP28nME5HO7Zj8rV7CaQZWB/8PeSlqvpfLBWDBGaF4OIzB+9VvTc
         1JAbQEiovVkeKph9BI8XkAgUi+FVDLf7RbiP9uXyE9XMHFlJ0VwckVYYkQSl4Ke1B8
         FN02IYTYDCzgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9F6EE21ECC;
        Mon, 13 Nov 2023 03:23:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] platform/chrome: sensorhub: Fix typos
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169984583482.27851.14687037747834659717.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Nov 2023 03:23:54 +0000
References: <20231110165239.1559109-1-visitorckw@gmail.com>
In-Reply-To: <20231110165239.1559109-1-visitorckw@gmail.com>
To:     Kuan-Wei Chiu <visitorckw@gmail.com>
Cc:     bleung@chromium.org, tzungbi@kernel.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
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

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Sat, 11 Nov 2023 00:52:39 +0800 you wrote:
> Replace 'preceeds' with 'precedes' in the comment.
> Replace 'porod' with 'period' in the comment.
> Replace 'noone' with 'no one' in the comment.
> Replace 'lantency' with 'latency' in the comment.
> Replace 'kifo' with 'kfifo' in the comment.
> Replace 'change' with 'chance' in the comment.
> 
> [...]

Here is the summary with links:
  - [v2] platform/chrome: sensorhub: Fix typos
    https://git.kernel.org/chrome-platform/c/49e380795414

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



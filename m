Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8DA7B99D3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244450AbjJEB4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243717AbjJEB4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:56:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27439E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 18:56:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AD29C433C7;
        Thu,  5 Oct 2023 01:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696470968;
        bh=Ds7/7Qor00gfkfbVsC+TNH+U4huQ8fWDTvRydnVSLO4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ih6W11r29lo60oH0FY2wh03dJUw9ppcaFMzQIjkjEN3t8PYlWP5a1oQNmf3Uqvl8d
         rMYgc3uIC5sSGPDnoASMjCUSF2kxUozoGNV9Fke8KEFsxNjMGBaql090cngq5ma1yA
         VQb9AV85DE04nSKD03Xulo+gIP0l/3AUmXrtfP4LnSPrj8d6zD2vUx+Ib7115Yv647
         V6Wbda8tXBYr6cri2XjIC4eAqQShPDasCGH5qTEjWfItHkVFv0dzLA2LXQZV9lcmWM
         QO8XndgrMAygvr9kuG0ehlNnXCSKO+ThHY77jGL6iGPe867kMOyntElvoJcOSLVIOX
         nkgfCQxjJtzuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5415BE632D6;
        Thu,  5 Oct 2023 01:56:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] platform/chrome: Random driver cleanups
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169647096834.5479.6608928150859840412.git-patchwork-notify@kernel.org>
Date:   Thu, 05 Oct 2023 01:56:08 +0000
References: <20231003003429.1378109-1-swboyd@chromium.org>
In-Reply-To: <20231003003429.1378109-1-swboyd@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     bleung@chromium.org, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Mon,  2 Oct 2023 17:34:24 -0700 you wrote:
> Here's some random chromeos driver cleanups that have been sitting in my
> tree. I've noticed them while browsing the code for something I'm
> working on.
> 
> Stephen Boyd (4):
>   platform/chrome: cros_ec_typec: Use semi-colons instead of commas
>   platform/chrome: cros_ec_typec: Use dev_err_probe() more
>   platform/chrome: cros_typec_vdm: Mark port_amode_ops const
>   platform/chrome: cros_ec_proto: Mark outdata as const
> 
> [...]

Here is the summary with links:
  - [1/4] platform/chrome: cros_ec_typec: Use semi-colons instead of commas
    https://git.kernel.org/chrome-platform/c/a88f6ef67957
  - [2/4] platform/chrome: cros_ec_typec: Use dev_err_probe() more
    https://git.kernel.org/chrome-platform/c/2b055bf8ac84
  - [3/4] platform/chrome: cros_typec_vdm: Mark port_amode_ops const
    https://git.kernel.org/chrome-platform/c/14e7c01cc349
  - [4/4] platform/chrome: cros_ec_proto: Mark outdata as const
    https://git.kernel.org/chrome-platform/c/2f3dd39e2b49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



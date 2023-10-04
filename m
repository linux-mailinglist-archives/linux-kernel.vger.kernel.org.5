Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30857B76F3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 05:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjJDDu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 23:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjJDDu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 23:50:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC9EA7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 20:50:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14D57C433C9;
        Wed,  4 Oct 2023 03:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696391425;
        bh=c8Roab6aa9Nae1aAnyEzh4yR/xvaRHrM2IuA1++Ug9o=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uIvstt6XUR3m9oSUY4AxcHdpgIj1uw08/c9yoRls2YogQAYYdbvS4MLGylbBujL+L
         rJsCrtrkrr2cWxSWwvevVHgWK5MI+helumf4ImdML2KRc4WbCLzixKKwds0zTaSjOI
         f9ULWVP1kZmts/qUGdx9/C+ZtmMIyKrH1skeQ+vYpuX5H7/uzbYVguk/sv7Cjdrj4+
         IuSWEPZ8l2kVkdT/D8ktDFxTjlnx7VMoDRP9FxmXhZxMYu/977eyN8CLW9M0A2w9vt
         BCiJIBFvAw8NX1nh1nqOCP5/oT7aflzCocFedJi/kxb8S+J85NemOzoqJumUNzXNzD
         EGPsiRppbGJDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7C3BE632D2;
        Wed,  4 Oct 2023 03:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] platform/chrome: Random driver cleanups
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169639142493.18780.17059605384749460756.git-patchwork-notify@kernel.org>
Date:   Wed, 04 Oct 2023 03:50:24 +0000
References: <20231003003429.1378109-1-swboyd@chromium.org>
In-Reply-To: <20231003003429.1378109-1-swboyd@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     bleung@chromium.org, tzungbi@kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-kernelci)
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



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D5976ED57
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbjHCO5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbjHCO5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:57:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9158F198B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:57:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25BDE61DCB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 14:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44221C433C8;
        Thu,  3 Aug 2023 14:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691074653;
        bh=MeWPmk1wGBOuwAit0OPcjme6zfVDTHzZpHW2ooeAonM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NwIECPv5acxmR8ur4iAwDd5es8khEqorY9uZnQMFWpSn78CCnxsrW4ltOr0r6yO4e
         iTPFmkzVYDMn92nh4cZyGQK3yA9uUrLvF89WC8pTUFWSRVcJ4Y+ceeDdnpxvDoKJtm
         B2AKAA0xENL0MrNm3YW8PMGbfR1XGJC38/I6alFLS2entMG9jkOdtME+2lShNbXtHW
         sQYDlXlQWU/EK3wK/3CRZnyP/YfryAsrYc8cKqb5CBZLF9FsbJ7s/EWAwPNtjcUIfk
         UzAWkKSTIZ52ksdVLOi3++6MVCrn7uS8u9RAM9A2RFNB31uytnJLTq/Mym9kd3dcE9
         b0ULR/NCbflZQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Naresh Solanki <naresh.solanki@9elements.com>
Cc:     zev@bewilderbeest.net,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230803111225.107572-1-Naresh.Solanki@9elements.com>
References: <20230803111225.107572-1-Naresh.Solanki@9elements.com>
Subject: Re: [PATCH] regulator: userspace-consumer: Add regulator event
 support
Message-Id: <169107465198.74293.816114020132065204.b4-ty@kernel.org>
Date:   Thu, 03 Aug 2023 15:57:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Aug 2023 13:12:25 +0200, Naresh Solanki wrote:
> Add sysfs attribute to track regulator events received from regulator
> notifier block handler.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: userspace-consumer: Add regulator event support
      commit: 22475bcc2083196544fa55b861d76e0e7ee9da11

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


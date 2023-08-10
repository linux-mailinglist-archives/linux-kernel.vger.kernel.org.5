Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368877780D6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbjHJSzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbjHJSzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:55:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF8A2706
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:55:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E7366329F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 18:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934ACC433C8;
        Thu, 10 Aug 2023 18:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691693734;
        bh=bo8z/94vgFxt1I4cPk+N+mKay1IV/j1K+U63ow7+tMQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fhO/sFc3kQO/gaTzXXcpOzK7aHQHEEsahebOGp3RK06jwRBOp8EUp+xsjdDn01bG3
         BibNOLi7w2ewZPi1OUM9iwPi6ry2WRzqXpv+0ny+nAlnWVocorUsUJu18+Wfwe6ydG
         DgosgOy1I6/JU8zQ25WvW+ZaQV8uFmIeBATSmp95AgCMU+UityJ03mc3n1zn6dL8vk
         tDIQUIyNXXkA8cX/RrAXTtuKvBNeeQ0BVxVzpq99S2sOkqDsr6dR5/zI3JMS6MZ3pJ
         7U+II0myNiFDhg7by4Rj2uLYt3fUhnfXxARowEKYaMWOJvYPTxAWrLJAtGu9tiIbKP
         ZAHGuOzOVpUJA==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com,
        Yang Li <yang.lee@linux.alibaba.com>
Cc:     sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230810005555.4610-1-yang.lee@linux.alibaba.com>
References: <20230810005555.4610-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] ASoC: SOF: Intel: Remove duplicated include in
 lnl.c
Message-Id: <169169373231.701985.12095697416342525978.b4-ty@kernel.org>
Date:   Thu, 10 Aug 2023 19:55:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 08:55:55 +0800, Yang Li wrote:
> ./sound/soc/sof/intel/lnl.c: hda.h is included more than once.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: Remove duplicated include in lnl.c
      commit: 061599c8285848fe4ec64becb278dcdd60dd3369

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


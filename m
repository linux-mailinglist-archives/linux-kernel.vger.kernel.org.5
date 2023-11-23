Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2ADB7F649E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345276AbjKWRA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjKWRAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:00:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5BF10E9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:00:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712E7C433CA;
        Thu, 23 Nov 2023 17:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700758808;
        bh=zGd8DxX1wjCChLzUne6ijJYjDDvfRf0xhdz0NGOau8E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YuFMepwnkk1Ibv/ZBmbqWCCs12vo6vaJDeqmnjEUC+86kx0cM3RNA7ub58tJbDhbn
         Dy5FDpgrzCZxQU2wrFwjxPvHsOwNp+u1LSlBGJ1nuYPcS8k6CqZHYXPrCtPoBGW9Ql
         2FqtrnIYIAWr9J8GjDh+R5wLbY5UlFAC9exhti2D2qXdC9ampGxp/oTSBPqxK2GGSw
         jrP7UR7A9Et4XcPvvbeb93IkXA6vVKcshp3UyvG/G3QNLuIOzQNlVzkR4BiXROuAG5
         1shAK1QFDS8rtSFNVFOdISztpU5b0+504LUZuIGeOX4uuGu2JgbxHhyE07FsxlAgle
         MlvqzVtg7vzoQ==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com,
        perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com,
        trevor.wu@mediatek.com, tinghan.shen@mediatek.com,
        u.kleine-koenig@pengutronix.de, kuninori.morimoto.gx@renesas.com,
        sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com
In-Reply-To: <20231123084454.20471-1-angelogioacchino.delregno@collabora.com>
References: <20231123084454.20471-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] ASoC: SOF: mediatek: mt8186: Add Google Steelix
 topology compatible
Message-Id: <170075880330.2448402.15081642632125216155.b4-ty@kernel.org>
Date:   Thu, 23 Nov 2023 17:00:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 09:44:54 +0100, AngeloGioacchino Del Regno wrote:
> Add the machine compatible and topology filename for the Google Steelix
> MT8186 Chromebook to load the correct SOF topology file.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: mediatek: mt8186: Add Google Steelix topology compatible
      commit: 505c83212da5bfca95109421b8f5d9f8c6cdfef2

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


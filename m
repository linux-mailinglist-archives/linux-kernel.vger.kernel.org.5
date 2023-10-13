Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6A07C8BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjJMRHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJMRHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:07:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE64EB7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 10:07:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61657C433C7;
        Fri, 13 Oct 2023 17:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697216871;
        bh=skmjxOUJLbI5ygBC/KBxQoBx8cL7mS97WiCTqeCHlYw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=f6itFyHDrYdvbyZDsMDWGzFqb8O7C8l63+AVPb89k+uKG7H6Rvft++laXaoArqLyJ
         2+yq94fOPSwOcYFthT/z0U/qbCE6s5tOF7gHjzjFExqPTsaId1RsXf4lP5VQtUbxlW
         ExM2c1nJpmnh/3vOy7xDjDZZ3uQl9WdjlM3158a5p7G+FYQOKwI/QW8pMuBmqJdEZY
         0JxPZYEPAWkXzdmtaJkINQaASZCkyZ2edMrUp8iZeRMDrtUY6gtBYvlqfUnYzB9217
         8RXgih72ubhgM3RDJsApIUZwrPbuUaLzNEFifpBktdMPG34uc4G7kzzWHayp1AGg3s
         nS+G1QYVCljDg==
From:   Mark Brown <broonie@kernel.org>
To:     Roy Chateau <roy.chateau@mep-info.com>
Cc:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231013110239.473123-1-roy.chateau@mep-info.com>
References: <20231013110239.473123-1-roy.chateau@mep-info.com>
Subject: Re: [PATCH] ASoC: codecs: tas2780: Fix log of failed reset via
 I2C.
Message-Id: <169721687019.2968842.13695931645768185437.b4-ty@kernel.org>
Date:   Fri, 13 Oct 2023 18:07:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 13:02:39 +0200, Roy Chateau wrote:
> Correctly log failures of reset via I2C.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: tas2780: Fix log of failed reset via I2C.
      commit: 4e9a429ae80657bdc502d3f5078e2073656ec5fd

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


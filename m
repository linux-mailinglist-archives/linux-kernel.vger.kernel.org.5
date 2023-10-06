Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304017BBA2D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjJFOZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjJFOZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:25:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4636AA6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:25:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30237C433C8;
        Fri,  6 Oct 2023 14:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696602345;
        bh=fFp/oJMKykWY4xVvhpzOX11gmMZerHpy4oahhiXd2wk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pbYZJEoRoSPYLNTxz6IfxvbZuIMKICVmgeCUCSNc1zfT3hAaldOrh2N3vlBDBQK0f
         E3baf4THdKbMpu572Vm4ngiKWSAJwxAo9KZ9TjtrhgWidqHrQWL8Pyo6nNLsH/ZJeJ
         bfyu7VgJElz4ToYzpjdiDJ0rqftdTWbuHp/gPa7btqqHAysdHX+eP48kfwzgz428pT
         9mjAfFuH8fbBYl99dOIwGd7GPxFme9bdckMA6aglx29DaVhy3OW5m2nU1YddbsTDrm
         yD/D2RoUuJGbthvXmlvNmp39sJdX9lnS8REQZjGJm7SCxn3WPgXzW1hEG5JVDAjYtj
         K0ULWniGrdqEw==
From:   Mark Brown <broonie@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20231004193441.work.109-kees@kernel.org>
References: <20231004193441.work.109-kees@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Include additional ASoC paths
Message-Id: <169660234489.30982.2954706569529238887.b4-ty@kernel.org>
Date:   Fri, 06 Oct 2023 15:25:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Oct 2023 12:34:45 -0700, Kees Cook wrote:
> Make sure a few other paths are correctly sent to the ASoC maintainers.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: Include additional ASoC paths
      commit: 2175362f594bc8d3764c8108b1a0b88d0a56610a

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


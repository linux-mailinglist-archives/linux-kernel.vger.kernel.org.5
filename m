Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FC677DE05
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbjHPJ7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243670AbjHPJ6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:58:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8A026AB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:58:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 277EF65F03
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6A5C433C9;
        Wed, 16 Aug 2023 09:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692179920;
        bh=ABxJKFwm5wQaSdqS2nQJvALndRu5itzY3i0V3/6Lry4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=W8jmfFdqgrAMWK33ud5bxPzUR/kRl+lyt5A1HwafNZcvzqqZ6SjZoXowODOkNZfIj
         Ie+PVufbCQm66gWyFMow0gEEl4oL38mb72K2DU748s38L2Gm6NpChZSlgSd9zUi4dw
         q5YmS0+tBddm+YAZBSHCFTRqKmzA2hcN0Y2r3KJ/vEhzvFn9YvmdQV4Igikib0Q5gq
         BcUoEZwiPpb8EcjN0sqrblUeD68zKupdvajE8UgJ/f+PrVWVn2aADC0NL0qkeEZ8/j
         UKovEbJfP6Ea5XH2YIp7qP5QNYhIX7xVUUdJZrWloCGxGeL9fWA8eS/9E+RArr5H0a
         FIeNE5pJXKm9Q==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, Yue Haibing <yuehaibing@huawei.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230728132439.31568-1-yuehaibing@huawei.com>
References: <20230728132439.31568-1-yuehaibing@huawei.com>
Subject: Re: (subset) [PATCH -next] mfd: ab8500: Remove unused extern
 declarations
Message-Id: <169217991967.820562.2148325349696766937.b4-ty@kernel.org>
Date:   Wed, 16 Aug 2023 10:58:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 21:24:39 +0800, Yue Haibing wrote:
> commit d28f1db8187d ("mfd: Remove confusing ab8500-i2c file and merge into ab8500-core")
> left behind this.
> 
> 

Applied, thanks!

[1/1] mfd: ab8500: Remove unused extern declarations
      commit: ecce60f7c81b0b4d4c50c24a763912cfd7733258

--
Lee Jones [李琼斯]


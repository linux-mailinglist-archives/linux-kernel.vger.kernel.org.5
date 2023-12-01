Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30932800977
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378491AbjLALOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378442AbjLALOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:14:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4091A4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 03:14:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B319C433C9;
        Fri,  1 Dec 2023 11:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701429254;
        bh=OdzoVebDs7gSdJjM+MmGQrpOk9Ze++QAhPVoPuuGU1k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IQaau0mdxsNM12uO+lcCAhGYbIw4GtwNSFzKew/Owrh11L1GUik+55cJsxWR6wUrp
         Qv5Aan4do5nb8j/jwyXtbktfGZ6MJXsLZkl5CddkPYwLTYueRfM16vHFQF6A+94HcR
         I19e9TZy/a7sVok3hrTXCIr1sn+E2u2+Yb4Arm8iDeYxIjz7BcwBSQciP3u4GogBtV
         xPgjDBWFVx1/1fRxxlyCHc/9Mdc9RNjX9fPbp9waVubILxFpl1QLBFo/b1L1BEOv/H
         Pw9MuRVoKKaO2SmiT93IToz3Vbqw6PUIrRunZNyU3+/3XK0OwQ9LRFJ6zGqARhV388
         JoKPkjn2TXJmQ==
From:   Lee Jones <lee@kernel.org>
To:     cw00.choi@samsung.com, krzysztof.kozlowski@linaro.org,
        lee@kernel.org, linux-kernel@vger.kernel.org,
        zhongkaihua <zhongkaihua@kylinos.cn>
Cc:     huangwei@kylinos.cn, zhang.chen@cs2c.com.cn,
        k2ci <kernel-bot@kylinos.cn>
In-Reply-To: <20231129015526.3302865-1-zhongkaihua@kylinos.cn>
References: <20231129015526.3302865-1-zhongkaihua@kylinos.cn>
Subject: Re: (subset) [PATCH] mfd: fix comment typos
Message-Id: <170142925181.3367050.2594131835189756038.b4-ty@kernel.org>
Date:   Fri, 01 Dec 2023 11:14:11 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 09:55:26 +0800, zhongkaihua wrote:
> Fix four comment typos in mfd pmic header files.
> 
> 

Applied, thanks!

[1/1] mfd: fix comment typos
      commit: 37e0d13c07b761c40dc9c900cea7649fcd1b661e

--
Lee Jones [李琼斯]

